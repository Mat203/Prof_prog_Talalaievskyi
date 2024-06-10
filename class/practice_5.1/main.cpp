#include "Helpers.hpp"
#include <iostream>
#include <print>

int main() {
  MegaData data;

  data.getSmallArray()[0] = 10.5f; 
  data.getBigArray()[1024] = 3.14;
  std::println("Small Array Element 0: {}", data.getSmallArray()[0]);
  std::println("Big Array Element 1024: {}", data.getBigArray()[1024]);

  data.reset();

  std::println("Small Array Element 0: {}", data.getSmallArray()[0]);
  std::println("Big Array Element 1024: {}", data.getBigArray()[1024]);

  return 0;
}