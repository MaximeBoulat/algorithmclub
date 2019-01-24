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




