import Foundation
import CoreData



public protocol ProvidesInternalContext {
  static var _internalContext: NSManagedObjectContext { get }
}



public extension Manageable where Self: ProvidesInternalContext {
  static func resultsController<T>(fetchRequest: NSFetchRequest<T>, delegate: NSFetchedResultsControllerDelegate?) -> NSFetchedResultsController<T> where T: NSFetchRequestResult{
    return resultsController(fetchRequest: fetchRequest, context: _internalContext, delegate: delegate)
  }
  
  
  @discardableResult static func insert<T>(name: String) -> T where T: NSManagedObject{
    return insert(name: name, context: _internalContext)
  }
}
