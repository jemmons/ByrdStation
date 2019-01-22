import Foundation
import CoreData



public enum ManageableHelper {}



public extension ManageableHelper {
  static func resultsController<T>(context: NSManagedObjectContext, fetchRequest: NSFetchRequest<T>, delegate: NSFetchedResultsControllerDelegate?) -> NSFetchedResultsController<T> where T: NSFetchRequestResult{
    let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    frc.delegate = delegate
    return frc
  }
  
  
  static func insert<T>(name: String, into context: NSManagedObjectContext) -> T where T: NSManagedObject{
    return NSEntityDescription.insertNewObject(forEntityName: name, into: context) as! T
  }
}
