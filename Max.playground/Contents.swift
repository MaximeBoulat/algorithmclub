import UIKit


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

var array = [3, 56, 76, 4, 46, 21, 2, 5, 18, 754, 54, 23, 6]
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
			array[masterIndex] = upperHalfIndex
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


mergeSort(array: &array, start: 0, end: array.count - 1)

print("Is this array sorted? \(array)")

// insertion sort

func insert(array: inout [Int], rightIndex: Int, value: Int) {
	
	var index = rightIndex
	
	for i in (0...rightIndex).reversed() {
		print("evaluating: \(i)")
		index = i
		if array[i] < value {
			break
		}
		
		array[i + 1] = array[i]
	}
	
	array[index+1] = value
	
}

array = [1, 2, 7, 8, 6, 3, 8]

insert(array: &array, rightIndex: 3, value: 6)

print(array)

func insertionSort(array: inout [Int]) {
	for (index, element) in array.enumerated() {
		
		if index != 0 {
			insert(array: &array, rightIndex: index-1, value: element)
		}
	}
}

insertionSort(array: &array)
