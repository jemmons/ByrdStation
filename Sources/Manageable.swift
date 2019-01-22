import Foundation
import CoreData



public protocol Manageable: NSFetchRequestResult {
  static var entityName: String { get }
  static var defaultSortDescriptors: [NSSortDescriptor] { get }
  static func resultsController(fetchRequest: NSFetchRequest<Self>, delegate: NSFetchedResultsControllerDelegate?) -> NSFetchedResultsController<Self>
  @discardableResult static func insert() -> Self
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



public extension Manageable where Self: NSManagedObject {
  static var entityName: String {
    guard let name = entity().name else {
      fatalError("Expected an entity name for “\(String(describing: self))”.")
    }
    return name
  }
}
