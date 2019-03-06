import Foundation


public func randomize(array: inout [Int], capacity: Int) {
	
	array.removeAll()
	
	for _ in 0..<capacity {
		
		let random = Int.random(in: 0...100)
		array.append(random)
	}
	
}
