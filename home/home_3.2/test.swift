// TriangleTests.swift
import XCTest

class TriangleTests: XCTestCase {
    
    func testValidTriangle() {
        do {
            let triangle = try Triangle(a: 3.0, b: 4.0, c: 5.0)
            let area = triangle.calculateArea()
            XCTAssertEqual(area, 6.0, accuracy: 0.0001)
        } catch {
            XCTFail("Unexpected error thrown")
        }
    }
    
    func testInvalidTriangleSides() {
        XCTAssertThrowsError(try Triangle(a: 1.0, b: 2.0, c: 3.0)) { error in
            XCTAssertEqual(error as? TriangleError, TriangleError.invalidSides)
        }
    }
    
    func testNegativeSides() {
        XCTAssertThrowsError(try Triangle(a: -1.0, b: 2.0, c: 2.0)) { error in
            XCTAssertEqual(error as? TriangleError, TriangleError.invalidSides)
        }
    }
    func testHeightForSideA() {
           do {
               let triangle = try Triangle(a: 3.0, b: 4.0, c: 5.0)
               let heightA = try triangle.calculateHeight(forSide: "a")
               XCTAssertEqual(heightA, 4.0, accuracy: 0.0001)
           } catch {
               XCTFail("Unexpected error thrown")
           }
       }
       
       func testHeightForSideB() {
           do {
               let triangle = try Triangle(a: 3.0, b: 4.0, c: 5.0)
               let heightB = try triangle.calculateHeight(forSide: "b")
               XCTAssertEqual(heightB, 3.0, accuracy: 0.0001)
           } catch {
               XCTFail("Unexpected error thrown")
           }
       }
       
       func testHeightForSideC() {
           do {
               let triangle = try Triangle(a: 3.0, b: 4.0, c: 5.0)
               let heightC = try triangle.calculateHeight(forSide: "c")
               XCTAssertEqual(heightC, 2.4, accuracy: 0.0001)
           } catch {
               XCTFail("Unexpected error thrown")
           }
       }
       
       func testInvalidSideArgument() {
           do {
               let triangle = try Triangle(a: 3.0, b: 4.0, c: 5.0)
               XCTAssertThrowsError(try triangle.calculateHeight(forSide: "d")) { error in
                   XCTAssertEqual(error as? TriangleError, TriangleError.invalidSideArgument)
               }
           } catch {
               XCTFail("Unexpected error thrown")
           }
       }
}

