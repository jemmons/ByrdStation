import Foundation
import CoreData



public class SQLiteContainer<BundleClass> where BundleClass: AnyObject {
  private var container: NSPersistentContainer?
  private let modelName: String
  
  
  public init(_ modelName: String) {
    self.modelName = modelName
  }
}



public extension SQLiteContainer {
  var context: NSManagedObjectContext {
    guard let someContainer = container else {
      fatalError("ByrdStation: Attempted to access an unestablished container.")
    }
    return someContainer.viewContext
  }
}



extension SQLiteContainer: Container {
  public func establish(isWritable: Bool) throws {
    try establish(isWritable: isWritable, storeURL: nil)
  }
  
  
  public func establish(isWritable: Bool, storeURL: URL?) throws {
    guard container == nil else {
      throw NSError()
    }
    let description = Helper.makeSyncSQLDescription(name: modelName, url: storeURL, isWritable: isWritable)
    let modelPath = try Helper.modelPath(name: modelName, bundleClass: BundleClass.self)
    let newContainer = try Helper.makeContainer(name: modelName, modelPath: modelPath, description: description)
    try Helper.syncLoadStore(of: newContainer)
    container = newContainer
  }
  
  
  public func save() throws {
    if context.hasChanges {
      try context.save()
    }
  }
}



private enum Helper {
  static func modelPath(name: String, bundleClass: AnyClass) throws -> URL {
    guard let url = Bundle(for: bundleClass.self).url(forResource: name, withExtension: "momd") else {
      throw NSError()
    }
    return url
  }
  
  
  static func makeSyncSQLDescription(name: String, url: URL?, isWritable: Bool) -> NSPersistentStoreDescription {
    let storeDescription = NSPersistentStoreDescription(url: url ?? makeDocumentURL(name: name))
    storeDescription.type = NSSQLiteStoreType
    storeDescription.isReadOnly = !isWritable
    storeDescription.shouldAddStoreAsynchronously = false
    return storeDescription
  }
  
  
  static func makeContainer(name: String, modelPath: URL, description: NSPersistentStoreDescription) throws -> NSPersistentContainer {
    guard let mom = NSManagedObjectModel(contentsOf: modelPath) else {
      throw NSError()
    }
    let container = NSPersistentContainer(name: name, managedObjectModel: mom)
    container.persistentStoreDescriptions = [description]
    return container
  }
  
  
  static func syncLoadStore(of container: NSPersistentContainer) throws {
    var error: Error?
    
    let group = DispatchGroup()
    group.enter()
    container.loadPersistentStores { _, e in
      error = e
      group.leave()
    }
    group.wait()
    
    if let e = error {
      throw e
    }
  }
  
  
  private static func makeDocumentURL(name: String) -> URL {
    guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
      fatalError("Unable to find document directory.")
    }
    return url.appendingPathComponent("\(name).sqlite")
  }
}
