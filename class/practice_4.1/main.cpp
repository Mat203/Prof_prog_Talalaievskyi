#include <iostream>
#include <pizza.hpp>
#include <cassert>

int main() {
    std::cout << "Welcome to the Pizza Builder!\n";
    PizzaBuilder builder("ingredients.txt");
    Pizza pizza = builder.buildPizza();

    std::cout << "\nYour pizza contains:\n";
    for (const Ingredient& ingredient : pizza.getIngredients()) {
        std::cout << ingredient.name << " ( $" << ingredient.price << " )\n";
    }

    std::cout << "\nTotal price: $" << pizza.getTotalPrice() << std::endl;

    return 0;
}