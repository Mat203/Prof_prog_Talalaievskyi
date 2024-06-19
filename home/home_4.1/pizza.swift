import Foundation

struct Ingredient {
    let name: String
    let price: Double
}

class Pizza {
    private var ingredients: [Ingredient] = []
    private var total_price: Double = 0.0

    func addIngredient(_ ingredient: Ingredient) {
        ingredients.append(ingredient)
        total_price += ingredient.price
    }

    func getTotalPrice() -> Double {
        return total_price
    }

    func getIngredients() -> [Ingredient] {
        return ingredients
    }
}

class PizzaBuilder {
    private var ingredients: [String: Ingredient] = [:]
    private var ingredientsFile: String

    init(ingredientsFile: String) {
        self.ingredientsFile = ingredientsFile
        loadIngredients()
    }

    private func loadIngredients() {
        let fileURL = URL(fileURLWithPath: ingredientsFile)
        do {
            let data = try String(contentsOf: fileURL, encoding: .utf8)
            let lines = data.split(separator: "\n")
            for line in lines {
                let parts = line.split(separator: ",")
                if parts.count == 2 {
                    let name = String(parts[0])
                    if let price = Double(parts[1]) {
                        ingredients[name] = Ingredient(name: name, price: price)
                    }
                }
            }
        } catch {
            print("Error loading ingredients from file: \(error)")
        }
    }

    func buildClassicPizza(type: String) -> Pizza? {
        let classicPizzas = getClassicPizzaOptions()
        guard let classicIngredients = classicPizzas[type] else {
            return nil
        }

        let pizza = Pizza()
        for ingredient in classicIngredients {
            pizza.addIngredient(ingredient)
        }
        return pizza
    }

    func buildCustomPizza() -> Pizza {
        let pizza = Pizza()
        printAvailableIngredients()
        
        while true {
            print("Enter ingredient name (or 'done' to finish): ", terminator: "")
            guard let input = readLine(), !input.isEmpty else {
                continue
            }
            if input.lowercased() == "done" {
                break
            }

            if let ingredient = ingredients[input] {
                pizza.addIngredient(ingredient)
            } else {
                print("Invalid ingredient name. Please choose from the list.")
            }
        }

        return pizza
    }

    func getClassicPizzaOptions() -> [String: [Ingredient]] {
        return [
            "Margherita": [
                Ingredient(name: "Tomato", price: 1.5),
                Ingredient(name: "Cheese", price: 2.0)
            ],
            "Pepperoni": [
                Ingredient(name: "Tomato", price: 1.5),
                Ingredient(name: "Cheese", price: 2.0),
                Ingredient(name: "Pepperoni", price: 2.5)
            ],
            "Vegetarian": [
                Ingredient(name: "Tomato", price: 1.5),
                Ingredient(name: "Cheese", price: 2.0),
                Ingredient(name: "Mushroom", price: 1.0),
                Ingredient(name: "Bell Pepper", price: 1.0)
            ]
        ]
    }

    private func printAvailableIngredients() {
        print("Available ingredients:")
        for (name, ingredient) in ingredients {
            print("\(name): \(ingredient.price)")
        }
    }
}