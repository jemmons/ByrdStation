import Foundation
import CoreData



public class SQLiteContainer {
  private let name: String
  private let model: NSManagedObjectModel


  private var container: NSPersistentContainer?
  private var establishedPath: URL?
  
  
  public init(name: String, model: NSManagedObjectModel) {
    self.name = name
    self.model = model
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
    try establish(isWritable: isWritable, storeURL: FileManager.default.document(named: name).appendingPathExtension("sqlite"))
  }
  
  
  public func establish(isWritable: Bool, storeURL: URL) throws {
    guard container == nil else {
      #warning("Empty error")
      throw NSError()
    }
    let newContainer = NSPersistentContainer(name: name, managedObjectModel: model)
    newContainer.persistentStoreDescriptions = [
      Helper.makeSyncSQLDescription(url: storeURL, isWritable: isWritable)
    ]
    try Helper.syncLoadStore(of: newContainer)
    
    establishedPath = storeURL
    container = newContainer
  }
  
  
  public func save() throws {
    if context.hasChanges {
      try context.save()
    }
  }
  
  
  public func delete() throws {
    guard let path = establishedPath else {
      #warning("Empty error")
      throw NSError()
    }
    try FileManager.default.removeItem(at: path)
  }
}



private enum Helper {
  static func makeSyncSQLDescription(url: URL, isWritable: Bool) -> NSPersistentStoreDescription {
    let storeDescription = NSPersistentStoreDescription(url: url)
    storeDescription.type = NSSQLiteStoreType
    storeDescription.isReadOnly = !isWritable
    storeDescription.shouldAddStoreAsynchronously = false
    return storeDescription
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
}
