#pragma once

#include <vector>
#include "Rectangle.hpp"

class RectangleManager {
public:
    void addRectangle(const Rectangle& rectangle);
    double getBiggestArea() const;
    double getSmallestArea() const;
    double getTotalArea() const;
    void printContainment() const;
    void printBiggestSides() const;

private:
    std::vector<Rectangle> rectangles;
};
