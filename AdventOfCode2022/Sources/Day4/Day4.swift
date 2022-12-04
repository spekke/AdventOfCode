import Foundation

@main
public struct Day4 {

    public static func main() {
        let inputURL = Bundle.module.url(forResource: "input", withExtension: "txt")!
        let input = try! String(contentsOf: inputURL)

        let part1 = part1(input)
        print("part1:", part1)

        let part2 = part2(input)
        print("part2:", part2)
    }

    static func part1(_ input: String) -> Int {
        let lines = input.components(separatedBy: "\n")
        var count = 0
        for line in lines {
            let parts = line.components(separatedBy: ",")
            let firstRange = expand(range: parts[0])
            let secondRange = expand(range: parts[1])
            if secondRange.isSubset(of: firstRange) || firstRange.isSubset(of: secondRange) {
                count += 1
            }
        }
        return count
    }

    static func part2(_ input: String) -> Int {
        let lines = input.components(separatedBy: "\n")
        var count = 0
        for line in lines {
            let parts = line.components(separatedBy: ",")
            let firstRange = expand(range: parts[0])
            let secondRange = expand(range: parts[1])
            if firstRange.intersection(secondRange).count > 0 {
                count += 1
            }
        }
        return count
    }

    static func expand(range: String) -> Set<Int> {
        let parts = range.components(separatedBy: "-")
        let start = Int(parts[0])!
        let end = Int(parts[1])!
        return Set((start...end).map { $0 })
    }
}

let testInput = """
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
"""
