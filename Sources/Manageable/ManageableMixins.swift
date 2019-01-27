import Foundation
import CoreData



public extension Manageable {
  static func request(descriptors: [NSSortDescriptor] = defaultSortDescriptors) -> NSFetchRequest<Self> {
    let request = NSFetchRequest<Self>(entityName: entityName)
    request.sortDescriptors = descriptors
    return request
  }
  
  
  static func resultsController(context moc: NSManagedObjectContext, delegate: NSFetchedResultsControllerDelegate?) -> NSFetchedResultsController<Self> {
    let frc = NSFetchedResultsController(fetchRequest: request(), managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
    frc.delegate = delegate
    return frc
  }
}



public extension Manageable where Self: NSManagedObject {
  @discardableResult static func insert(context moc: NSManagedObjectContext) -> Self {
    return NSEntityDescription.insertNewObject(forEntityName: entityName, into: moc) as! Self
  }
}
