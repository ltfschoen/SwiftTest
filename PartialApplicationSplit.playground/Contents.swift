// Progress: Page 164
//
// Questions:
//
// -

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