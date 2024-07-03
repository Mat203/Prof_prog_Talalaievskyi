import Foundation

class Configuration {
    static let shared = Configuration()
    private var config: [(range: ClosedRange<Character>, preWord: String, postWord: String)] = []

    private init() {
        loadConfiguration()
    }

    private func loadConfiguration() {
        let configFileContent = """
        a-k Pre1 Post1
        l-o Pre2 Post2
        p-z Pre3 Post3
        """
        let lines = configFileContent.split(separator: "\n")
        for line in lines {
            let parts = line.split(separator: " ")
            if parts.count == 3 {
                let range = String(parts[0])
                let preWord = String(parts[1])
                let postWord = String(parts[2])
                if range.count == 3, let start = range.first, let end = range.last {
                    config.append((range: start...end, preWord: preWord, postWord: postWord))
                }
            }
        }
    }

    func getConfiguration(for word: String) -> (preWord: String, postWord: String)? {
        guard let firstLetter = word.lowercased().first else { return nil }
        for (range, preWord, postWord) in config {
            if range.contains(firstLetter) {
                return (preWord, postWord)
            }
        }
        return nil
    }
}

func getUserFavoriteWords() -> [String] {
    var favoriteWords = [String]()
    for i in 1...5 {
        print("Enter favorite word \(i):", terminator: " ")
        if let word = readLine(), !word.isEmpty {
            favoriteWords.append(word)
        }
    }
    return favoriteWords
}

func processWords(words: [String]) {
    let queue = DispatchQueue.global(qos: .userInitiated)
    let group = DispatchGroup()

    for word in words {
        queue.async(group: group) {
            group.enter()
            Thread.sleep(forTimeInterval: 1)
            if let config = Configuration.shared.getConfiguration(for: word) {
                print("\(config.preWord) \(word) \(config.postWord)")
            } else {
                print("Configuration not found for word: \(word)")
            }
            group.leave()
        }
    }

    group.wait()
}

func main() {
    while true {
        let favoriteWords = getUserFavoriteWords()
        processWords(words: favoriteWords)
        
        print("Do you want to enter another set of words? (yes/no):", terminator: " ")
        if let response = readLine(), response.lowercased() == "no" {
            break
        }
    }
}

main()
