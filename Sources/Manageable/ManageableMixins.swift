import Foundation
import CoreData



public extension Manageable {
  static func request(descriptors: [NSSortDescriptor] = defaultSortDescriptors) -> NSFetchRequest<Self> {
    let request = NSFetchRequest<Self>(entityName: entityName)
    request.sortDescriptors = descriptors
    return request
  }
  
  
  static func resultsController<T>(fetchRequest: NSFetchRequest<T>, context moc: NSManagedObjectContext, delegate: NSFetchedResultsControllerDelegate?) -> NSFetchedResultsController<T> where T: NSFetchRequestResult{
    let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
    frc.delegate = delegate
    return frc
  }
  
  
  @discardableResult static func insert<T>(name: String, context moc: NSManagedObjectContext) -> T where T: NSManagedObject{
    return NSEntityDescription.insertNewObject(forEntityName: name, into: moc) as! T
  }
}
