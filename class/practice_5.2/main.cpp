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

  MegaDataPool& pool = MegaDataPool::getInstance(5);

  try {
    MegaData& pooledData = pool.acquire();
    pooledData.getSmallArray()[0] = 20.5f;
    std::println("Pooled Small Array Element 0: {}", pooledData.getSmallArray()[0]);
    pool.release(pooledData);
  } catch (const std::exception& e) {
    std::cerr << "Exception: " << e.what() << std::endl;
  }

  return 0;
}
