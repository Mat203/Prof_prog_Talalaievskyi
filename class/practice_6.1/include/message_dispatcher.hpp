#pragma once

#include <iostream>
#include <thread>
#include <random>
#include <functional>
#include <vector>
#include <mutex>

struct GreenMessage {
    std::string text;
    int counter;
};

struct BlueMessage {
    double value1;
    double value2;
};

struct OrangeMessage {
    std::string text1;
    std::string text2;
    int integer;
    double value;
};

class MessageDispatcher {
public:
    template <typename T>
    void subscribeGreen(T callback) {
        std::lock_guard<std::mutex> lock(greenMutex);
        greenSubscribers.push_back(callback);
    }

    template <typename T>
    void subscribeBlue(T callback) {
        std::lock_guard<std::mutex> lock(blueMutex);
        blueSubscribers.push_back(callback);
    }

    template <typename T>
    void subscribeOrange(T callback) {
        std::lock_guard<std::mutex> lock(orangeMutex);
        orangeSubscribers.push_back(callback);
    }

    void publishGreen(const GreenMessage& message) {
        std::lock_guard<std::mutex> lock(greenMutex);
        for (auto& subscriber : greenSubscribers) {
            subscriber(message);
        }
    }

    void publishBlue(const BlueMessage& message) {
        std::lock_guard<std::mutex> lock(blueMutex);
        for (auto& subscriber : blueSubscribers) {
            subscriber(message);
        }
    }

    void publishOrange(const OrangeMessage& message) {
        std::lock_guard<std::mutex> lock(orangeMutex);
        for (auto& subscriber : orangeSubscribers) {
            subscriber(message);
        }
    }

private:
    std::vector<std::function<void(const GreenMessage&)>> greenSubscribers;
    std::mutex greenMutex;

    std::vector<std::function<void(const BlueMessage&)>> blueSubscribers;
    std::mutex blueMutex;

    std::vector<std::function<void(const OrangeMessage&)>> orangeSubscribers;
    std::mutex orangeMutex;
};

void generateMessages(MessageDispatcher& dispatcher, const std::string& threadName); 