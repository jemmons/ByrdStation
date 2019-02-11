import XCTest
import CoreData
import ByrdStation
import BlueLine


class SQLiteContainerTests: XCTestCase {
  lazy var model: NSManagedObjectModel = try! Bundle.model(named: "TestModel", for: type(of: self))
  let tempURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true).appendingPathComponent("temp.sqlite")
  
  
  override func setUp() {
    try? FileManager.default.removeItem(at: tempURL)
  }
  
  
  func testCreation() {
    let container = SQLiteContainer(name: "Test Name", model: model)
    NOTNIL(container)
  }
  
  
  func testEstablish() {
    F(FileManager.default.fileExists(atPath: tempURL.path))
    let container = SQLiteContainer(name: "Test Name", model: model)
    try! container.establish(isWritable: true, storeURL: tempURL)
    T(FileManager.default.fileExists(atPath: tempURL.path))
    try! FileManager.default.removeItem(at: tempURL)
  }
}
