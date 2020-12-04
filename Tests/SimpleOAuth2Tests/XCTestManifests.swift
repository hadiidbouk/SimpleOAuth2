import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SimpleOAuth2Tests.allTests),
    ]
}
#endif
