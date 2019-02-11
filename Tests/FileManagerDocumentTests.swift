import Foundation
import XCTest
import BlueLine
import ByrdStation



class FileManagerDocumentTests: XCTestCase {
  func testDocumentPath() {
    let subject = try! FileManager.default.document(named: "name.extension")
    EQ(subject.lastPathComponent, "name.extension")
    EQ(subject.deletingLastPathComponent().lastPathComponent, "Documents")
  }
}
