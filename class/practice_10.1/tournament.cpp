#include "tournament.hpp"
#include <iostream>
#include <ranges>
#include <algorithm>
#include <random>
#include <ctime>
#include <print>

void Tournament::add_team(const Team& team) {
    teams.push_back(team);
}

void Tournament::add_match(Match&& match) {
    matches.push_back(std::move(match));
}

void Tournament::calculate_ranking() {
    std::ranges::sort(teams, [](const Team& a, const Team& b) -> bool {
        if (a.points != b.points) return a.points > b.points;
        if (a.top_heights != b.top_heights) return a.top_heights > b.top_heights;
        if (a.goal_delta() != b.goal_delta()) return a.goal_delta() > b.goal_delta();
        if (a.goals_scored != b.goals_scored) return a.goals_scored > b.goals_scored;
        if (a.red_cards != b.red_cards) return a.red_cards < b.red_cards;
        if (a.yellow_cards != b.yellow_cards) return a.yellow_cards < b.yellow_cards;
        std::srand(static_cast<unsigned>(std::time(nullptr)));
        return std::rand() % 2 == 0;
    });
}

void Tournament::print_results() const {
    std::println("Final Ranking:");
    for (const auto& team : teams) {
        std::println("{} - Points: {}, Goals Scored: {}, Goals Conceded: {}, Yellow Cards: {}, Red Cards: {}, Top Heights: {}",
                     team.name, team.points, team.goals_scored, team.goals_conceded, team.yellow_cards, team.red_cards, team.top_heights);
    }
}
