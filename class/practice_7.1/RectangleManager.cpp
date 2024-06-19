#include "RectangleManager.hpp"
#include <print>

void RectangleManager::addRectangle(const Rectangle& rectangle) {
    rectangles.push_back(rectangle);
}

double RectangleManager::getBiggestArea() const {
    double biggestArea = 0.0;
    for (const auto& rect : rectangles) {
        if (rect.getArea() > biggestArea) {
            biggestArea = rect.getArea();
        }
    }
    return biggestArea;
}

double RectangleManager::getSmallestArea() const {
    double smallestArea = (rectangles.empty()) ? 0.0 : rectangles[0].getArea();
    for (const auto& rect : rectangles) {
        if (rect.getArea() < smallestArea) {
            smallestArea = rect.getArea();
        }
    }
    return smallestArea;
}

double RectangleManager::getTotalArea() const {
    double totalArea = 0.0;
    for (const auto& rect : rectangles) {
        totalArea += rect.getArea();
    }
    return totalArea;
}

void RectangleManager::printContainment() const {
    for (size_t i = 0; i < rectangles.size(); ++i) {
        for (size_t j = 0; j < rectangles.size(); ++j) {
            if (i != j && rectangles[i].canBePlacedInside(rectangles[j])) {
                std::println("Rectangle {} can be placed inside Rectangle {}", i + 1, j + 1);
            }
        }
    }
}

void RectangleManager::printBiggestSides() const {
    for (size_t i = 0; i < rectangles.size(); ++i) {
        std::println("The biggest side of rectangle {}: {}", i + 1, rectangles[i].getBiggerSide());
    }
}
