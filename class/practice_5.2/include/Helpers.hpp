#pragma once

#include <array>
#include <vector>
#include <mutex>

class MegaData {
public:
  MegaData();

  void reset();

  const std::array<float, 1024>& getSmallArray() const;
  std::array<float, 1024>& getSmallArray();
  const std::array<double, 512 * 512>& getBigArray() const; 
  std::array<double, 512 * 512>& getBigArray();

private:
  std::array<float, 1024> smallArray;
  std::array<double, 512 * 512> bigArray; 
};

class MegaDataPool {
public:
  static MegaDataPool& getInstance(size_t poolSize = 10);

  MegaData& acquire();
  void release(MegaData& data);

  size_t size() const { return pool.size(); }
  size_t usedSize() const { return usedObjects; }

private:
  MegaDataPool(size_t poolSize);
  ~MegaDataPool() = default;
  MegaDataPool(const MegaDataPool&) = delete;
  MegaDataPool& operator=(const MegaDataPool&) = delete;

  std::vector<MegaData> pool;
  size_t usedObjects = 0;
  static std::mutex mutex_;
  static MegaDataPool* instance;
};
