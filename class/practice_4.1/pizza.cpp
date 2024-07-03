#include "pizza.hpp"
#include <iostream>
#include <fstream>
#include <sstream>
#include <map>
#include <print>

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

PizzaBuilder::PizzaBuilder(const std::string& ingredientsFile) : ingredientsFile(ingredientsFile) {
    loadIngredients();
}

Pizza PizzaBuilder::buildPizza() {
    return pizza;
}

std::vector<std::string> PizzaBuilder::getAvailableIngredients() const {
    std::vector<std::string> ingredientNames;
    for (const auto& pair : ingredients) {
        ingredientNames.push_back(pair.first);
    }
    return ingredientNames;
}

bool PizzaBuilder::addIngredientToPizza(const std::string& ingredientName) {
    auto it = ingredients.find(ingredientName);
    if (it != ingredients.end()) {
        pizza.addIngredient(it->second);
        return true;
    } else {
        return false;
    }
}

void PizzaBuilder::displayAvailableIngredients() const {
    std::println("Available ingredients:");
    for (const auto& pair : ingredients) {
        std::println("- {} (${})", pair.second.name, pair.second.price);
    }
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
        std::println("Error opening ingredients file: {}", ingredientsFile);
    }
}
