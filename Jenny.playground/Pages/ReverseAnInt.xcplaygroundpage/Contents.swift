//: [Previous](@previous)

import Foundation

/*
 01/24/2019
 reversing an Int
 
 Input 1234
 Output 4321
 */

/* General Way to convert a While loop to Recusion
 A loop has a few parts:
 
 * the header, and processing before the loop. May declare some new variables
 
 * the condition, when to stop the loop.
 
 * the actual loop body. It changes some of the header's variables and/or the parameters passed in.
 
 * the tail; what happens after the loop and return result.
 
 Or to write it out:
 
 foo_iterative(params){
    header
    while(condition){
        loop_body
    }
    return tail
 }
 
 Using these blocks to make a recursive call is pretty straightforward:
 
 foo_recursive(params){
    header
    return foo_recursion(params, header_vars)
 }
 
 foo_recursion(params, header_vars){
    if(!condition){
        return tail
    }
 
    loop_body
    return foo_recursion(params, modified_header_vars)
 }
*/


/*
 Brute Force approach
 */
func reverse(input: Int) -> Int {
    var leftOverInput = input
    var remainder = 0
    var result = 0
    while leftOverInput > 0 {
        remainder = leftOverInput % 10
        leftOverInput = leftOverInput / 10
        result = result * 10 + remainder
    }
    return result
}

//Recursion
func reverse1(number: Int) -> Int {
    let leftOverInput = input
    let remainder = 0
    let result = reverse_recusive(number: leftOverInput, prefix: remainder)
    return result
}

func reverse_recusive(number: Int, prefix: Int) -> Int {
    if !(number > 0) {
        return number + prefix
    }
    let remainder = number % 10
    let leftOverInput = number / 10
    
    let result = reverse_recusive(number: leftOverInput, prefix: prefix * 10 + remainder)

    return result
}

let input = 1000100

let result = reverse(input: input)
print(result)

let result1 = reverse1(number: input) //recusive approach
print(result1)
