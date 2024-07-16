import Foundation

protocol PricedItem {
    func getCoefficient() -> Double
    func getBasePrice() -> Double
}

struct PricePresenter<Priority: BinaryInteger> {
    let priority: Priority

    func printTotalPrice<T1: PricedItem, T2: PricedItem>(_ obj1: T1, _ obj2: T2) {
        let totalPrice = Double(priority) * obj1.getCoefficient() * obj1.getBasePrice() +
                         obj2.getCoefficient() * obj2.getBasePrice()
        print("Total Price: \(totalPrice)")
    }
}

class Milk: PricedItem {
    func getCoefficient() -> Double {
        return 1.2
    }

    func getBasePrice() -> Double {
        return 3.5
    }
}

class Cookies: PricedItem {
    func getCoefficient() -> Double {
        return 1.5
    }

    func getBasePrice() -> Double {
        return 4.0
    }
}

class Pineapple: PricedItem {
    func getCoefficient() -> Double {
        return 2.0
    }

    func getBasePrice() -> Double {
        return 5.5
    }
}

func main() {
    let presenter = PricePresenter(priority: 2)

    let milk = Milk()
    let cookies = Cookies()
    let pineapple = Pineapple()

    presenter.printTotalPrice(milk, cookies)
    presenter.printTotalPrice(cookies, pineapple)
    presenter.printTotalPrice(milk, pineapple)
}

main()
