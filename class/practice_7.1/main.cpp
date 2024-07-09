#include <print>
#include "RectangleManager.hpp"

int main() {
    RectangleManager manager;
    for (int i = 0; i < 5; ++i) {
        double width, height;
        std::println("Enter rectangle {}:", i + 1);
        if (std::cin >> width >> height) {
            manager.addRectangle(Rectangle(width, height));
        } else {
            std::println("Invalid input!");
            return 1;
        }
    }

    manager.printContainment();
    manager.printBiggestSides();
    std::println("The biggest area: {}", manager.getBiggestArea());
    std::println("The smallest area: {}", manager.getSmallestArea());
    std::println("Total area of rectangles: {}", manager.getTotalArea());

    return 0;
}
