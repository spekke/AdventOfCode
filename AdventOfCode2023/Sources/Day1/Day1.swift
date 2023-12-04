import Foundation
import Parsing

@main
public struct Day1 {

    public static func main() throws {
        let inputURL = Bundle.module.url(forResource: "input", withExtension: "txt")!
        let input = try! String(contentsOf: inputURL)
        
        
        let part1 = try part1(input)
        print("part1", part1)
        
        let part2 = try part2(input)
        print("part2", part2)
    }
    
    static func part1(_ input: String) throws -> Int {
        let parser = Many {
            Many(1...) {
                Parse(input: Substring.self) {
                    Skip { CharacterSet.letters }
                    Digits(1).map(String.init)
                    Skip { CharacterSet.letters }
                }
            } separator: { "" }
                .compactMap {
                    Int($0[0] + $0[$0.endIndex-1], radix: 10)
                }
        } separator: {
            Whitespace(1, .vertical)
        }
        
        let value = try parser.parse(input)
        let sum = value.reduce(0, +)
        return sum
    }
    
    static func part2(_ input: String) throws -> Int {
        let r = [
            "one": "one1one",
            "two": "two2two",
            "three": "three3three",
            "four": "four4four",
            "five": "five5five",
            "six": "six6six",
            "seven": "seven7seven",
            "eight": "eight8eight",
            "nine": "nine9nine"
        ]
        
        var newinput = input
        for (key, value) in r {
            newinput = newinput.replacingOccurrences(of: key, with: value)
        }
        
        return try part1(newinput)
    }
}
