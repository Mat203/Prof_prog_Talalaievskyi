import Foundation

let ingredientsFilePath = "/Users/matvii/Desktop/SampleProject/Project/Test/ingredients.txt"
let classicCommand = "classic"
let customCommand = "custom"

func main() {
    let builder = PizzaBuilder(ingredientsFile: ingredientsFilePath)

    let choice = promptUserForChoice()
    
    if choice == classicCommand {
        handleClassicPizzaChoice(builder: builder)
    } else if choice == customCommand {
        handleCustomPizzaChoice(builder: builder)
    } else {
        print("Invalid choice.")
    }
}

func promptUserForChoice() -> String {
    print("Do you want to choose a classic pizza or compose a custom one? (\(classicCommand)/\(customCommand)): ", terminator: "")
    return readLine()?.lowercased() ?? ""
}

func handleClassicPizzaChoice(builder: PizzaBuilder) {
    let classicPizzas = builder.getClassicPizzaOptions()
    print("Available classic pizzas:")
    for (name, _) in classicPizzas {
        print(name)
    }

    print("Enter the name of the classic pizza you want: ", terminator: "")
    guard let pizzaChoice = readLine(), let classicIngredients = classicPizzas[pizzaChoice] else {
        print("Invalid choice.")
        return
    }

    let pizza = builder.buildPizza()
    for ingredient in classicIngredients {
        pizza.addIngredient(ingredient)
    }

    printPizzaDetails(pizza: pizza, pizzaType: pizzaChoice)
}

func handleCustomPizzaChoice(builder: PizzaBuilder) {
    let pizza = builder.buildPizza()
    print("Available ingredients:")
    for ingredientName in builder.getAvailableIngredients() {
        print(ingredientName)
    }

    while true {
        print("Enter ingredient name (or 'done' to finish): ", terminator: "")
        guard let input = readLine(), !input.isEmpty else {
            continue
        }
        if input.lowercased() == "done" {
            break
        }

        if !builder.addIngredientToPizza(pizza: pizza, ingredientName: input) {
            print("Invalid ingredient name. Please choose from the list.")
        }
    }

    printPizzaDetails(pizza: pizza, pizzaType: customCommand)
}

func printPizzaDetails(pizza: Pizza, pizzaType: String) {
    print("You have chosen the \(pizzaType) pizza.")
    print("Ingredients:")
    for ingredient in pizza.getIngredients() {
        print("\(ingredient.name): \(ingredient.price)")
    }
    print("Total price: \(pizza.getTotalPrice())")
}

main()