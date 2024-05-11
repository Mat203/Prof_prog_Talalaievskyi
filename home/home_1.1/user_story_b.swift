import Foundation

func quadraticRoots(a: Double, b: Double, c: Double) -> (Double, Double)? {
    let discriminant = b * b - 4 * a * c
    if discriminant > 0 {
        let root1 = (-b + sqrt(discriminant)) / (2 * a)
        let root2 = (-b - sqrt(discriminant)) / (2 * a)
        return (root1, root2)
    } else if discriminant == 0 {
        let root = -b / (2 * a)
        return (root, root)
    } else {
        return nil
    }
}

func main() {
    print("Quadratic Equation Solver")
    print("-------------------------")

    print("Enter coefficients (a b c separated by a space):")
    if let input = readLine() {
        let coefficients = input.split(separator: " ").map(String.init)
        if coefficients.count == 3, let coefficientA = Double(coefficients[0]), let coefficientB = Double(coefficients[1]), let coefficientC = Double(coefficients[2]) {
            if let roots = quadraticRoots(a: coefficientA, b: coefficientB, c: coefficientC) {
                print("Roots:", roots)
            } else {
                print("No real roots -- negative discriminant (Yes they are exist but they are complex)")
            }
        } else {
            print("Error: Three numerical coefficients separated by spaces must be provided.")
        }
    } else {
        print("Error: Unable to read input.")
    }
}

main()
