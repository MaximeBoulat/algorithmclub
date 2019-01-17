import UIKit

var hashmap = [
    2: ["a", "b", "c"],
    3: ["d", "e", "f"],
    4: ["g", "h", "i"]
]


func listPermutations(input: [Int]) -> [String] {
    switch input.count {
    case 0:
        return []
    case 1:
        return hashmap[input.first!]!
    default:
        let first = hashmap[input.first!]!
        let rest = listPermutations(input: Array(input.dropFirst()))
        return merge(one: first, two: rest)
    }
}


func merge(one: [String], two: [String]) -> [String] {
    var merged = [String]()
    for a in one {
        for b in two {
            merged.append(a + b)
        }
    }
    return merged
}


let permutations = listPermutations(input: [2, 3, 4])
