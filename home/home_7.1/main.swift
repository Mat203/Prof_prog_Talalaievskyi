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

class MusicPlayer {
    private var currentSong: Song = .intro
    
    init() {
        print("Now playing: \(currentSong.rawValue)")
    }
    
    func handleCommand(_ command: Command) {
        switch (currentSong, command) {
        case (.intro, .dangerous):
            currentSong = .letItBe
        case (.intro, .fun):
            currentSong = .starman
        case (.intro, .sad):
            currentSong = .inTheEnd
        case (.starman, .silly):
            currentSong = .intro
        case (.starman, .dangerous):
            currentSong = .showMustGoOn
        case (.starman, .fun):
            currentSong = .inTheEnd
        case (.showMustGoOn, .sad):
            currentSong = .letItBe
        case (.showMustGoOn, .fun):
            currentSong = .starman
        case (.letItBe, .dangerous):
            currentSong = .intro
        case (.letItBe, .silly):
            currentSong = .showMustGoOn
        case (.inTheEnd, _):
            print("Now playing: \(currentSong.rawValue)")
            exit(0)
        default:
            break
        }
        
        print("Now playing: \(currentSong.rawValue)")
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
