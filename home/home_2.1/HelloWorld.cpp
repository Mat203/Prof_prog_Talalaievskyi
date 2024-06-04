#include <iostream>
#include <unordered_map>
#include <string>
#include <sstream>
#include <fstream>
#include <format>

constexpr char EXIT_COMMAND[] = "exit";
constexpr char DELETE_COMMAND[] = "delete";
constexpr char BREAD_COMMAND[] = "bread";
constexpr char INPUT_PROMPT[] = "Enter input: ";
constexpr char EMPTY_INPUT_ERROR[] = "Input cannot be empty. Please try again.\n";
constexpr char ALL_HISTORY_DELETED[] = "All history has been deleted.\n";
constexpr char STATS_RESET[] = "Statistics for {} have been reset.\n";
constexpr char WELCOME_MESSAGE[] = "Welcome, {}!\n";
constexpr char HELLO_AGAIN_MESSAGE[] = "Hello again({}), {}!\n";
constexpr char EXITING_PROGRAM[] = "Exiting the program.\n";
constexpr char FILENAME[] = "user_stats.txt";

class StatsManager {
public:
    StatsManager(const std::string& filename) : filename_(filename) {
        readStats();
    }

    void readStats() {
        stats_.clear();
        std::ifstream infile(filename_);
        std::string name;
        int count;
        while (infile >> name >> count) {
            stats_[name] = count;
        }
    }

    void writeStats() const {
        std::ofstream outfile(filename_, std::ios::trunc);
        for (const auto& pair : stats_) {
            outfile << std::format("{} {}\n", pair.first, pair.second);
        }
    }

    void deleteStats() {
        stats_.clear();
        std::ofstream outfile(filename_, std::ios::trunc);  
    }

    void incrementStat(const std::string& name) {
        if (stats_.find(name) == stats_.end()) {
            stats_[name] = 1;
            std::cout << std::format(WELCOME_MESSAGE, name);
        } else {
            stats_[name]++;
            std::cout << std::format(HELLO_AGAIN_MESSAGE, stats_[name], name);
        }
        writeStats();
    }

    void deleteStat(const std::string& name) {
        stats_.erase(name);
        writeStats();
        std::cout << std::format(STATS_RESET, name);
    }

private:
    std::unordered_map<std::string, int> stats_;
    std::string filename_;
};

void displayUsage() {
    std::cerr << "Invalid command. Usage: <name> delete or bread \n";
}

int main() {
    StatsManager statsManager(FILENAME);

    while (true) {
        std::cout << INPUT_PROMPT;
        std::string input;
        std::getline(std::cin, input);

        if (input.empty()) {
            std::cerr << EMPTY_INPUT_ERROR;
            continue;
        }

        std::istringstream iss(input);
        std::string name, command;
        iss >> name >> command;

        if (name == BREAD_COMMAND) {
            statsManager.deleteStats();
            std::cout << ALL_HISTORY_DELETED;
            continue;
        }

        if (command == DELETE_COMMAND) {
            statsManager.deleteStat(name);
            continue;
        }

        if (name == EXIT_COMMAND) {
            std::cout << EXITING_PROGRAM;
            break;
        }

        if (!command.empty() && command != DELETE_COMMAND) {
            displayUsage();
            continue;
        }

        statsManager.incrementStat(name);
    }

    return 0;
}
