
import Foundation

@main
public struct Day2 {

    enum GameResult: Int {
        case win = 6
        case draw = 3
        case lost = 0

        init(rawValue: String) {
            switch rawValue {
                case "X": self = .lost
                case "Y": self = .draw
                case "Z": self = .win
                default:
                    fatalError("Unsupported rawValue: \(rawValue)")
            }
        }
    }

    enum Shape: Int {
        case rock = 1
        case scissor = 3
        case paper = 2

        init(rawValue: String) {
            switch rawValue {
                case "A", "X": self = .rock
                case "C", "Z": self = .scissor
                case "B", "Y": self = .paper
                default:
                    fatalError("Unsupported rawValue: \(rawValue)")
            }
        }

        func howTo(result: GameResult) -> Shape {
            switch (result, self) {
                case (.lost, .rock): return .scissor
                case (.lost, .scissor): return .paper
                case (.lost, .paper): return .rock
                case (.draw, .rock): return .rock
                case (.draw, .scissor): return .scissor
                case (.draw, .paper): return .paper
                case (.win, .rock): return .paper
                case (.win, .scissor): return .rock
                case (.win, .paper): return .scissor
            }
        }

        func compare(other: Self) -> GameResult {
            switch (self, other) {
                case (.rock, .rock): return .draw
                case (.rock, .paper): return .lost
                case (.rock, .scissor): return .win
                case (.scissor, .rock): return .lost
                case (.scissor, .scissor): return .draw
                case (.scissor, .paper): return .win
                case (.paper, .rock): return .win
                case (.paper, .paper): return .draw
                case (.paper, .scissor): return .lost
            }
        }
    }
    
    public static func main() {
        let inputURL = Bundle.module.url(forResource: "input", withExtension: "txt")!
        let input = try! String(contentsOf: inputURL)

        let part1 = part1(input)
        print("part1", part1)

        let part2 = part2(input)
        print("part2", part2)
    }

    static func part1(_ input: String) -> Int {
        let lines = input.components(separatedBy: "\n")
        let score = lines.reduce(into: 0) { result, line in
            if line.isEmpty { return }
            let shapes = line.components(separatedBy: " ")
            let opponentShape = Shape(rawValue: shapes[0])
            let myShape = Shape(rawValue: shapes[1])
            let gameResult = myShape.compare(other: opponentShape)
            let score = gameResult.rawValue + myShape.rawValue
            result += score
        }
        return score
    }

    static func part2(_ input: String) -> Int {
        let lines = input.components(separatedBy: "\n")
        let score = lines.reduce(into: 0) { result, line in
            if line.isEmpty { return }
            let values = line.components(separatedBy: " ")
            let opponentShape = Shape(rawValue: values[0])
            let gameResult = GameResult(rawValue: values[1])
            let myShape = opponentShape.howTo(result: gameResult)
            let score = gameResult.rawValue + myShape.rawValue
            result += score
        }
        return score
    }
}
