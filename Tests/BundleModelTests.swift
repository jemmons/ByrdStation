import Foundation
import XCTest
import ByrdStation
import BlueLine



class BundleModelTests: XCTestCase {
  func testMissingModel() {
    let expectedMissingError = expectation(description: "Waiting to throw missing error")
    do {
      _ = try Bundle.model(named: "Foo", for: type(of: self))
    } catch let Missing.model(name, _) {
      EQ(name, "Foo")
      expectedMissingError.fulfill()
    } catch {
      XCTFail()
    }
    
    wait(for: [expectedMissingError], timeout: 0)
  }
  
  
  func testInvalidModel() {
    let expectedInvalidError = expectation(description: "Waiting to throw invalid error")
    do {
      _ = try Bundle.model(named: "InvalidModel", for: type(of: self))
    } catch let Invalid.model(url) {
      EQ(url.lastPathComponent, "InvalidModel.momd")
      expectedInvalidError.fulfill()
    } catch {
      XCTFail()
    }
    
    wait(for: [expectedInvalidError], timeout: 0)
  }
  
  
  func testLoadingModel() {
    let subject = try! Bundle.model(named: "TestModel", for: type(of: self))
    NOTNIL(subject)
    T(subject.entities.contains { $0.name == "TestEntity" })
  }
}
