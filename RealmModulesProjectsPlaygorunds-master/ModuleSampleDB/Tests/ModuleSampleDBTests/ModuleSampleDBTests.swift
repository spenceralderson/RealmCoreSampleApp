    import XCTest
    @testable import ModuleSampleDB

    final class ModuleSampleDBTests: XCTestCase {
        func testExample() throws {
            // This is an example of a functional test case.
            // Use XCTAssert and related functions to verify your tests produce the correct
            // results.


            let key = try Test.addTestObject(ofName: "Maria")
            let object = Test.getObject(ofType: CopyObject.self, forPrimaryKey: key)
            XCTAssertNotNil(object)
            XCTAssertEqual(object.name, "Maria")
        }
    }
