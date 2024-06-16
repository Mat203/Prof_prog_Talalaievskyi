#include <message_dispatcher.hpp>
#include <sstream>
#include <unordered_set>
#include <thread>

void subscribeToMessages(MessageDispatcher& dispatcher, const std::unordered_set<std::string>& messageTypes) {
    if (messageTypes.find("green") != messageTypes.end()) {
        dispatcher.subscribeGreen([](const GreenMessage& message) {
            std::cout << "GreenMessage subscriber: " << message.text << " " << message.counter << std::endl;
        });
    }

    if (messageTypes.find("blue") != messageTypes.end()) {
        dispatcher.subscribeBlue([](const BlueMessage& message) {
            std::cout << "BlueMessage subscriber: " << message.value1 << " " << message.value2 << std::endl;
        });
    }

    if (messageTypes.find("orange") != messageTypes.end()) {
        dispatcher.subscribeOrange([](const OrangeMessage& message) {
            std::cout << "OrangeMessage subscriber: " << message.text1 << " " << message.text2 << " " << message.integer << " " << message.value << std::endl;
        });
    }
}

int main() {
    MessageDispatcher dispatcher;

    std::cout << "Enter the types of messages you want to subscribe to (green/blue/orange), separated by spaces: ";
    std::string input;
    std::getline(std::cin, input);

    std::unordered_set<std::string> messageTypes;
    std::istringstream iss(input);
    for (std::string type; iss >> type; ) {
        messageTypes.insert(type);
    }

    if (messageTypes.empty()) {
        std::cout << "No valid message types entered. Exiting." << std::endl;
        return 1;
    }

    subscribeToMessages(dispatcher, messageTypes);

    std::thread generator1(generateMessages, std::ref(dispatcher), "Generator 1");
    std::thread generator2(generateMessages, std::ref(dispatcher), "Generator 2");

    generator1.join();
    generator2.join();

    return 0;
}