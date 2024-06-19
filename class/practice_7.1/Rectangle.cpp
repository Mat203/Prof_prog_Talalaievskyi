#include "Rectangle.hpp"

Rectangle::Rectangle(double width, double height)
    : width(width), height(height) {}

double Rectangle::getWidth() const {
    return width;
}

double Rectangle::getHeight() const {
    return height;
}

double Rectangle::getArea() const {
    return width * height;
}

double Rectangle::getBiggerSide() const {
    return (width > height) ? width : height;
}

bool Rectangle::canBePlacedInside(const Rectangle& other) const {
    return width <= other.width && height <= other.height;
}
