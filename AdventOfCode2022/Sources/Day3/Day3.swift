import Foundation

@main
public struct Day3 {

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
        let sum = lines.reduce(into: 0) { result, line in
            let middleIndex = line.index(line.startIndex, offsetBy: line.count/2)
            let compartment1Items = Set(line[line.startIndex..<middleIndex].map { $0 })
            let compartment2Items = Set(line[middleIndex..<line.endIndex].map { $0 })
            let intersection = compartment1Items.intersection(compartment2Items)
            let x = intersection
                .compactMap { characterPriority(char: $0) }
                .reduce(0, +)
            result += x
        }
        return sum
    }

    static func part2(_ input: String) -> Int {
        let lines = input.components(separatedBy: "\n")
        var sum = 0
        for index in stride(from: lines.startIndex, to: lines.endIndex, by: 3) {
            let firstElveItems = Set(lines[index].map { $0 })
            let secondElveItems = Set(lines[index+1].map { $0 })
            let thirdElveItems = Set(lines[index+2].map { $0 })
            let intersection = firstElveItems.intersection(secondElveItems).intersection(thirdElveItems)
            let x = intersection
                .compactMap { characterPriority(char: $0) }
                .reduce(0, +)
            sum += x
        }
        return sum
    }

    static func characterPriority(char: Character) -> Int? {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        guard let offset = characters.firstIndex(of: char)?.utf16Offset(in: characters) else { return 0}
        return offset + 1
    }
}

let testInput1 = """
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
""" // sum: 157

let testInput2 = """
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg

wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
""" // sum: 18 (r) + 52 (Z) = 70

