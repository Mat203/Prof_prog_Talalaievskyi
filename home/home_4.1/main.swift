func main() {
    let builder = PizzaBuilder(ingredientsFile: "/Users/matvii/Desktop/SampleProject/Project/Test/ingredients.txt")

    let choice = promptUserForChoice()
    
    if choice == "classic" {
        handleClassicPizzaChoice(builder: builder)
    } else if choice == "custom" {
        handleCustomPizzaChoice(builder: builder)
    } else {
        print("Invalid choice.")
    }
}

func promptUserForChoice() -> String {
    print("Do you want to choose a classic pizza or compose a custom one? (classic/custom): ", terminator: "")
    return readLine()?.lowercased() ?? ""
}

func handleClassicPizzaChoice(builder: PizzaBuilder) {
    let classicPizzas = builder.getClassicPizzaOptions()
    print("Available classic pizzas:")
    for (name, _) in classicPizzas {
        print(name)
    }

    print("Enter the name of the classic pizza you want: ", terminator: "")
    guard let pizzaChoice = readLine(), let pizza = builder.buildClassicPizza(type: pizzaChoice) else {
        print("Invalid choice.")
        return
    }

    printPizzaDetails(pizza: pizza, pizzaType: pizzaChoice)
}

func handleCustomPizzaChoice(builder: PizzaBuilder) {
    let pizza = builder.buildCustomPizza()
    printPizzaDetails(pizza: pizza, pizzaType: "custom")
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