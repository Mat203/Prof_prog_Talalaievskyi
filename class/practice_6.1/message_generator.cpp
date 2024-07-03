#include "message_dispatcher.hpp" 

void generateMessages(MessageDispatcher& dispatcher, const std::string& threadName) {
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<> counterDist(1, 10);
    std::uniform_real_distribution<> doubleDist(0.0, 10.0);

    while (true) {
        int messageType = gen() % 3;

        switch (messageType) {
            case 0: {
                std::string text = "Green message: ";
                text += std::to_string(counterDist(gen));
                GreenMessage greenMessage{text, counterDist(gen)};
                std::cout << threadName << " published GreenMessage: " << greenMessage.text << " " << greenMessage.counter << std::endl;
                dispatcher.publishGreen(greenMessage);
                break;
            }
            case 1: {
                BlueMessage blueMessage{doubleDist(gen), doubleDist(gen)};
                std::cout << threadName << " published BlueMessage: " << blueMessage.value1 << " " << blueMessage.value2 << std::endl;
                dispatcher.publishBlue(blueMessage);
                break;
            }
            case 2: { 
                OrangeMessage orangeMessage{
                    "Orange message text 1",
                    "Orange message text 2",
                    counterDist(gen),
                    doubleDist(gen)
                };
                std::cout << threadName << " published OrangeMessage: " << orangeMessage.text1 << " " << orangeMessage.text2 << " " << orangeMessage.integer << " " << orangeMessage.value << std::endl;
                dispatcher.publishOrange(orangeMessage);
                break;
            }
        }

        std::this_thread::sleep_for(std::chrono::milliseconds(5000));
    }
}