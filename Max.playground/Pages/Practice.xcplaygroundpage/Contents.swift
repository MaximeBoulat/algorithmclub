//: [Previous](@previous)

import Foundation

var str = "Hello, playground"


struct Heap {
	
	var buffer: [Int] = []
	
	
	func indexOfLeftChild(incomingIndex: Int) -> Int {
		return (2 * incomingIndex) + 1
	}
	
	func indexOfRightChild(incomingIndex: Int) -> Int {
		return (2 * incomingIndex) + 2
	}
	
	func indexOfParent(incomingIndex: Int) -> Int {
		return (incomingIndex / 2) - 1
	}
	
	mutating func heapSort() {
		
		// First get the last parent (the parent of the last element)
		let furthestParentIndex = indexOfParent(incomingIndex: buffer.count - 1)
		
		// Now iterate over every index backwards
		for indexOfParent in (0...furthestParentIndex).reversed() {
			
			heapify(indexOfParent: indexOfParent, endIndex: buffer.count - 1)
		}

		// Now extract the root and re-heapify affected subtrees
		var pointer = buffer.count - 1
		
		while pointer != 0 {
			buffer.swapAt(0, pointer)
			heapify(indexOfParent: 0, endIndex: pointer - 1)
			pointer -= 1
		}
	}
	
	mutating func heapify(indexOfParent: Int, endIndex: Int) {
		
		var indexOfGreatest = indexOfParent
		
		let leftChildIndex = indexOfLeftChild(incomingIndex: indexOfParent)
		if leftChildIndex <= endIndex && buffer[leftChildIndex] > buffer[indexOfGreatest] {
			indexOfGreatest = leftChildIndex
		}
		
		let rightChildIndex = indexOfRightChild(incomingIndex: indexOfParent)
		if rightChildIndex <= endIndex && buffer[rightChildIndex] > buffer[indexOfGreatest] {
			indexOfGreatest = rightChildIndex
		}
		
		if indexOfGreatest != indexOfParent {
			buffer.swapAt(indexOfParent, indexOfGreatest)
			
			// heapify the affected subtree
			heapify(indexOfParent: indexOfGreatest, endIndex: endIndex)
		}
	}
}

var heap = Heap()
heap.buffer = [7, 3, 87, 34, 18, 65, 98]

heap.heapSort()

print("Result = \(heap.buffer)")

var array =  [10, 2, 7, 34, 9, 12, 8, 9, 11, 14]



func createMap(input: [Int]) -> [[(value: Int, index: Int)]] {
	
	var result:  [[(value: Int, index: Int)]] = []
	
	for i in 0..<input.count {
		
		var currentRange: [(value: Int, index: Int)] = []
		
		var current = input[i]
		
		currentRange.append((value: current, index: i))

		for j in i..<input.count {
			
			let incoming = input[j]
			if incoming > current {
				currentRange.append((value: incoming, index: j))
				current = incoming
			}
		}
		
		result.append(currentRange)
		
	}
	
	return result
	
}

var ranges = createMap(input: array)

ranges.forEach {
	print("Evaluating sequence \($0)")
}

func combine(input: [[(value: Int, index: Int)]] ) -> [[(value: Int, index: Int)]] {
	
	var result = ranges
	
	for currentRangeIndex in 0..<ranges.count {
		
		
		let range = ranges[currentRangeIndex]
		
		print("current range: \(range)")
		print("current range index: \(currentRangeIndex)")
		
		var currentRangeRemainingSize = range.count
		
		for currentElementRangeIndex in 0..<range.count {
			let element = range[currentElementRangeIndex]
			currentRangeRemainingSize -= 1
			
			print("     Evaluating current element: \(element)")
			
			// look in the remaining ranges for an index greater than the index of the current element
			let currentElementIndex = element.index
			let currentElementValue = element.value
			
			for incomingRangeIndex in currentRangeIndex+1..<ranges.count {
				print("IncomingRangeIndex = \(incomingRangeIndex)")
				
				let incomingRange = ranges[incomingRangeIndex]
				var incomingRangeRemainingSize = range.count
				
				print("        incoming range: \(incomingRange)")
				print("        incoming range index: \(incomingRangeIndex)")
				
				for incomingElementRangeIndex in 0..<incomingRange.count {
					let incomingElement = incomingRange[incomingElementRangeIndex]
					incomingRangeRemainingSize -= 1
					
					let incomingElementIndex = incomingElement.index
					let incomingElementValue = incomingElement.value
					
					print("            Evaluating incoming element: \(incomingElement)")
					
					if incomingElementIndex > currentElementIndex {
						// we have a potential candidate!
							print("Made it 1")
						
						// Next check if the value is greater than the currentValue
						if incomingElementValue > currentElementValue {
							print("Made it 2")
							
							// Now check if its worth combining these ranges
							if incomingRangeRemainingSize > currentRangeRemainingSize {
								print("Made it 3")
								
								print("Made it!!!")
								
								let strippedCurrentRange = range[0...currentElementRangeIndex]
								let strippedIncomingRange = incomingRange[incomingElementRangeIndex...incomingRange.count-1]
								let newRange = strippedCurrentRange + strippedIncomingRange
								
								result.append(Array(newRange))
								
							}
							
						}
						
					}
				}
			}
		}
	}
	return result
}

var result = combine(input: ranges)

result.forEach {
	print("combined: \($0)")
}

var longestRangeFittingCriteria = result.sorted {
	$0.count > $1.count
}.first

var scrubbed = longestRangeFittingCriteria!.map{
	$0.value
	
}

print("Answer is: \(scrubbed)")

