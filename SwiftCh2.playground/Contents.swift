// Progress: Page 41/XX (Ch2) / 257

// Questions:
// - Has '!' as an Optional type value unwrapper been added to the book on p35?
/* - When in playground I use the code 'var str: String? = "Test"; print(str)', the right panel prints 'Test' 'Optional("Test")'. And when I used code 'var str3: String! = "Test2"; str3 = str3.lowercaseString; print(str3)', the right panel just prints 'Test2' ' test2' 'test2', which is expected since it is unwrapped immediately upon initialisation, but when I remove the assignment it does not give an error message saying it unexpectedly found nil while unwrapping an Optional value... (which is expected since it unexpectedly found a nil value for a variable that is of Optional type that is already unwrapped), instead it gives [reason:EXC_BAD_INSTRUCTION code:EXC_I386_IVOP subcode: 0x0]. What is happening here? Why do we not use the syntax 'String?!'?
    Also, given this str3 that has been declared as an Optional type and immediately unwrapped, if we wish to re-wrap it into its Optional type, how is this done? I attempted: str3 = str3?.lowercaseString; print(str3), but the right panel in Playground just displays 'test2' 'test2' (when instead I was expecting it to display 'test2' 'Optional("test2")', since when 'print' is used it displays 'Optional()' wrapper around the value if it is of Optional type
*/
// - How to remove elements in array (pg39)?
// - Why is a dictionary value of Optional type? Why does this code output in the right panel of Playground 'Optional("Luke")': 'var dictionary = [1: "Luke", 2: "Schoen"]; print(dictionary[1])'. How do you Force Unwrap a dictionary value of Optional type when it is declared? ANSWER: Since key that does not exist could be read so the function needs the option of returning nil

import UIKit

//var str: String = nil // Compiler error since nil is not a String.
var str: String? = "Test" // Wrapped 'Optional' type using (?). Value nil not null
print(str)

if let str2 = str { // Long way of accessing underlying value of Optional type
    print(str2)
} else {
    print("was nil") // Use when do not know if Optional contains a value or not
}

str = str!.uppercaseString // Force Unwrap Optional's value when know it's not nil
print("Force unwrapped \(str!.uppercaseString)")

var str3: String! = "Test2" // Implicitly Unwrap variable (with !)
print(str3)
str3 = str3.lowercaseString
print(str3)

var maybeString: String? = "Test3" // Declare variable as Optional type of String
// Optional Chaining triggered by '?'. Runtime checks maybeString Optional contents.
// Where it contains an instance, continue execution, else return nil if contains nil
// Benefits of Optional Chaining: Avoids if/let conditionals.
// Similar to Delegate Pattern (object calls delegate and delegates action 
// responsibilities to another object only if the delegate is already set)

let uppercase = maybeString?.uppercaseString // uppercase Optional type as may be nil
print(uppercase)

var array = [1, 2, 3]
print(array[1]) // Access array element
array.append(4) // Append element to array
array.extend(5...10) // Extend array with sequence

var i = 0
for var i in array {
    if i % 2 == 0 {
//        array.removeAtIndex(i)
    }
    print(array)
    i++
}

var array2: [Int] = [1, 2, 3] // Declare the Type of elements of Swift Array
var array3: [AnyObject] = [1, "a", 3] // AnyObject Type allows any Type
print(array3)

var dictionary = [1: "Luke", 2: "Schoen"] // Key Value Pairs (KVP) strongly typed
// Dictionary<Int, String> (dictionary with these KVP type constraints)
var dictionary2: [Int:String] = [1: "Luke", 2: "Schoen"] // shorthand
var dictionary3: Dictionary<Int, String> = [1: "Luke", 2: "Schoen"] // longhand
print(dictionary[1]) // Access dictionary key value
dictionary[2] = "Skywalker" // Update dictionary key value
print(dictionary)
dictionary[2] = nil // Remove dictionary key value
print(dictionary)

if let value = dictionary[1] { // Safely Unwrap values (caters for nil)
    print("Value is \(value)")
}













