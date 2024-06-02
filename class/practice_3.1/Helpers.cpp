#include "Helpers.hpp"
#include <algorithm>
#include <string>
#include <iostream>
#include <vector>
#include <ranges>

double dummyFunc(double x) {
    return x > 0 ? x : 0;
}

std::string repeatString(const std::vector<int>& numbers, const std::string& str) {
    if (numbers.empty()) {
        return "";
    }
    
    auto repeatedView = str | std::views::repeat;

    auto concatenatedView = numbers | std::views::transform(&repeatedView {
        return repeatedView | std::views::take(num);
    }) | std::views::join;

    std::string result;
    for (char c : concatenatedView) {
        result += c;
    }

    return result;
}
