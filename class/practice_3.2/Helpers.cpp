#include "Helpers.hpp"
#include "Helpers.hpp"
#include <algorithm>
#include <string>
#include <cmath>
#include <iostream>

double dummyFunc(double x) {
    return x > 0 ? x : 0;
}

Triangle::Triangle(double side1, double side2, double side3) : a(side1), b(side2), c(side3) {
    if (a <= 0 || b <= 0 || c <= 0) {
        throw std::invalid_argument("Error: All side lengths must be positive.");
    }

    if (a + b <= c || a + c <= b || b + c <= a) {
        throw std::invalid_argument("Error: These side lengths do not form a valid triangle.");
    }
}

double Triangle::calculateArea() const {
    double s = (a + b + c) / 2.0;
    return std::sqrt(s * (s - a) * (s - b) * (s - c));
}

RGBColor::RGBColor(int red, int green, int blue) : r(red), g(green), b(blue) {
    if (r < 0 || r > 255 || g < 0 || g > 255 || b < 0 || b > 255) {
        throw std::invalid_argument("Error: RGB values must be in the range 0-255.");
    }
}

RGBColor RGBColor::generateMagicColor() const {
    int newR = (r / 2) - 1;
    int newG = (g * 2) - 2;
    int newB = b;

    newR = std::max(0, std::min(255, newR));
    newG = std::max(0, std::min(255, newG));

    return RGBColor(newR, newG, newB);
}

int RGBColor::getR() const {
    return r;
}

int RGBColor::getG() const {
    return g;
}

int RGBColor::getB() const {
    return b;
}