#pragma once

#include <string>
#include <vector>
#include <map>

struct Ingredient {
    std::string name;
    double price;
};

class Pizza {
public:
    Pizza();
    void addIngredient(const Ingredient& ingredient);
    double getTotalPrice() const;
    const std::vector<Ingredient>& getIngredients() const;

private:
    std::vector<Ingredient> ingredients;
    double total_price;
};

class PizzaBuilder {
public:
    PizzaBuilder(const std::string& ingredientsFile);
    [[nodiscard]] Pizza buildPizza();
    std::vector<std::string> getAvailableIngredients() const;
    bool addIngredientToPizza(const std::string& ingredientName);
    void displayAvailableIngredients() const;

private:
    void loadIngredients();
    std::string ingredientsFile;
    std::map<std::string, Ingredient> ingredients;
    Pizza pizza;
};
