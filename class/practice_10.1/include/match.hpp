#pragma once
#include "team.hpp"

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

    Match(Team& t1, Team& t2, int g1, int g2, int y1, int y2, int r1, int r2, double h1, double h2);

    void update_teams();
};
