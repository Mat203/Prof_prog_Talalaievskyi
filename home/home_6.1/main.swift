import Foundation

func appendToFile(text: String, filePath: String) {
    let fileURL = URL(fileURLWithPath: filePath)
    let data = (text + "\n").data(using: .utf8)!
    
    if FileManager.default.fileExists(atPath: filePath) {
        if let fileHandle = try? FileHandle(forWritingTo: fileURL) {
            fileHandle.seekToEndOfFile()
            fileHandle.write(data)
            fileHandle.closeFile()
        } else {
            print("Error: Unable to open file handle for writing.")
        }
    } else {
        do {
            try data.write(to: fileURL, options: .atomic)
        } catch {
            print("Error: Unable to write to file. \(error)")
        }
    }
}

struct GreenMessage {
    var text: String
    var counter: Int
}

struct BlueMessage {
    var value1: Double
    var value2: Double
}

struct OrangeMessage {
    var text1: String
    var text2: String
    var integer: Int
    var value: Double
}

class MessageDispatcher {
    private var greenSubscribers: [((GreenMessage) -> Void)] = []
    private let greenMutex = NSLock()
    
    private var blueSubscribers: [((BlueMessage) -> Void)] = []
    private let blueMutex = NSLock()
    
    private var orangeSubscribers: [((OrangeMessage) -> Void)] = []
    private let orangeMutex = NSLock()
    
    func subscribeGreen(_ callback: @escaping (GreenMessage) -> Void) -> Int {
        greenMutex.lock()
        greenSubscribers.append(callback)
        greenMutex.unlock()
        return greenSubscribers.count - 1
    }
    
    func subscribeBlue(_ callback: @escaping (BlueMessage) -> Void) -> Int {
        blueMutex.lock()
        blueSubscribers.append(callback)
        blueMutex.unlock()
        return blueSubscribers.count - 1
    }
    
    func subscribeOrange(_ callback: @escaping (OrangeMessage) -> Void) -> Int {
        orangeMutex.lock()
        orangeSubscribers.append(callback)
        orangeMutex.unlock()
        return orangeSubscribers.count - 1
    }
    
    func unsubscribeGreen(index: Int) {
        greenMutex.lock()
        if index >= 0 && index < greenSubscribers.count {
            greenSubscribers.remove(at: index)
        }
        greenMutex.unlock()
    }
    
    func unsubscribeBlue(index: Int) {
        blueMutex.lock()
        if index >= 0 && index < blueSubscribers.count {
            blueSubscribers.remove(at: index)
        }
        blueMutex.unlock()
    }
    
    func unsubscribeOrange(index: Int) {
        orangeMutex.lock()
        if index >= 0 && index < orangeSubscribers.count {
            orangeSubscribers.remove(at: index)
        }
        orangeMutex.unlock()
    }
    
    func publishGreen(_ message: GreenMessage) {
        greenMutex.lock()
        for subscriber in greenSubscribers {
            subscriber(message)
        }
        greenMutex.unlock()
    }
    
    func publishBlue(_ message: BlueMessage) {
        blueMutex.lock()
        for subscriber in blueSubscribers {
            subscriber(message)
        }
        blueMutex.unlock()
    }
    
    func publishOrange(_ message: OrangeMessage) {
        orangeMutex.lock()
        for subscriber in orangeSubscribers {
            subscriber(message)
        }
        orangeMutex.unlock()
    }
}

func subscribeToMessages(dispatcher: MessageDispatcher, messageTypes: Set<String>, filePath: String, userID: Int) -> [String: Int] {
    var subscriptionIndices = [String: Int]()
    
    if messageTypes.contains("green") {
        let index = dispatcher.subscribeGreen { message in
            appendToFile(text: "User \(userID): \(message.text) \(message.counter)", filePath: filePath)
        }
        subscriptionIndices["green"] = index
    }
    
    if messageTypes.contains("blue") {
        let index = dispatcher.subscribeBlue { message in
            appendToFile(text: "User \(userID): \(message.value1) \(message.value2)", filePath: filePath)
        }
        subscriptionIndices["blue"] = index
    }
    
    if messageTypes.contains("orange") {
        let index = dispatcher.subscribeOrange { message in
            appendToFile(text: "User \(userID): \(message.text1) \(message.text2) \(message.integer) \(message.value)", filePath: filePath)
        }
        subscriptionIndices["orange"] = index
    }
    
    return subscriptionIndices
}

func generateMessages(dispatcher: MessageDispatcher, threadName: String, filePath: String) {
    let counterDist = Int.random(in: 1...10)
    let doubleDist = Double.random(in: 0.0...10.0)
    
    while true {
        let messageType = Int.random(in: 0..<3)
        
        switch messageType {
        case 0:
            let text = "Green message: \(counterDist)"
            let greenMessage = GreenMessage(text: text, counter: counterDist)
            appendToFile(text: "\(threadName) published GreenMessage: \(greenMessage.text) \(greenMessage.counter)", filePath: filePath)
            dispatcher.publishGreen(greenMessage)
        case 1:
            let blueMessage = BlueMessage(value1: doubleDist, value2: doubleDist)
            appendToFile(text: "\(threadName) published BlueMessage: \(blueMessage.value1) \(blueMessage.value2)", filePath: filePath)
            dispatcher.publishBlue(blueMessage)
        case 2:
            let orangeMessage = OrangeMessage(
                text1: "Orange message text 1",
                text2: "Orange message text 2",
                integer: counterDist,
                value: doubleDist
            )
            appendToFile(text: "\(threadName) published OrangeMessage: \(orangeMessage.text1) \(orangeMessage.text2) \(orangeMessage.integer) \(orangeMessage.value)", filePath: filePath)
            dispatcher.publishOrange(orangeMessage)
        default:
            break
        }
        
        Thread.sleep(forTimeInterval: 5.0)
    }
}

func getUserInput() -> Set<String> {
    print("Enter the types of messages you want to subscribe to (green/blue/orange), separated by spaces: ", terminator: "")
    guard let input = readLine() else {
        print("Failed to read input. Exiting.")
        exit(1)
    }
    
    let messageTypes = Set(input.split(separator: " ").map { String($0) })
    
    if messageTypes.isEmpty {
        print("No valid message types entered. Exiting.")
        exit(1)
    }
    
    return messageTypes
}

func handleUserCommands(dispatcher: MessageDispatcher, subscriptionIndices: inout [String: Int]) {
    while true {
        print("Enter 'unsubscribe' to unsubscribe from messages or 'exit' to exit: ", terminator: "")
        guard let command = readLine() else {
            print("Failed to read input. Exiting.")
            break
        }
        
        if command == "unsubscribe" {
            print("Enter the type of messages you want to unsubscribe from (green/blue/orange): ", terminator: "")
            guard let type = readLine() else {
                print("Failed to read input.")
                continue
            }
            
            if let index = subscriptionIndices[type] {
                if type == "green" {
                    dispatcher.unsubscribeGreen(index: index)
                } else if type == "blue" {
                    dispatcher.unsubscribeBlue(index: index)
                } else if type == "orange" {
                    dispatcher.unsubscribeOrange(index: index)
                }
                subscriptionIndices.removeValue(forKey: type)
                print("Unsubscribed from \(type) messages.")
            } else {
                print("Not subscribed to \(type) messages.")
            }
        } else if command == "exit" {
            break
        } else {
            print("Unknown command.")
        }
    }
}

func main() {
    let dispatcher = MessageDispatcher()
    let filePath = "/Users/matvii/Desktop/SampleProject/messages.log"
    
    let userID = Int.random(in: 1...1000)
    print("Generated user ID: \(userID)")
    
    let messageTypes = getUserInput()
    
    var subscriptionIndices = subscribeToMessages(dispatcher: dispatcher, messageTypes: messageTypes, filePath: filePath, userID: userID)
    
    let generator1 = DispatchQueue(label: "Generator 1")
    let generator2 = DispatchQueue(label: "Generator 2")
    
    generator1.async {
        generateMessages(dispatcher: dispatcher, threadName: "Generator 1", filePath: filePath)
    }
    
    generator2.async {
        generateMessages(dispatcher: dispatcher, threadName: "Generator 2", filePath: filePath)
    }
    
    handleUserCommands(dispatcher: dispatcher, subscriptionIndices: &subscriptionIndices)
    
    RunLoop.current.run()
}

main()
