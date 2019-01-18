import UIKit

var str = "Hello, playground"


//Have a dictionary to look up the corresponding letters for each digit
//After you have located the letters for each digit, perform a vector/multiplication.
var lookupTable = [Int: [String]]()
lookupTable[1] = [""]
lookupTable[2] = ["a", "b", "c"]
lookupTable[3] = ["d", "e", "f"]
lookupTable[4] = ["g", "h", "i"]
lookupTable[5] = ["j", "k", "l"]
lookupTable[6] = ["m", "n", "o"]
lookupTable[7] = ["p", "q", "r", "s"]
lookupTable[8] = ["t", "u", "v"]
lookupTable[9] = ["w", "x", "y", "z"]

func permutation(a: [String], b: [String]) -> [String] {
    var result = [String]()
    for eachFirstDigitLetter in a {
        for eachSecondDigitLetter in b {
            result.append(eachFirstDigitLetter + eachSecondDigitLetter)
        }
    }
    print("Permutation result: \(result)")
    return result
}

func letterCombination(fromDigits digits: [Int]) -> [String] {
    var result = [String]()
    if digits.count == 1 {
        result = lookupTable[digits[0]] ?? ["*"]
        return result
    }
    
    let lastDigit = digits.count - 1

    let subArray = Array(digits[1...lastDigit])

    let tempResult = letterCombination(fromDigits: subArray)

    let firstDigitResult = letterCombination(fromDigits: [digits[0]])

    result = permutation(a: firstDigitResult, b: tempResult)
    
    return result
}

let result = letterCombination(fromDigits: [2, 3, 4])
print(result.count)
