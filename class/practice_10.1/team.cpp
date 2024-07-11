#include "team.hpp"

Team::Team(const std::string& name) : name(name) {}

void Team::update_match_result(int scored, int conceded, int yellow, int red, double top_height) {
    goals_scored += scored;
    goals_conceded += conceded;
    yellow_cards += yellow;
    red_cards += red;
    top_heights += top_height;
}

int Team::goal_delta() const {
    return goals_scored - goals_conceded;
}
