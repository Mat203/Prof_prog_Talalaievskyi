import Foundation

class Team {
    var name: String
    var goalsScored: Int
    var goalsConceded: Int
    var yellowCards: Int
    var redCards: Int
    var topHeights: Double
    var points: Double

    init(name: String) {
        self.name = name
        self.goalsScored = 0
        self.goalsConceded = 0
        self.yellowCards = 0
        self.redCards = 0
        self.topHeights = 0.0
        self.points = 0.0
    }

    func updateMatchResult(scored: Int, conceded: Int, yellow: Int, red: Int, topHeight: Double) {
        self.goalsScored += scored
        self.goalsConceded += conceded
        self.yellowCards += yellow
        self.redCards += red
        self.topHeights += topHeight
    }

    func goalDelta() -> Int {
        return self.goalsScored - self.goalsConceded
    }
}
