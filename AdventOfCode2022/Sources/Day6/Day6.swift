import Foundation

@main
public struct Day6 {

    public static func main() {
        let inputURL = Bundle.module.url(forResource: "input", withExtension: "txt")!
        let input = try! String(contentsOf: inputURL)

        let part1 = part1(input)
        print("part1:", part1 ?? "<not found>")

        let part2 = part2(input)
        print("part2:", part2 ?? "<not found>")
    }

    static func part1(_ input: String) -> Int? {
        let characters: [Character] = input.map { $0 }
        return stride(from: 4, to: characters.count, by: 1)
            .first { index in
                Set(characters[index-4..<index]).count == 4
            }
    }

    static func part2(_ input: String) -> Int? {
        let characters: [Character] = input.map { $0 }
        return stride(from: 14, to: characters.count, by: 1)
            .first { index in
                Set(characters[index-14..<index]).count == 14
            }
    }
}

