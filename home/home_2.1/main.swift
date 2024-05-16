import Foundation

let FILENAME = "user_stats.txt"

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

func writeStats(_ stats: [String: Int]) {
    var fileContents = ""
    for (name, count) in stats {
        fileContents += "\(name) \(count)\n"
    }
    try? fileContents.write(toFile: FILENAME, atomically: true, encoding: .utf8)
}

func deleteStats() {
    try? "".write(toFile: FILENAME, atomically: true, encoding: .utf8)
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
    print("Usage: <name> or <name> delete or bread", to: &stdErrStream)
}

var stats = readStats()

while true {
    print("Enter input: ", terminator: "")
    guard let input = readLine(), !input.isEmpty else {
        displayUsage()
        continue
    }

    let parts = input.split(separator: " ")
    let name = String(parts[0])
    let command = parts.count > 1 ? String(parts[1]) : ""

    if name == "bread" {
        deleteStats()
        stats.removeAll()
        print("All history has been deleted.")
        continue
    }

    if command == "delete" {
        stats.removeValue(forKey: name)
        writeStats(stats)
        print("Statistics for \(name) have been reset.")
        continue
    }

    if name == "exit" {
        print("Exiting the program.")
        break
    }

    if !command.isEmpty && command != "delete" {
        displayUsage()
        continue
    }

    if stats[name] == nil {
        stats[name] = 1
        print("Welcome, \(name)!")
    } else {
        stats[name]! += 1
        print("Hello again(\(stats[name]!)), \(name)!")
    }

    writeStats(stats)
}
