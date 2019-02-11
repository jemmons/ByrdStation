import Foundation
import CoreData



public extension Bundle {
  static func model(named: String, for anyClass: AnyClass) throws -> NSManagedObjectModel {
    let bundle = Bundle(for: anyClass)
    guard let url = bundle.url(forResource: named, withExtension: "momd") else {
      throw Missing.model(name: named, bundle: bundle)
    }
    guard let model = NSManagedObjectModel(contentsOf: url) else {
      throw Invalid.model(path: url)
    }
    return model
  }
}
