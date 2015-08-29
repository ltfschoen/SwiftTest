// Progress: Page 164
//
// Questions:
//
// - Why is semi-colon used 'let result = stepTwo(three: 4);' on page 168?

/* Purpose: Use of Partial Application to process delimited data (traditionally using numerous 'split' steps
*/

// Imperative Approach - repeatedly splitting data on the same delimiters OR splitter functions specific to the various types of delimiters contained within the data (i.e. semicolon split method)
import Foundation

// Constant containing structured data groups of numbers (i.e. CSV file)
let data = "5,7;3,4;55,6"

/* 'componentsSeparatedByString' that splits a string based on given delimiter and returns an array containing multiple strings. It is defined by NSString and bridged to Swift String type and so requires importing of Foundation
*/
print(data.componentsSeparatedByString(";"))

/* Functional Approach - Partial Application (generic solution) to processing delimited data, which is the process of "fixing" one or more arguments (i.e. fixing the separator parameter of componentsSeparatedByString) of a function to create a new function, using a Factory-like function that leverages First-Class Functions and Closures (capturing the separator argument within the Closure) where Signature takes a String and returns array of Strings by creating inner-function with the required return type that is implemented using componentsSeparatedByString to return a split string based on given separator
*/

// Use Currying by changing to a Signature with two sets of parameters in parentheses that returns a new function with a separator parameter bound to the given value when invoked (instead of having to manually create the inner function that is returned from the outer 'createSplitter' function)
func createSplitter(separator:String)(source:String) -> [String] {
    return source.componentsSeparatedByString(separator)
}

//func createSplitter(separator:String) -> (String -> [String]) {
//    func split(source:String) -> [String] {
//        return source.componentsSeparatedByString(separator)
//    }
//    return split
//}

// Implementation of reusable Partial Application splitter function

// Split type String by delimiter comma. Note 'source:' prefix name is required since with use of Currying the 'createSplitter' Function requires External Parameter Names
let commaSplitter = createSplitter(",")
print(commaSplitter(source: data))
//print(commaSplitter(data))

// Split type String by delimiter semicolon
let semiColonSplitter = createSplitter(";")
print(commaSplitter(source: data))
//print(semiColonSplitter(data))

// Example: Function that adds three given integers

// Imperative Approach
func addNumbers(one: Int, two: Int, three: Int) -> Int {
    return one + two + three
}

let sum = addNumbers(2, two: 5, three: 4)
print(sum)

/* Currying Approach - Mechanism that executes a sequence of functions with each returning a new function where the provided parameter values are "fixed" and without assigning each step to a variable or constant
*/
func curryAddNumbers(one:Int)(two:Int)(three:Int) -> Int {
    return one + two + three
}

let result2 = curryAddNumbers(2)(two: 5)(three: 4)
print(result2)
//let stepOne = curryAddNumbers(2)
//let stepTwo = stepOne(two: 5)
//let result = stepTwo(three: 4);
//print(result)

// Example of "fixing" more than one parameter at each step of function sequence when using Currying
func curryAndNumbers2(one: Int, two: Int)(three: Int) -> Int {
    return one + two + three
}
let result3 = curryAndNumbers2(2, two: 5)(three: 4)
print(result3)