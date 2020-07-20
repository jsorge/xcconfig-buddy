import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(xcconfig_buddyTests.allTests),
    ]
}
#endif
