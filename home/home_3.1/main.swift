func calculateValue(x: Double, y: Double, z: Double) -> Double {
    let product = x * y * z

    if product != 0 {
        return 1 / product
    }

    let sum = x + y + z
    if sum != 0 {
        return 1 / sum
    }

    return x + (y + 1) * (z - 1)
}

func main() {
    let x = 2.0
    let y = 3.0
    let z = 4.0

    let result = calculateValue(x: x, y: y, z: z)

    print(result)
}

main()
