#include "Helpers.hpp"
#include <algorithm>
#include <string>

double dummyFunc(double x) {
    return x > 0 ? x : 0;
}

std::string repeatString(const std::vector<int>& numbers, const std::string& str) {
    if (numbers.empty()) {
        return ""; 
    }

    int maxNumber = *std::max_element(numbers.begin(), numbers.end());
    std::string repeatedString;
    for (int i = 0; i < maxNumber; ++i) {
        repeatedString += str;
    }
    return repeatedString;
}