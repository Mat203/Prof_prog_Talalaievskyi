import Foundation

class Match {
    var team1: Team
    var team2: Team
    var goalsTeam1: Int
    var goalsTeam2: Int
    var yellowCardsTeam1: Int
    var yellowCardsTeam2: Int
    var redCardsTeam1: Int
    var redCardsTeam2: Int
    var topHeightTeam1: Double
    var topHeightTeam2: Double

    init(team1: Team, team2: Team, goalsTeam1: Int, goalsTeam2: Int, yellowCardsTeam1: Int, yellowCardsTeam2: Int, redCardsTeam1: Int, redCardsTeam2: Int, topHeightTeam1: Double, topHeightTeam2: Double) {
        self.team1 = team1
        self.team2 = team2
        self.goalsTeam1 = goalsTeam1
        self.goalsTeam2 = goalsTeam2
        self.yellowCardsTeam1 = yellowCardsTeam1
        self.yellowCardsTeam2 = yellowCardsTeam2
        self.redCardsTeam1 = redCardsTeam1
        self.redCardsTeam2 = redCardsTeam2
        self.topHeightTeam1 = topHeightTeam1
        self.topHeightTeam2 = topHeightTeam2
        updateTeams()
    }

    func updateTeams() {
        team1.updateMatchResult(scored: goalsTeam1, conceded: goalsTeam2, yellow: yellowCardsTeam1, red: redCardsTeam1, topHeight: topHeightTeam1)
        team2.updateMatchResult(scored: goalsTeam2, conceded: goalsTeam1, yellow: yellowCardsTeam2, red: redCardsTeam2, topHeight: topHeightTeam2)

        if goalsTeam1 > goalsTeam2 {
            team1.points += 3.14
            team2.points -= 0.5
        } else if goalsTeam1 < goalsTeam2 {
            team1.points -= 0.5
            team2.points += 3.14
        } else {
            team1.points += 2.71828
            team2.points += 2.71828
        }
    }
}

