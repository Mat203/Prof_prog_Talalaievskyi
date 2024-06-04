import Foundation

let FILENAME = "user_stats.txt"
let DELETE_COMMAND = "delete"
let BREAD_COMMAND = "bread"
let EXIT_COMMAND = "exit"

struct StatsManager {
    var stats: [String: Int] = [:]

    init() {
        self.stats = readStats()
    }

    func readStats() -> [String: Int] {
        var stats = [String: Int]()
        if let fileContents = try? String(contentsOfFile: FILENAME) {
            let lines = fileContents.split(separator: "\n")
            for line in lines {
                let parts = line.split(separator: " ")
                if parts.count == 2, let count = Int(parts[1]) {
                    stats[String(parts[0])] = count
                }
            }
        }
        return stats
    }

    func writeStats() {
        var fileContents = ""
        for (name, count) in stats {
            fileContents += "\(name) \(count)\n"
        }
        try? fileContents.write(toFile: FILENAME, atomically: true, encoding: .utf8)
    }

    mutating func deleteStats() {
        stats.removeAll()
        try? "".write(toFile: FILENAME, atomically: true, encoding: .utf8)
    }

    mutating func incrementStat(for name: String) {
        if let currentCount = stats[name] {
            stats[name] = currentCount + 1
        } else {
            stats[name] = 1
        }
        writeStats()
    }

    mutating func resetStat(for name: String) {
        stats.removeValue(forKey: name)
        writeStats()
    }

    mutating func clearAllStats() {
        stats.removeAll()
        deleteStats()
    }
}

struct FileHandleOutputStream: TextOutputStream {
    var handle: FileHandle

    mutating func write(_ string: String) {
        handle.write(Data(string.utf8))
    }
}

var stderr = FileHandle.standardError
var stdErrStream = FileHandleOutputStream(handle: stderr)

func displayUsage() {
    print("Usage: <name> or <name> \(DELETE_COMMAND) or \(BREAD_COMMAND)", to: &stdErrStream)
}

var statsManager = StatsManager()

while true {
    print("Enter input: ", terminator: "")
    guard let input = readLine(), !input.isEmpty else {
        print("Input cannot be empty. Please try again.", to: &stdErrStream)
        continue
    }

    let parts = input.split(separator: " ")
    let name = String(parts[0])
    let command = parts.count > 1 ? String(parts[1]) : ""

    if name == BREAD_COMMAND {
        statsManager.clearAllStats()
        print("All history has been deleted.")
        continue
    }

    if command == DELETE_COMMAND {
        statsManager.resetStat(for: name)
        print("Statistics for \(name) have been reset.")
        continue
    }

    if name == EXIT_COMMAND {
        print("Exiting the program.")
        break
    }

    if !command.isEmpty && command != DELETE_COMMAND {
        displayUsage()
        continue
    }

    statsManager.incrementStat(for: name)

    if statsManager.stats[name] == 1 {
        print("Welcome, \(name)!")
    } else {
        print("Hello again(\(statsManager.stats[name]!)), \(name)!")
    }
}
