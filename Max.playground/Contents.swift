import UIKit


func randomize(array: inout [Int], capacity: Int) {
	
	array.removeAll()
	
	for _ in 0..<capacity {
		
		let random = Int.random(in: 0...100)
		array.append(random)
	}
	
}


// selection sort

func selectionSort(array: [Int]) -> [Int] {
	
	var result = array
	
	for i in 0..<result.count {
		
		// find index of smallest
		let indexOfSmallest = findIndexOfSmallest(startingIndex: i, array: result)
		
		
		// swap the two
		swap(array: &result, start: i, end: indexOfSmallest)
	}
	
	return result
}

func findIndexOfSmallest(startingIndex: Int, array: [Int]) -> Int {
	
	var currentSmallest = Int.max
	var currentSmallestIndex = startingIndex
	
	for i in startingIndex..<array.count {
		
		
		let current = array[i]
		if current < currentSmallest {
			currentSmallest = current
			currentSmallestIndex = i
		}
	}
	
	
	return currentSmallestIndex
}


func swap(array: inout [Int], start: Int, end: Int) {
	
	let store = array[start]
	array[start] = array[end]
	array[end] = store
	
}

var array: [Int] = []
randomize(array: &array, capacity: 10)
let sorted = selectionSort(array: array)

// Merge sort

func merge (array: inout [Int], start: Int, middle: Int, end: Int) {
	
	var lowerHalf = array[start...middle]
	var upperHalf = array[(middle + 1)...end]
	
	var lowerHalfIndex = start
	var upperHalfIndex = middle + 1
	var masterIndex = start
	
	while ((lowerHalfIndex <= middle) && (upperHalfIndex <= end)) {
		let lowerHalfValue = lowerHalf[lowerHalfIndex]
		let upperHalfValue = upperHalf[upperHalfIndex]
		
		if lowerHalfValue < upperHalfValue {
			array[masterIndex] = lowerHalfValue
			lowerHalfIndex += 1
		}
		else {
			array[masterIndex] = upperHalfValue
			upperHalfIndex += 1
		}
		
		masterIndex += 1
	}
	
	while (lowerHalfIndex <= middle) {
		
		let lowerHalfValue = lowerHalf[lowerHalfIndex]
		array[masterIndex] = lowerHalfValue
		lowerHalfIndex += 1
		masterIndex += 1
	}
	
	while (upperHalfIndex <= end) {
		
		let upperHalfValue = upperHalf[upperHalfIndex]
		array[masterIndex] = upperHalfValue
		upperHalfIndex += 1
		masterIndex += 1
	}
	
}


func mergeSort (array: inout [Int], start: Int, end: Int) {
	
	if end > start {
		
		let half = (end - start) / 2 + start
		mergeSort(array: &array, start: start, end: half)
		mergeSort(array: &array, start: half + 1, end: end)
		merge (array: &array, start: start, middle: half, end: end)
		
	}
}

randomize(array: &array, capacity: 3)

mergeSort(array: &array, start: 0, end: array.count - 1)


// insertion sort

func insert(array: inout [Int], rightIndex: Int, value: Int) {
	
	print("evaluating element: \(value), index: \(rightIndex)")
	var index = rightIndex
	
	for i in (0...rightIndex).reversed() {
		
		index = i
		let incoming = array[i]
		
		if incoming > value {
			// shift
			array[i + 1] = array[i]
			array[index] = value
		}
		else {
			// bail
			break
		}
	}
}

func insertionSort(array: inout [Int]) {
	for (index, element) in array.enumerated() {
		
		if index != 0 {
			insert(array: &array, rightIndex: index-1, value: element)
		}
	}
}

randomize(array: &array, capacity: 3)
insertionSort(array: &array)


// Heap sort


struct Heap<Element: Comparable> {
	
	var buffer: [Element] = []
	
	init(elements: [Element]) {
		
		self.buffer = elements
		
		// here we need to reshuffle the array to represent a max heap
		let startIndex = (buffer.count / 2) - 1
		
		for i in (0...startIndex).reversed() {
			heapify(size: startIndex, index: i)
		}
		
		for i in (0...(buffer.count - 1)).reversed() {
			
			let temp = buffer[0]
			buffer[0] = buffer[i]
			buffer[i] = temp
			
			heapify(size: i, index: 0)
			
		}
	}
	
	mutating func heapify(size: Int, index: Int) {
		
		var root = index
		let leftChild = left(i: index)
		let rightChild  = right(i: index)
		
		
		// if left child is larger than root
		if leftChild < size && buffer[leftChild] > buffer[root] {
			root = leftChild
		}
		
		// if right child is larger than root
		if rightChild < size && buffer[rightChild] > buffer[root] {
			root = rightChild
		}
		
		//if reshuffling needs to happen
		if root != index {
			let temp = buffer[index]
			buffer[index] = buffer[root]
			buffer[root] = temp
			
			// recursively heapify affected sub-tree
			heapify(size: size, index: root)
			
		}
	}
	
	
	func left(i: Int) -> Int {
		return (2 * i) + 1
		
	}
	
	func right(i: Int) -> Int {
		return (2 * i) + 2
	}
	
	func parent(i: Int) -> Int {
		return (i - 1) / 2
	}
}

randomize(array: &array, capacity: 100)
let heap = Heap(elements: array)

let result = heap.buffer

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
		
		var shift = 0
		
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


