import Foundation

enum Song: String {
    case intro = "Intro"
    case starman = "Starman"
    case showMustGoOn = "Show must go on"
    case letItBe = "Let it be"
    case inTheEnd = "But in the end, it doesn't even matter"
}

enum Command: String {
    case sad, fun, silly, dangerous
}

protocol State {
    var player: MusicPlayer { get }
    func handleCommand(_ command: Command)
    func onEnterState()
}

class IntroState: State {
    unowned var player: MusicPlayer
    
    init(player: MusicPlayer) {
        self.player = player
    }
    
    func handleCommand(_ command: Command) {
        switch command {
        case .dangerous:
            player.transition(to: LetItBeState(player: player))
        case .fun:
            player.transition(to: StarmanState(player: player))
        case .sad:
            player.transition(to: InTheEndState(player: player))
        default:
            break
        }
    }
    
    func onEnterState() {
        print("Now playing: \(Song.intro.rawValue)")
    }
}

class StarmanState: State {
    unowned var player: MusicPlayer
    
    init(player: MusicPlayer) {
        self.player = player
    }
    
    func handleCommand(_ command: Command) {
        switch command {
        case .silly:
            player.transition(to: IntroState(player: player))
        case .dangerous:
            player.transition(to: ShowMustGoOnState(player: player))
        case .fun:
            player.transition(to: InTheEndState(player: player))
        default:
            break
        }
    }
    
    func onEnterState() {
        print("Now playing: \(Song.starman.rawValue)")
    }
}

class ShowMustGoOnState: State {
    unowned var player: MusicPlayer
    
    init(player: MusicPlayer) {
        self.player = player
    }
    
    func handleCommand(_ command: Command) {
        switch command {
        case .sad:
            player.transition(to: LetItBeState(player: player))
        case .fun:
            player.transition(to: StarmanState(player: player))
        default:
            break
        }
    }
    
    func onEnterState() {
        print("Now playing: \(Song.showMustGoOn.rawValue)")
    }
}

class LetItBeState: State {
    unowned var player: MusicPlayer
    
    init(player: MusicPlayer) {
        self.player = player
    }
    
    func handleCommand(_ command: Command) {
        switch command {
        case .dangerous:
            player.transition(to: IntroState(player: player))
        case .silly:
            player.transition(to: ShowMustGoOnState(player: player))
        default:
            break
        }
    }
    
    func onEnterState() {
        print("Now playing: \(Song.letItBe.rawValue)")
    }
}

class InTheEndState: State {
    unowned var player: MusicPlayer
    
    init(player: MusicPlayer) {
        self.player = player
    }
    
    func handleCommand(_ command: Command) {
        print("Now playing: \(Song.inTheEnd.rawValue)")
        exit(0)
    }
    
    func onEnterState() {
        print("Now playing: \(Song.inTheEnd.rawValue)")
    }
}

class MusicPlayer {
    private var state: State
    
    init() {
        self.state = IntroState(player: self)
        state.onEnterState()
    }
    
    func transition(to newState: State) {
        self.state = newState
        newState.onEnterState()
    }
    
    func handleCommand(_ command: Command) {
        state.handleCommand(command)
    }
}

func main() {
    let musicPlayer = MusicPlayer()

    print("Enter a command (sad, fun, silly, dangerous):")

    while let input = readLine(), let command = Command(rawValue: input.lowercased()) {
        musicPlayer.handleCommand(command)
        print("Enter a command (sad, fun, silly, dangerous):")
    }
}

main()
