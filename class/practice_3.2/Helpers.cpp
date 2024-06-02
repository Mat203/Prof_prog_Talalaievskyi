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
