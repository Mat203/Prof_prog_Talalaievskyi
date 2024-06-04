// Triangle.swift
import Foundation

enum TriangleError: Error {
    case invalidSides
    case invalidSideArgument
}

class Triangle {
    var a: Double
    var b: Double
    var c: Double
    
    init(a: Double, b: Double, c: Double) throws {
        guard a > 0, b > 0, c > 0 else {
            throw TriangleError.invalidSides
        }
        
        guard (a + b > c) && (a + c > b) && (b + c > a) else {
            throw TriangleError.invalidSides
        }
        
        self.a = a
        self.b = b
        self.c = c
    }
    
    func calculateArea() -> Double {
        let s = (a + b + c) / 2.0
        return sqrt(s * (s - a) * (s - b) * (s - c))
    }
    
    func calculateHeight(forSide side: String) throws -> Double {
            let area = calculateArea()
            
            switch side {
            case "a":
                return (2 * area) / a
            case "b":
                return (2 * area) / b
            case "c":
                return (2 * area) / c
            default:
                throw TriangleError.invalidSideArgument
            }
        }
}
