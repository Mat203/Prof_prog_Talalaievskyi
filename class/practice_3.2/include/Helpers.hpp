#pragma once
#include <vector> 
#include <string>

double dummyFunc(double x);
std::string repeatString(const std::vector<int>& numbers, const std::string& str);

class Triangle {
private:
    double a, b, c; 

public:
    Triangle(double side1, double side2, double side3);

    double calculateArea() const;
};