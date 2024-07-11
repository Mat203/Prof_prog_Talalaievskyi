import Foundation

class Tournament {
    var teams: [Team] = []
    var matches: [Match] = []

    func addTeam(_ team: Team) {
        teams.append(team)
    }

    func addMatch(_ match: Match) {
        matches.append(match)
    }

    func calculateRanking() {
        teams.sort { a, b in
            if a.points != b.points { return a.points > b.points }
            if a.topHeights != b.topHeights { return a.topHeights > b.topHeights }
            if a.goalDelta() != b.goalDelta() { return a.goalDelta() > b.goalDelta() }
            if a.goalsScored != b.goalsScored { return a.goalsScored > b.goalsScored }
            if a.redCards != b.redCards { return a.redCards < b.redCards }
            if a.yellowCards != b.yellowCards { return a.yellowCards < b.yellowCards }
            return Bool.random()
        }

        if let russiaIndex = teams.firstIndex(where: { $0.name.lowercased() == "russia" }) {
            let russiaTeam = teams.remove(at: russiaIndex)
            teams.append(russiaTeam)
        }
    }

    func printResults() {
        print("Final Ranking:")
        for (index, team) in teams.enumerated() {
            print("\(index + 1). \(team.name) - Points: \(team.points), Goals Scored: \(team.goalsScored), Goals Conceded: \(team.goalsConceded), Yellow Cards: \(team.yellowCards), Red Cards: \(team.redCards), Top Heights: \(team.topHeights)")
        }
    }
}
