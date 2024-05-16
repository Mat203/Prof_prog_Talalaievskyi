#include <iostream>
#include <fstream>
#include <string>
#include <unordered_map>
#include <sstream>

const std::string FILENAME = "user_stats.txt";

std::unordered_map<std::string, int> readStats() {
    std::unordered_map<std::string, int> stats;
    std::ifstream infile(FILENAME);
    std::string line;
    while (std::getline(infile, line)) {
        std::istringstream iss(line);
        std::string name;
        int count;
        if (iss >> name >> count) {
            stats[name] = count;
        }
    }
    return stats;
}

void writeStats(const std::unordered_map<std::string, int>& stats) {
    std::ofstream outfile(FILENAME, std::ios::trunc);
    for (const auto& pair : stats) {
        outfile << pair.first << " " << pair.second << "\n";
    }
}

void deleteStats() {
    std::ofstream outfile(FILENAME, std::ios::trunc);
}

void displayUsage() {
    std::cerr << "Usage: <name> or <name> delete or bread\n";
}

int main() {
    std::unordered_map<std::string, int> stats = readStats();
    
    while (true) {
        std::cout << "Enter input: ";
        std::string input;
        std::getline(std::cin, input);

        if (input.empty()) {
            std::cerr << "Input cannot be empty. Please try again.\n";
            continue;
        }

        std::istringstream iss(input);
        std::string name, command;
        iss >> name >> command;

        if (name == "bread") {
            deleteStats();
            stats.clear();
            std::cout << "All history has been deleted.\n";
            continue;
        }

        if (command == "delete") {
            stats.erase(name);
            writeStats(stats);
            std::cout << "Statistics for " << name << " have been reset.\n";
            continue;
        }

        if (name == "exit") {
            std::cout << "Exiting the program.\n";
            break;
        }

        if (command != "" && command != "delete") {
            displayUsage();
            continue;
        }

        if (stats.find(name) == stats.end()) {
            stats[name] = 1;
            std::cout << "Welcome, " << name << "!\n";
        } else {
            stats[name]++;
            std::cout << "Hello again(" << stats[name] << "), " << name << "!\n";
        }

        writeStats(stats);
    }

    return 0;
}
