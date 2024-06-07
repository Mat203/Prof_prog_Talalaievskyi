import Foundation

func printResults(calculator: BaseMegaCalculator) {
    print("Current price: \(calculator.getPrice())")
    print("Current minimal value: \(calculator.getMinimalValue())")
    print("Current report: \(calculator.getReport())")
}

func main() {
    var calculator: BaseMegaCalculator = MyCoolCalculator(coef1: 6.0, coef2: 12.1, coef3: 3.2)
    printResults(calculator: calculator)
    
    calculator = ConstantCalculator()
    printResults(calculator: calculator)
    
    calculator = MegaAdapter(legacyCalculator: LegacyCalculator(megaDelta: 1.34, megaMultiplier: 5.4))
    printResults(calculator: calculator)
    
    // EXAMPLE OF ADAPTER USAGE
    let jsonAdapter = JSONDataAdapter(jsonProvider: JSONDataProvider())
    let xmlAdapter = XMLDataAdapter(xmlProvider: XMLDataProvider())

    print(jsonAdapter.getData())
    print(xmlAdapter.getData())
}

main()
