#pragma once
#include <string>

class Team {
public:
    std::string name;
    int goals_scored = 0;
    int goals_conceded = 0;
    int yellow_cards = 0;
    int red_cards = 0;
    double top_heights = 0.0;
    double points = 0.0;

    Team(const std::string& name);

    void update_match_result(int scored, int conceded, int yellow, int red, double top_height);

    int goal_delta() const;
};
