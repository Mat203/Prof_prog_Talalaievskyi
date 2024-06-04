import XCTest

class CalculateValueTests: XCTestCase {
    private let doubleComparisonAccuracy = 0.00001

    func testNonZeroProduct() {
        let x = 2.0
        let y = 3.0
        let z = 4.0
        let expectedResult = 0.04166666666
        let result = calculateValue(x: x, y: y, z: z)
        XCTAssertEqual(result, expectedResult, accuracy: doubleComparisonAccuracy)
    }

    func testZeroProductNonZeroSum() {
        let x = 2.0
        let y = -1.0
        let z = -2.0
        let expectedResult = 0.25
        let result = calculateValue(x: x, y: y, z: z)
        XCTAssertEqual(result, expectedResult, accuracy: doubleComparisonAccuracy)
    }

    func testZeroProductZeroSum() {
        let x = 2.0
        let y = -1.0
        let z = -1.0
        let expectedResult = 0.5
        let result = calculateValue(x: x, y: y, z: z)
        XCTAssertEqual(result, expectedResult, accuracy: doubleComparisonAccuracy)
    }

    func testAllNegativeNumbers() {
        let x = -2.0
        let y = -3.0
        let z = -4.0
        let expectedResult = -0.04166666666
        let result = calculateValue(x: x, y: y, z: z)
        XCTAssertEqual(result, expectedResult, accuracy: doubleComparisonAccuracy)
    }

    func testZeroProduct() {
        let x = 2.0
        let y = 0.0
        let z = 4.0
        let expectedResult = 0.16666666666
        let result = calculateValue(x: x, y: y, z: z)
        XCTAssertEqual(result, expectedResult, accuracy: doubleComparisonAccuracy)
    }
}
