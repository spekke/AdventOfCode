import Foundation

@main
public struct Day5 {

    struct MoveCommand {
        let numberOfMoves: Int
        let fromColumn: Int
        let toColumn: Int
    }

    public static func main() {
        let inputURL = Bundle.module.url(forResource: "input", withExtension: "txt")!
        let input = try! String(contentsOf: inputURL)

        let parts = input.components(separatedBy: "\n\n")
        let stack = parseStack(parts[0])
        let commands = parseCommands(parts[1])

        let part1 = part1(commands: commands, stack: stack)
        print("part1:", part1)

        let part2 = part2(commands: commands, stack: stack)
        print("part2:", part2)
    }

    static func part1(commands: [MoveCommand], stack: [Int: [Character]]) -> String {
        var stack = stack
        for command in commands {
            for _ in 0..<command.numberOfMoves {
                stack.moveValue(from: command.fromColumn, to: command.toColumn)
            }
        }
        return stack
            .map { (column: $0.key, value: $0.value.last) }
            .sorted(by: { $0.column < $1.column })
            .compactMap(\.value)
            .map { String($0) }
            .joined()
    }

    static func part2(commands: [MoveCommand], stack: [Int: [Character]]) -> String {
        var stack = stack
        for command in commands {
            stack.moveValue(from: command.fromColumn, to: command.toColumn, amount: command.numberOfMoves)
        }
        return stack
            .map { (column: $0.key, value: $0.value.last) }
            .sorted(by: { $0.column < $1.column })
            .compactMap(\.value)
            .map { String($0) }
            .joined()
    }

    static func parseStack(_ input: String) -> [Int: [Character]] {
        print(input)
        let lines = input.components(separatedBy: "\n")
        let columns = Int((CGFloat(lines.first!.count)) / 4.0 + (1.0/4.0))

        var stack: [Int: [Character]] = [:]

        for line in lines.reversed().dropFirst() {
            let parts = line.map { $0 }
            for column in 0..<columns {
                let char = parts[1+(4*column)]
                if !char.isWhitespace {
                    var values = stack[column+1, default: []]
                    values.append(char)
                    stack[column+1] = values
                }
            }
        }
        return stack
    }

    static func parseCommands(_ input: String) -> [MoveCommand] {
        let lines = input.components(separatedBy: "\n")

        return lines.reduce(into: [MoveCommand]()) { result, line in
            let parts = line.components(separatedBy: " ")
            let command = MoveCommand(numberOfMoves: Int(parts[1])!, fromColumn: Int(parts[3])!, toColumn: Int(parts[5])!)
            result.append(command)
        }
    }

}

extension Dictionary where Key == Int, Value == [Character] {

    mutating func moveValue(from: Key, to: Key) {
        guard var sourceValues = self[from] else { return }
        guard let value = sourceValues.popLast() else { return }
        var destinationValues = self[to, default: []]
        destinationValues.append(value)
        self[from] = sourceValues
        self[to] = destinationValues
    }

    mutating func moveValue(from: Key, to: Key, amount: Int) {
        guard var sourceColumn = self[from] else { return }
        let sourceValues = sourceColumn.suffix(amount)
        var destinationColumn = self[to, default: []]
        destinationColumn.append(contentsOf: sourceValues)
        sourceColumn.removeLast(amount)
        self[from] = sourceColumn
        self[to] = destinationColumn
    }
}
