import XCTest

func calculateValue(x: Double, y: Double, z: Double) -> Double {
    let product = x * y * z

    if product != 0 {
        return 1 / product
    } else {
        let sum = x + y + z

        if sum != 0 {
            return 1 / sum
        } else {
            return x + (y + 1) * (z - 1)
        }
    }
}

class CalculateValueTests: XCTestCase {

    func testNonZeroProduct() {
        let x = 2.0
        let y = 3.0
        let z = 4.0
        let expectedResult = 1 / (x * y * z)
        let result = calculateValue(x: x, y: y, z: z)
        XCTAssertEqual(result, expectedResult, accuracy: 0.00001)
    }

    func testZeroProductNonZeroSum() {
        let x = 2.0
        let y = -1.0
        let z = -2.0
        let expectedResult = 1 / (x + y + z)
        let result = calculateValue(x: x, y: y, z: z)
        XCTAssertEqual(result, expectedResult, accuracy: 0.00001)
    }

    func testZeroProductZeroSum() {
        let x = 2.0
        let y = -1.0
        let z = -1.0
        let expectedResult = x + (y + 1) * (z - 1)
        let result = calculateValue(x: x, y: y, z: z)
        XCTAssertEqual(result, expectedResult, accuracy: 0.00001)
    }

    func testAllNegativeNumbers() {
        let x = -2.0
        let y = -3.0
        let z = -4.0
        let expectedResult = 1 / (x * y * z)
        let result = calculateValue(x: x, y: y, z: z)
        XCTAssertEqual(result, expectedResult, accuracy: 0.00001)
    }

    func testZeroProduct() {
        let x = 2.0
        let y = 0.0
        let z = 4.0
        let expectedResult = 1 / (x + y + z)
        let result = calculateValue(x: x, y: y, z: z)
        XCTAssertEqual(result, expectedResult, accuracy: 0.00001)
    }
}
