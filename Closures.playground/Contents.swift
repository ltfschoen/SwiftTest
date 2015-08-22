// Progress: Page 122
//
// Questions:
//
// - Why does the first and second example of code mentioned on page 119-120 result in compiler error: 'sorted' is unavailable, call the sort() method on the array? Why does it work correctly when 'sort' is used instead of 'sorted'?

import Foundation

/* 'sorted' defined on Array where Method has single parameter 'isOrderedBefore', which is a Function taking two Parameters of Type T (item Type held by Array) and returns Boolean indicating relative order of two given Parameter items. 'sorted' uses the 'isOrderedBefore' Function to build a sorted array returning the result
*/
//func sort(isOrderedBefore: (T, T) -> Bool) -> [T]

// Constant Array
let animals = ["fish", "cat", "chicken", "dog"]

//// Function that determines relative sort order of two strings
//func isBefore(one: String, two: String) -> Bool {
//    return one > two
//}
//
//// Invoke 'sorted' passing a reference to 'isBefore' Function to create sorted array
//let sortedStrings = animals.sort(isBefore)

/* Closure Expression as Anonymous Function (instead of passing a Function Reference to 'sort') avoid extra function declaration and is passed directly instead
*/

//// UNSIMPLIFIED FORM
//let sortedStrings = animals.sort({
//    // List of Params, Return Arrow, Return Type, 'in' keyword
//    (one: String, two: String) -> Bool in
//    // Closure Implementation
//    return one > two
//})

///* SIMPLIFIED FORM #1 - Parameter Types Annotations removed, 'return' keyword removed, closure parentheses removed (as compiler Infers Type from 'sorted' signature
//*/
//let sortedStrings = animals.sort({
//    one, two -> Bool in
//    one > two
//})

///* SIMPLIFIED FORM #2 - Remove Closure Parameter declaration and assign Input Params to Shorthand Numbered Local Constants
//*/
//let sortedStrings = animals.sort({ $0 > $1 })

///* SIMPLIFIED FORM #3 - Convert to Trailing Closure and Remove Empty Parentheses (Closure may be placed outside parentheses when it is passed as last argument to a Function or Method)
//*/
//let sortedStrings = animals.sort { $0 > $1 }

/* SIMPLIFIED FORM #4 - Change to Greater-Than Operator that has same Signature as 'sorted' that takes a parameter of type (String, String) -> Bool
*/
let sortedStrings = animals.sort(>)

///* ALTERNATIVE FORM - Compiler infers isBefore type from closure expression so cannot simplify the closure. It is better to pass the closure directly to 'sort', since it is inline and the compiler may perform more Type Inference
//*/
//var isBefore = {
//    (one: String, two: String) -> Bool in
//    return one > two
//}
//let sortedStrings = animals.sort(isBefore)

print(sortedStrings)