import Foundation
import CoreData



public protocol Manageable: NSFetchRequestResult {
  static var entityName: String { get }
  static var defaultSortDescriptors: [NSSortDescriptor] { get }
}



public protocol ProvidesContext {
  static var context: NSManagedObjectContext { get }
}



public extension Manageable {
  static var defaultSortDescriptors: [NSSortDescriptor] {
    return []
  }
  
  
  static func request(descriptors: [NSSortDescriptor] = defaultSortDescriptors) -> NSFetchRequest<Self> {
    let request = NSFetchRequest<Self>(entityName: entityName)
    request.sortDescriptors = descriptors
    return request
  }
}



public extension Manageable where Self: ProvidesContext {
  static func resultsController<T>(fetchRequest: NSFetchRequest<T>, delegate: NSFetchedResultsControllerDelegate?) -> NSFetchedResultsController<T> where T: NSFetchRequestResult{
    let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    frc.delegate = delegate
    return frc
  }
  
  
  @discardableResult static func insert<T>(name: String) -> T where T: NSManagedObject{
    return NSEntityDescription.insertNewObject(forEntityName: name, into: context) as! T
  }
}



public extension Manageable where Self: NSManagedObject {
  static var entityName: String {
    guard let name = entity().name else {
      fatalError("Expected an entity name for “\(String(describing: self))”.")
    }
    return name
  }
}
