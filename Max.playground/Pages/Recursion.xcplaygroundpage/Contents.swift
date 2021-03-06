import UIKit




// String permutations

var map = [1 : ["a", "b", "c"],
		   2 : ["d", "e"],
		   3 : ["f", "g", "h", "i"]]

var input = [3, 2, 1]

func permutations(input: [Int], currentResult: [String], map: [Int: [String]]) -> [String] {
	
	switch input.count {
	case 0:
		return currentResult
	default:
		
		switch currentResult.count {
		case 0:
			return permutations(input: Array(input.dropFirst()), currentResult: map[input[0]]!, map: map)
		default:
			var outgoingResult: [String] = []
			for existing in currentResult {
				
				for letter in map[input[0]]! {
					outgoingResult.append(existing + letter)
				}
			}
			return permutations(input: Array(input.dropFirst()), currentResult: outgoingResult, map: map)
		}
	}
}

var perms = permutations(input: input, currentResult: [], map: map)

print("Result = \(perms)")


// Reverse int

func reverse(existing: Int, input: Int) -> Int {
	
	let multiplier = input / 10
	let remainder = input % 10
	let outgoing = (10 * existing) + remainder
	
	if multiplier > 0 {
		return reverse(existing: outgoing, input: multiplier)
	} else {
		return outgoing
	}
}

var result1 = reverse(existing: 0, input: 8758486438759)


// divide and conquer


func reverse2(input: Int) -> (shift: Int, conquered: Int) {
	
	// recursion trap
	guard input / 10 > 0 else {
		return (1, input)
	}
	
	// extract
	let extracted = input % 10
	
	// reduce problem size
	let reduced = input / 10
	
	// recursively conquer
	let recurse = reverse2(input: reduced)
	
	// merge
	let shift = (pow(10, recurse.shift) as NSDecimalNumber).intValue
	let result = (extracted * shift) + recurse.conquered
	
	return (recurse.shift + 1, result)

}

var result2 = reverse2(input: 98682369)

// Towers of Hanoi

struct Towers {
	
	var buffer: [Int : [Int]] = [0 : [],
	1 : [],
	2 : []]
	
	init(segments: [Int]) {
		add(value: segments, column: 0)
		
		print("Towers initiated with buffer: \(buffer)")
	}
	
	mutating func add(value: [Int], column: Int) {
		
		var reversedTower = Array(buffer[column]!.reversed())
		reversedTower += Array(value.reversed())
		buffer[column]! = reversedTower.reversed()
		
	}
	
	mutating func retrieve(column: Int) -> [Int] {
		let result = buffer[column]!
		buffer[column] = []
		return result
	}
	
	mutating func swap(outgoingIndex: Int, incomingIndex: Int) {
		
		// Grab the slice
		let tower = buffer[0]!
		print("retrieved the tower: \(tower)")
		let slice = tower[0..<incomingIndex]
		print("Grabbed the slice: \(slice)")
		let remaining = tower.dropFirst(incomingIndex)
		buffer[0] = Array(remaining)
		print("remains: \(buffer[0]!)")
	
		// First split the slice at the index using the two empty columns
		let inferiorSlice = slice[0..<outgoingIndex]
		print("inferior slice is \(inferiorSlice)")
		let superiorSlice = slice[outgoingIndex...incomingIndex-1]
		print("superior slice is \(superiorSlice)")
		
		add(value: Array(inferiorSlice), column: 2)
		add(value: Array(superiorSlice), column: 1)
		print("1: towers now is \(buffer)")
		
		// Next put the incoming in the middle
		let incoming = buffer[0]![0]
		print("incoming is \(incoming)")
		
		add(value: [incoming], column: 1)
		buffer[0] = Array(buffer[0]!.dropFirst())
		print("2: towers now is \(buffer)")
		
		// Then re-assemble the column
		let solvedSlice = retrieve(column: 2) + retrieve(column: 1)
		print("Solved slice is: \(solvedSlice)")
		add(value: solvedSlice, column: 0)
		print("3: towers now is \(buffer)")
	
	}
}


func doTowersOfHanoi(segments: [Int]) -> Towers {
	
	var pointer: Int = 2
	
	var towers = Towers(segments: segments)
	
	while pointer < segments.count {
		
		// incoming value
		let currentSegment = segments[pointer]
		print("Evaluating segment: \(currentSegment)")
		
		// destination
		var indexOfOutgoingSegment = pointer
		
		// find the index at which to insert
		for i in 0..<pointer {
			
			let incomingSegment = towers.buffer[0]![i]
			if incomingSegment > currentSegment {
				indexOfOutgoingSegment = i
				break
			}
		}
		
		// swap them
		print("Calling swap with pointer: \(pointer), outgoing index: \(indexOfOutgoingSegment)")
		if indexOfOutgoingSegment != pointer {
			towers.swap(outgoingIndex: indexOfOutgoingSegment, incomingIndex: pointer)
		}

		pointer += 1
		
	}
	
	return towers
}

var towersOfHanoi = doTowersOfHanoi(segments: [4, 7, 2, 19, 7, 98, 66, 4, 17, 8, 43, 54, 27])

var towers = Towers(segments: [4, 7, 2, 19, 7, 98, 66, 4, 17, 8, 43, 54, 27])

func towersOfHanoiRecursive(pointer: Int, towers: Towers) -> Towers {
	
	var result = towers
	
	if pointer == result.buffer[0]!.count {
		return result
	}
	
	// incoming value
	let currentSegment = result.buffer[0]![pointer]
	print("Evaluating segment: \(currentSegment)")
	
	// destination
	var indexOfOutgoingSegment = pointer
	
	// find the index at which to insert
	for i in 0..<pointer {
		
		let incomingSegment = towers.buffer[0]![i]
		if incomingSegment > currentSegment {
			indexOfOutgoingSegment = i
			break
		}
	}
	
	// swap them
	print("Calling swap with pointer: \(pointer), outgoing index: \(indexOfOutgoingSegment)")
	if indexOfOutgoingSegment != pointer {
		result.swap(outgoingIndex: indexOfOutgoingSegment, incomingIndex: pointer)
	}
	
	return towersOfHanoiRecursive(pointer: pointer + 1, towers: result)
	
}

towersOfHanoi = towersOfHanoiRecursive(pointer: 2, towers: towers)











