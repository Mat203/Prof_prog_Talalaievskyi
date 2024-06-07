import Foundation

class LegacyCalculator {
    private var megaDelta: Double
    private var megaMultiplier: Double
    
    init(megaDelta: Double, megaMultiplier: Double) {
        self.megaDelta = megaDelta
        self.megaMultiplier = megaMultiplier
    }
    
    func calculatePricePart1() -> Double {
        return 6.0 - megaDelta
    }
    
    func calculatePricePart2() -> Double {
        return 13.0 * megaMultiplier + 1 - megaDelta
    }
    
    func getOurTheMostAndMinimalValue() -> Double {
        return megaDelta * megaMultiplier
    }
    
    func getSomeDocumentRepresentation() -> String {
        return "The man \(6.0 - megaDelta) who sold the \(megaMultiplier * 13.0) world"
    }
}
