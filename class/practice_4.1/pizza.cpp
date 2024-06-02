#include "pizza.hpp"
#include <iostream>
#include <fstream>
#include <sstream>
#include <map>

Pizza::Pizza() : total_price(0.0) {}

void Pizza::addIngredient(const Ingredient& ingredient) {
    ingredients.push_back(ingredient);
    total_price += ingredient.price;
}

double Pizza::getTotalPrice() const {
    return total_price;
}

const std::vector<Ingredient>& Pizza::getIngredients() const {
    return ingredients;
}

PizzaBuilder::PizzaBuilder(const std::string& ingredientsFile) : ingredientsFile(ingredientsFile) {}

Pizza PizzaBuilder::buildPizza() {
    Pizza pizza;
    loadIngredients();

    std::cout << "Available ingredients:\n";
    for (const auto& pair : ingredients) {
        std::cout << "- " << pair.second.name << " ($" << pair.second.price << ")\n";
    }

    std::string input;
    while (true) {
        std::cout << "Enter ingredient name (or 'done' to finish): ";
        std::getline(std::cin, input);
        if (input == "done") {
            break;
        }

        auto it = ingredients.find(input);
        if (it != ingredients.end()) {
            pizza.addIngredient(it->second);
        } else {
            std::cout << "Invalid ingredient name. Please choose from the list.\n";
        }
    }

    return pizza;
}

void PizzaBuilder::loadIngredients() {
    std::ifstream file(ingredientsFile);
    if (file.is_open()) {
        std::string line;
        while (std::getline(file, line)) {
            std::stringstream ss(line);
            std::string name, priceStr;
            std::getline(ss, name, ',');
            std::getline(ss, priceStr, ',');
            double price = std::stod(priceStr);
            ingredients[name] = { name, price };
        }
        file.close();
    } else {
        std::cerr << "Error opening ingredients file: " << ingredientsFile << std::endl;
    }
}
