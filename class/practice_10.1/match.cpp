#include "match.hpp"

Match::Match(Team& t1, Team& t2, int g1, int g2, int y1, int y2, int r1, int r2, double h1, double h2)
    : team1(t1), team2(t2), goals_team1(g1), goals_team2(g2), yellow_cards_team1(y1),
      yellow_cards_team2(y2), red_cards_team1(r1), red_cards_team2(r2),
      top_height_team1(h1), top_height_team2(h2) {
    update_teams();
}

void Match::update_teams() {
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
