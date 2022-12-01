import Foundation

@main
public struct Day1 {

    public static func main() {

        let inputURL = Bundle.module.url(forResource: "input", withExtension: "txt")!
        let input = try! String(contentsOf: inputURL)

        let part1 = part1(input)
        print("Max calories:", part1)

        let part2 = part2(input)
        print("Max calories from top 3:", part2)
    }

    static func part1(_  input: String) -> Int {

        let segments = input.components(separatedBy: "\n\n")

        let maxCalories = segments.reduce(into: 0) { result, segment in
            let sum = segment
                .components(separatedBy: "\n")
                .compactMap(Int.init)
                .reduce(0, +)
            result = max(sum, result)
        }

        return maxCalories
    }

    static func part2(_  input: String) -> Int {

        let segments = input.components(separatedBy: "\n\n")

        let calories = segments
            .reduce(into: [Int]()) { result, segment in
                let sum = segment
                    .components(separatedBy: "\n")
                    .compactMap(Int.init)
                    .reduce(0, +)
                result.append(sum)
            }
            .sorted(by: { $0 > $1 })

        return calories[..<3].reduce(0, +)
    }
}
