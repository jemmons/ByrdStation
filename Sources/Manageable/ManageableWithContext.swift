import Foundation
import CoreData



public protocol ProvidesInternalContext {
  static var _internalContext: NSManagedObjectContext { get }
}



public extension Manageable where Self: ProvidesInternalContext {
  static func resultsController(delegate: NSFetchedResultsControllerDelegate?) -> NSFetchedResultsController<Self> {
    return resultsController(context: _internalContext, delegate: delegate)
  }
}



public extension Manageable where Self: ProvidesInternalContext, Self: NSManagedObject {
  @discardableResult
  static func insert() -> Self {
    return insert(context: _internalContext)
  }
}
