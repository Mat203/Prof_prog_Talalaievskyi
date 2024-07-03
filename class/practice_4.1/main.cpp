#include <iostream>
#include "pizza.hpp"
#include <print>

void interactWithUser(PizzaBuilder& builder) {
    std::println("Welcome to the Pizza Builder!");
    builder.displayAvailableIngredients();

    std::string input;
    while (true) {
        std::print("Enter ingredient name (or 'done' to finish): ");
        std::getline(std::cin, input);
        if (input == "done") {
            break;
        }
        if (!builder.addIngredientToPizza(input)) {
            std::println("Invalid ingredient name. Please choose from the list.");
        }
    }
}

int main() {
    PizzaBuilder builder("ingredients.txt");
    interactWithUser(builder);

    Pizza pizza = builder.buildPizza();

    std::println("\nYour pizza contains:");
    for (const Ingredient& ingredient : pizza.getIngredients()) {
        std::println("{} ( ${} )", ingredient.name, ingredient.price);
    }

    std::println("\nTotal price: ${}", pizza.getTotalPrice());

    return 0;
}
