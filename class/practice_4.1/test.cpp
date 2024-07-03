#include <iostream>
#include <sstream>
#include <fstream>
#include <vector>
#include <map>
#include <pizza.hpp>
#include <UnitTests.hpp>

void createMockIngredientsFile(const std::string& filename) {
    std::ofstream file(filename);
    file << "Tomato,1.5\n";
    file << "Cheese,2.0\n";
    file << "Pepperoni,2.5\n";
    file << "Mushroom,1.0\n";
    file.close();
}

int main() {
    UnitTests testSuite;

    testSuite.addTest("PizzaBuilder_BuildPizza_Test1",
    []() {
        std::string ingredientsFile = "mock_ingredients.txt";
        createMockIngredientsFile(ingredientsFile);
        
        PizzaBuilder builder(ingredientsFile);
        Pizza pizza;
        
        std::istringstream input("Tomato\nCheese\nPepperoni\ndone\n");
        std::cin.rdbuf(input.rdbuf());

        pizza = builder.buildPizza();

        auto ingredients = pizza.getIngredients();
        ASSERT_EQ(ingredients.size(), 3);
        ASSERT_EQ(ingredients[0].name, "Tomato");
        ASSERT_EQ(ingredients[1].name, "Cheese");
        ASSERT_EQ(ingredients[2].name, "Pepperoni");

        double totalPrice = pizza.getTotalPrice();
        ASSERT_EQ(totalPrice, 6.0);
    });

    testSuite.addTest("PizzaBuilder_BuildPizza_InvalidIngredient",
    []() {

        std::string ingredientsFile = "mock_ingredients.txt";
        createMockIngredientsFile(ingredientsFile);

        PizzaBuilder builder(ingredientsFile);
        Pizza pizza;

        std::istringstream input("Tomato\nInvalidIngredient\nCheese\ndone\n");
        std::cin.rdbuf(input.rdbuf());

        pizza = builder.buildPizza();

        auto ingredients = pizza.getIngredients();
        ASSERT_EQ(ingredients.size(), 2);
        ASSERT_EQ(ingredients[0].name, "Tomato");
        ASSERT_EQ(ingredients[1].name, "Cheese");

        double totalPrice = pizza.getTotalPrice();
        ASSERT_EQ(totalPrice, 3.5);
    });

    testSuite.addTest("PizzaBuilder_BuildPizza_NoIngredients",
    []() {
        std::string ingredientsFile = "mock_ingredients.txt";
        createMockIngredientsFile(ingredientsFile);

        PizzaBuilder builder(ingredientsFile);
        Pizza pizza;

        std::istringstream input("done\n");
        std::cin.rdbuf(input.rdbuf());

        pizza = builder.buildPizza();

        auto ingredients = pizza.getIngredients();
        ASSERT_EQ(ingredients.size(), 0);

        double totalPrice = pizza.getTotalPrice();
        ASSERT_EQ(totalPrice, 0.0);
    });

    testSuite.run();
}
