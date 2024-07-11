#include <iostream>
#include <vector>
#include <string>
#include <ranges>
#include <algorithm>
#include <random>
#include <ctime>
#include <print>

class Team {
public:
    std::string name;
    int goals_scored = 0;
    int goals_conceded = 0;
    int yellow_cards = 0;
    int red_cards = 0;
    double top_heights = 0.0;
    double points = 0.0;

    Team(const std::string& name) : name(name) {}

    void update_match_result(int scored, int conceded, int yellow, int red, double top_height) {
        goals_scored += scored;
        goals_conceded += conceded;
        yellow_cards += yellow;
        red_cards += red;
        top_heights += top_height;
    }

    int goal_delta() const {
        return goals_scored - goals_conceded;
    }
};

class Match {
public:
    Team& team1;
    Team& team2;
    int goals_team1;
    int goals_team2;
    int yellow_cards_team1;
    int yellow_cards_team2;
    int red_cards_team1;
    int red_cards_team2;
    double top_height_team1;
    double top_height_team2;

    Match(Team& t1, Team& t2, int g1, int g2, int y1, int y2, int r1, int r2, double h1, double h2)
        : team1(t1), team2(t2), goals_team1(g1), goals_team2(g2), yellow_cards_team1(y1),
          yellow_cards_team2(y2), red_cards_team1(r1), red_cards_team2(r2),
          top_height_team1(h1), top_height_team2(h2) {
        update_teams();
    }

    void update_teams() {
        team1.update_match_result(goals_team1, goals_team2, yellow_cards_team1, red_cards_team1, top_height_team1);
        team2.update_match_result(goals_team2, goals_team1, yellow_cards_team2, red_cards_team2, top_height_team2);

        if (goals_team1 > goals_team2) {
            team1.points += 3.14;
            team2.points -= 0.5;
        } else if (goals_team1 < goals_team2) {
            team1.points -= 0.5;
            team2.points += 3.14;
        } else {
            team1.points += 2.71828;
            team2.points += 2.71828;
        }
    }
};

class Tournament {
public:
    std::vector<Team> teams;
    std::vector<Match> matches;

    void add_team(const Team& team) {
        teams.push_back(team);
    }

    void add_match(Match&& match) {
        matches.push_back(std::move(match));
    }

    void calculate_ranking() {
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

    void print_results() const {
        std::println("Final Ranking:");
        for (const auto& team : teams) {
            std::println("{} - Points: {}, Goals Scored: {}, Goals Conceded: {}, Yellow Cards: {}, Red Cards: {}, Top Heights: {}",
                         team.name, team.points, team.goals_scored, team.goals_conceded, team.yellow_cards, team.red_cards, team.top_heights);
        }
    }
};

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
