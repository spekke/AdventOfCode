import Foundation

@main
public struct Day7 {

    public static func main() {
        let inputURL = Bundle.module.url(forResource: "input", withExtension: "txt")!
        let input = try! String(contentsOf: inputURL)

        let part1 = part1(input)
        print("part1:", part1 ?? "<not found>")

        let part2 = part2(input)
        print("part2:", part2 ?? "<not found>")
    }

    static func part1(_ input: String) -> UInt? {
        let rootDirectory = parse(input)
        let matchingDirectories = rootDirectory.find(condition: { $0.size < 100000 })
        return matchingDirectories.map(\.size).reduce(0, +)
    }

    static func part2(_ input: String) -> UInt? {
        let rootDirectory = parse(input)
        let matchingDirectories = rootDirectory.find(condition: { (70000000 - rootDirectory.size) + $0.size > 30000000 })
        return matchingDirectories.map(\.size).sorted(by: { $0 < $1 }).first
    }

    static func parse(_ input: String) -> Directory {
        let rootDirectory = Directory(name: "/")
        var currentDirectory: Directory = rootDirectory
        let lines = input.components(separatedBy: "\n")
        
        for line in lines {
            let components = line.components(separatedBy: " ")
            if components[0] == "$" {
                if components[1] == "cd" {
                    if components[2] == ".." {
                        currentDirectory = currentDirectory.parent!
                    }
                    else if components[2] != "/" {
                        currentDirectory = currentDirectory.directories.first(where: { $0.name == components[2] })!
                    }
                }
            }
            else {
                if components[0] == "dir" {
                    let directory = Directory(name: components[1], parent: currentDirectory)
                    currentDirectory.directories.append(directory)
                }
                else {
                    let file = File(name: components[1], size: UInt(components[0])!)
                    currentDirectory.files.append(file)
                }
            }
        }
        return rootDirectory
    }
}

extension Directory {

    func find(condition: (Directory) -> Bool) -> [Directory] {
        func traverse(directory: Directory, output: inout [Directory]) {
            if condition(directory) {
                output.append(directory)
            }

            for dir in directory.directories {
                traverse(directory: dir, output: &output)
            }
        }

        var directories: [Directory] = []
        traverse(directory: self, output: &directories)
        return directories
    }
}

class Directory {

    weak var parent: Directory?

    let name: String
    var files: [File] = []
    var directories: [Directory] = []

    init(name: String, parent: Directory? = nil) {
        self.parent = parent
        self.name = name
    }

    var size: UInt {
        return Self.calcSize(directory: self)
    }

    private static func calcSize(directory: Directory) -> UInt {
        var totalSize = directory.files.map(\.size).reduce(0, +)
        for dir in directory.directories {
            totalSize += calcSize(directory: dir)
        }
        return totalSize
    }
}

struct File {
    var name: String
    var size: UInt
}

