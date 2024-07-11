#pragma once
#include "team.hpp"
#include "match.hpp"
#include <vector>
#include <string>

class Tournament {
public:
    std::vector<Team> teams;
    std::vector<Match> matches;

    void add_team(const Team& team);
    void add_match(Match&& match);
    void calculate_ranking();
    void print_results() const;
};
