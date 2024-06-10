#include "Helpers.hpp"
#include <stdexcept> 

MegaData::MegaData() {
  std::fill(smallArray.begin(), smallArray.end(), 42.0f);
  std::fill(bigArray.begin(), bigArray.end(), 42.0);
}

void MegaData::reset() {
  std::fill(smallArray.begin(), smallArray.end(), 42.0f);
  std::fill(bigArray.begin(), bigArray.end(), 42.0);
}

const std::array<float, 1024>& MegaData::getSmallArray() const {
  return smallArray;
}

std::array<float, 1024>& MegaData::getSmallArray() {
  return smallArray;
}

const std::array<double, 512 * 512>& MegaData::getBigArray() const {
  return bigArray;
}

std::array<double, 512 * 512>& MegaData::getBigArray() {
  return bigArray;
}

MegaDataPool::MegaDataPool(size_t poolSize) : pool(poolSize) {}

MegaData& MegaDataPool::acquire() {
  if (usedObjects < pool.size()) {
    usedObjects++;
    return pool[usedObjects - 1];
  } else {
    throw std::runtime_error("Pool is full!");
  }
}

void MegaDataPool::release(MegaData& data) {
  if (usedObjects > 0) {
    usedObjects--;
    data.reset(); 
  } else {
    throw std::runtime_error("No objects to release!");
  }
}