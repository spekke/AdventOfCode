import Foundation

@main
public struct Day10 {

    public static func main() {

        let inputURL = Bundle.module.url(forResource: "input", withExtension: "txt")!
        let input = try! String(contentsOf: inputURL)

        let instructions = Instruction.parse(input)

        let part1 = part1(instructions)
        print("part1:", part1 ?? "<not found>")

        print("part2:")
        print(part2(instructions))
    }

    static func part1(_ instructions: [Instruction]) -> Int? {

        var signals20th: [Int] = []
        var registerX = 1

        var cycle = 1 {
            didSet {
                if (cycle-20) % 40 == 0 {
                    let signal = cycle * registerX
                    printDebug("# \(cycle) - registerX: \(registerX), signal: \(signal)")
                    signals20th.append(signal)
                }
            }
        }

        for instruction in instructions {
            switch instruction {
                case .noop:
                    cycle += 1
                case .addx(let value):
                    cycle += 1
                    registerX += value
                    cycle += 1
            }
        }

        return signals20th.reduce(0, +)
    }

    static func part2(_ instructions: [Instruction]) -> String {

        var crt: [[Character]] = Array(repeating: Array(repeating: "_", count: 40), count: 6)
        var crtPosition = 0
        var registerX = 1
        var spritePosition: Int { registerX - 1 }

        let updateCRT: () -> Void = {
            let line = crtPosition / 40
            let linePosition = crtPosition % 40
            printDebug("Drawing CRT at position: \(linePosition)")
            let spriteContainsCrtPosition = linePosition >= spritePosition && linePosition <= spritePosition + 2
            crt[line][linePosition] = spriteContainsCrtPosition ? "#" : "."
            crtPosition += 1
        }

        var cycle = 0 {
            didSet {
                printDebug("During cycle \(cycle)")
                updateCRT()
            }
        }

        for instruction in instructions {
            printDebug("")
            switch instruction {
                case .noop:
                    printDebug("Start cycle \(cycle + 1) - NOOP")
                    cycle += 1
                    printDebug("End cycle \(cycle) - NOOP")
                case .addx(let value):
                    printDebug("Start cycle \(cycle + 1), begin executing addx \(value)")
                    cycle += 1
                    printDebug("")
                    cycle += 1
                    registerX += value
                    printDebug("End of cycle \(cycle) - finish executing addx \(value) (Register X is now \(registerX))")
            }
        }

        return screenOutput(crt: crt)
    }
}

func printDebug(_ string: String) {
//    print(string)
}

func screenOutput(crt: [[Character]]) -> String {
    var string = ""
    for row in crt {
        for char in row {
            string.append(char)
        }
        string.append("\n")
    }
    return string
}

enum Instruction {
    case noop
    case addx(Int)

    static func parse(_ input: String) -> [Instruction] {
        return input
            .components(separatedBy: "\n")
                .reduce(into: [Instruction]()) { result, line in
                    let parts = line.components(separatedBy: " ")
                    switch parts[0] {
                        case "addx":
                            result.append(.addx(Int(parts[1])!))
                        case "noop":
                            result.append(.noop)
                        default:
                            fatalError("Unknown instruction: \(parts[0])")
                    }
                }
    }
}

let testInput = """
noop
addx 3
addx -5
"""

let testInput2 = """
addx 15
addx -11
addx 6
addx -3
addx 5
addx -1
addx -8
addx 13
addx 4
noop
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx -35
addx 1
addx 24
addx -19
addx 1
addx 16
addx -11
noop
noop
addx 21
addx -15
noop
noop
addx -3
addx 9
addx 1
addx -3
addx 8
addx 1
addx 5
noop
noop
noop
noop
noop
addx -36
noop
addx 1
addx 7
noop
noop
noop
addx 2
addx 6
noop
noop
noop
noop
noop
addx 1
noop
noop
addx 7
addx 1
noop
addx -13
addx 13
addx 7
noop
addx 1
addx -33
noop
noop
noop
addx 2
noop
noop
noop
addx 8
noop
addx -1
addx 2
addx 1
noop
addx 17
addx -9
addx 1
addx 1
addx -3
addx 11
noop
noop
addx 1
noop
addx 1
noop
noop
addx -13
addx -19
addx 1
addx 3
addx 26
addx -30
addx 12
addx -1
addx 3
addx 1
noop
noop
noop
addx -9
addx 18
addx 1
addx 2
noop
noop
addx 9
noop
noop
noop
addx -1
addx 2
addx -37
addx 1
addx 3
noop
addx 15
addx -21
addx 22
addx -6
addx 1
noop
addx 2
addx 1
noop
addx -10
noop
noop
addx 20
addx 1
addx 2
addx 2
addx -6
addx -11
noop
noop
noop
"""
