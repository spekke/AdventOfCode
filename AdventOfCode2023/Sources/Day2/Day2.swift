import Foundation
import Parsing

@main
public struct Day2 {

    public static func main() throws {
        let inputURL = Bundle.module.url(forResource: "input", withExtension: "txt")!
        let input = try! String(contentsOf: inputURL)
        
        let testInput = """
        Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
        Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
        Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
        Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
        Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
        """
        
        let games = try parseGames(input: input)
                
        let part1 = part1(games)
        print("part1", part1)
        
        let part2 = part2(games)
        print("part2", part2)
    }
    
    static func part1(_ games: [Game]) -> Int {
        
        let cubesRequirement = [
            CubeAmount(amount: 12, cube: .red),
            CubeAmount(amount: 13, cube: .green),
            CubeAmount(amount: 14, cube: .blue)
        ]
        
        var possibleGames: [Game] = []
        for game in games {
            var valid = true
            for bag in game.bags {
                for cube in bag.cubes {
                    for cubeReq in cubesRequirement {
                        if cube.cube == cubeReq.cube {
                            if cube.amount > cubeReq.amount {
                                valid = false
                            }
                        }
                    }
                }
            }
            if valid {
                possibleGames.append(game)
            }
        }
        return possibleGames.map(\.id).reduce(0, +)
    }
    
    static func part2(_ games: [Game]) -> Int {
        
        var smallestBags: [Bag] = []
        
        for game in games {
            var highestGreen: Int = 0
            var highestRed: Int = 0
            var highestBlue: Int = 0
            
            for bag in game.bags {
                for cube in bag.cubes {
                    switch cube.cube {
                        case .blue:
                            highestBlue = max(highestBlue, cube.amount)
                        case .red:
                            highestRed = max(highestRed, cube.amount)
                        case .green:
                            highestGreen = max(highestGreen, cube.amount)
                    }
                }
            }
            
            let smallestBag = Bag(
                cubes: [
                    CubeAmount(amount: highestGreen, cube: .green),
                    CubeAmount(amount: highestBlue, cube: .blue),
                    CubeAmount(amount: highestRed, cube: .red),
                ]
            )
            smallestBags.append(smallestBag)
        }
        
        return smallestBags.map { $0.cubes.map(\.amount).reduce(1, *)  }.reduce(0, +)
    }
}

func parseGames(input: String) throws -> [Game] {
    let cubesParser = Parse(input: Substring.self) {
        Whitespace(1, .horizontal)
        Int.parser()
        Whitespace(1, .horizontal)
        OneOf(output: CubeAmount.Cube.self) {
            "green".map { .green }
            "blue".map { .blue }
            "red".map { .red }
        }
    }
        .map { CubeAmount(amount: $0, cube: $1) }
    
    let bagsParser = Parse(input: Substring.self) {
        Many {
            Parse(input: Substring.self) {
                Many {
                    cubesParser
                } separator: {
                    ","
                }
            }
                .map { Bag(cubes: $0) }
        } separator: {
            ";"
        }
    }
    
    let gamesParser = Parse(input: Substring.self) {
        Many {
            Parse(input: Substring.self) {
                "Game "
                Int.parser()
                ":"
                bagsParser
            }
                .map { Game(id: $0, bags: $1) }
        } separator: {
            Whitespace(1, .vertical)
        }
    }
    
    return try gamesParser.parse(input)
}

struct Game {
    
    let id: Int
    let bags: [Bag]
}

struct Bag {
    let cubes: [CubeAmount]
}

struct CubeAmount {
    
    enum Cube: String, Equatable {
        case blue, red, green
    }
    
    let amount: Int
    let cube: Cube
}
