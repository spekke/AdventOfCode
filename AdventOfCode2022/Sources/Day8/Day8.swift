import Foundation

@main
public struct Day8 {

    public static func main() {
        let inputURL = Bundle.module.url(forResource: "input", withExtension: "txt")!
        let input = try! String(contentsOf: inputURL)

        let part1 = part1(input)
        print("part1:", part1 ?? "<not found>")

        let part2 = part2(input)
        print("part2:", part2 ?? "<not found>")
    }

    static func part1(_ input: String) -> Int? {
        let matrix = parse(input)
        var counter = ((matrix.count - 1) * 2) + ((matrix[0].count - 1) * 2)

        for y in 1..<matrix.count-1 {
            for x in 1..<matrix[y].count-1 {
                if matrix.isVisible(x: x, y: y) {
                    counter += 1
                }
            }
        }

        return counter
    }

    static func part2(_ input: String) -> Int? {
        let matrix = parse(input)
        var bestScore = 0

        for y in 1..<matrix.count-1 {
            for x in 1..<matrix[y].count-1 {
                let score = matrix.distanceScore(x: x, y: y)
                bestScore = max(bestScore, score)
            }
        }

        return bestScore
    }

    static func parse(_ input: String) -> [[UInt]] {
        return input
            .components(separatedBy: "\n")
            .reduce(into: [[UInt]]()) { result, line in
                let x = line.map { UInt(String($0))! }
                result.append(x)
            }
    }
}

extension Array where Element == [UInt] {

    func isVisible(x: Int, y: Int) -> Bool {
        let value = self[y][x]

        var topVisible = true
        for yTop in 0..<y {
            let topValue = self[yTop][x]
            topVisible = topVisible ? value > topValue : false
        }

        var leftVisible = true
        for xLeft in 0..<x {
            let leftValue = self[y][xLeft]
            leftVisible = leftVisible ? value > leftValue : false
        }

        var rightVisible = true
        for xRight in x+1..<self[y].count {
            let rightValue = self[y][xRight]
            rightVisible = rightVisible ? value > rightValue : false
        }

        var bottomVisible = true
        for yBottom in y+1..<self.count {
            let bottomValue = self[yBottom][x]
            bottomVisible = bottomVisible ? value > bottomValue : false
        }

        return topVisible || leftVisible || rightVisible || bottomVisible
    }

    func distanceScore(x: Int, y: Int) -> Int {
        let value = self[y][x]

        var topScore = 0
        for yTop in (0..<y).reversed() {
            topScore += 1
            if value <= self[yTop][x] {
                break
            }
        }

        var leftScore = 0
        for xLeft in (0..<x).reversed() {
            leftScore += 1
            if value <= self[y][xLeft] {
                break
            }
        }

        var rightScore = 0
        for xRight in x+1..<self[y].count {
            rightScore += 1
            if value <= self[y][xRight] {
                break
            }
        }

        var bottomScore = 0
        for yBottom in y+1..<self.count {
            bottomScore += 1
            if value <= self[yBottom][x] {
                break
            }
        }

        return topScore * leftScore * rightScore * bottomScore
    }
}

let testInput = """
                30373
                25512
                65332
                33549
                35390
                """
