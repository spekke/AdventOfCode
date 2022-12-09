import Foundation

@main
public struct Day9 {

    public static func main() {

        let inputURL = Bundle.module.url(forResource: "input", withExtension: "txt")!
        let input = try! String(contentsOf: inputURL)

        let motions = Motion.parse(input)

        let part1 = part1(motions)
        print("part1:", part1 ?? "<not found>")

        let part2 = part2(motions)
        print("part2:", part2 ?? "<not found>")
    }

    static func part1(_ motions: [Motion]) -> Int? {
        var head = Knot(id: "H")
        var tail = Knot(id: "T")

        for motion in motions {
            for _ in 0..<motion.steps {
                head.move(direction: motion.direction)
                tail.moveBehind(head)
            }
        }

        return tail.visitedPositions.count
    }

    static func part2(_ motions: [Motion]) -> Int? {
        var head = Knot(id: "H")
        var knots = (0..<9).map { Knot(id: String($0)) }

        for motion in motions {
            for _ in 0..<motion.steps {
                head.move(direction: motion.direction)

                for index in 0..<knots.count {
                    var knot = knots[index]
                    let prevKnot = index == 0 ? head : knots[index-1]
                    knot.moveBehind(prevKnot)
                    knots[index] = knot
                }
            }
        }

        return knots.last?.visitedPositions.count
    }
}

struct Position: Hashable {
    var x: Int
    var y: Int
}

struct Knot {
    let id: String
    var point = Position(x: 0, y: 0)
    var visitedPositions: Set<Position> = [Position(x: 0, y: 0)]

    mutating func move(direction: Motion.Direction) {
        self.point.x += direction.move.x
        self.point.y += direction.move.y
        visitedPositions.insert(point)
    }

    mutating func moveBehind(_ knot: Knot) {
        let diffX = knot.point.x - point.x
        let diffY = knot.point.y - point.y

        if abs(diffX) > 1 || abs(diffY) > 1 {
            point.x += diffX == 0 ? 0 : diffX > 0 ? 1 : -1
            point.y += diffY == 0 ? 0 : diffY > 0 ? 1 : -1
            visitedPositions.insert(point)
        }
    }
}

struct Motion {

    enum Direction: String {
        case up = "U"
        case down = "D"
        case left = "L"
        case right = "R"

        var move: Position {
            switch self {
                case .up: return .init(x: 0, y: 1)
                case .down: return .init(x: 0, y: -1)
                case .left:  return .init(x: -1, y: 0)
                case .right: return .init(x: 1, y: 0)
            }
        }
    }
    let direction: Direction
    let steps: Int

    static func parse(_ input: String) -> [Motion] {
        return input
            .components(separatedBy: "\n")
            .reduce(into: [Motion]()) { result, line in
                let parts = line.components(separatedBy: " ")
                let move = Motion(direction: Direction(rawValue: parts[0])!, steps: Int(parts[1])!)
                result.append(move)
            }
    }
}


func printBoard(knots: [Knot], frame: CGRect) {
    for row in stride(from: frame.origin.y, to: frame.size.height, by: 1).reversed() {
        for col in stride(from: frame.origin.x, to: frame.size.width, by: 1) {
            let position = Position(x: Int(col), y: Int(row))
            let knot = knots.first(where: { $0.point == position })
            if let knot = knot {
                print(knot.id, terminator: "")
            }
            else if position == Position(x: 0, y: 0) {
                print("s", terminator: "")
            }
            else {
                print(".", terminator: "")
            }
        }
        print()
    }
}


let testInput = """
                R 4
                U 4
                L 3
                D 1
                R 4
                D 1
                L 5
                R 2
                """

let testInput2 = """
R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20
"""
