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
    Pizza buildPizza();

private:
    void loadIngredients();
    std::string ingredientsFile;
    std::map<std::string, Ingredient> ingredients;
};
