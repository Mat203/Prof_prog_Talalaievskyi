#include <tournament.hpp>
#include <match.hpp>
#include <team.hpp>
#include <iostream>
#include <print>

int main() {
    Tournament tournament;

    for (int i = 0; i < 4; ++i) {
        std::string name;
        std::print("Enter team name: ");
        std::cin >> name;
        tournament.add_team(Team(name));
    }

    for (size_t i = 0; i < tournament.teams.size(); ++i) {
        for (size_t j = i + 1; j < tournament.teams.size(); ++j) {
            int goals1, goals2, yellow1, yellow2, red1, red2;
            double height1, height2;
            std::println("Enter match result between {} and {}:", tournament.teams[i].name, tournament.teams[j].name);
            std::print("Goals scored by {}: ", tournament.teams[i].name);
            std::cin >> goals1;
            std::print("Goals scored by {}: ", tournament.teams[j].name);
            std::cin >> goals2;
            std::print("Yellow cards for {}: ", tournament.teams[i].name);
            std::cin >> yellow1;
            std::print("Yellow cards for {}: ", tournament.teams[j].name);
            std::cin >> yellow2;
            std::print("Red cards for {}: ", tournament.teams[i].name);
            std::cin >> red1;
            std::print("Red cards for {}: ", tournament.teams[j].name);
            std::cin >> red2;
            std::print("Top height reached by {}: ", tournament.teams[i].name);
            std::cin >> height1;
            std::print("Top height reached by {}: ", tournament.teams[j].name);
            std::cin >> height2;

            tournament.add_match(Match(tournament.teams[i], tournament.teams[j], goals1, goals2, yellow1, yellow2, red1, red2, height1, height2));
        }
    }

    tournament.calculate_ranking();
    tournament.print_results();

    return 0;
}
