import Foundation



public extension FileManager {
  func document(named: String) throws -> URL {
    guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
      throw Unexpected.missingDocumentDirectory
    }
    return url.appendingPathComponent(named)
  }
}
