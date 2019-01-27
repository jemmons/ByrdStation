import Foundation
import CoreData



public protocol Manageable: NSFetchRequestResult {
  static var entityName: String { get }
  static var defaultSortDescriptors: [NSSortDescriptor] { get }
}



public extension Manageable {
  static var defaultSortDescriptors: [NSSortDescriptor] {
    return []
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
