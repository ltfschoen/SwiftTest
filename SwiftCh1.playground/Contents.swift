//: First Swift App

// Progress: Page 32/32 (Ch1) / 257

// Notes:
// - Swift is statically typed (compile-time type checking)
// - Type inference is Swift best practice (improves readability)
// - Constants (let) are preferred over Variable (var) usage where possible
// - Semi-colons are optional (only required for single line with multiple statements)
// - Explicit Numeric Type Conversion required to create new instance using initialiser (differs from a Cast)
// - Bounds Checking overflow/underflow truncation errors may be opted out from by using Overflow Operators
// - Boolean values only are allowed in the type system (substituting 1 or 0 is not allowed)

// Questions:
// - Why does 'var a = "abc".capitalizedString' work without adding the code 'import Foundation'?
// - Why does the preceding '0' get removed from mobile number when interpolated as a string?
// - Why is there compiler error (String is not convertible to StringLiteralConvertible) when attempt to enumerate a string (p28)?
// - Why did Repeat-While replace Do-While? Has this been updated in the Swift by Tutorials book p29?
// - What is an example of a "Where" Statement as mentioned on p32?

import UIKit
//import Foundation // Import the Foundation framework

let firstname: String = "Luke" // Define variable name of specified type and assigned a value
let surname = "Schoen" // Type Inference by Swift compiler. Explicit type optional.
print(firstname)
print(surname)
let fullname = firstname + " " + surname
// fullname += " (extra1)" // Compiler error since 'fullname' is immutable constant (usagine of 'let')
print(fullname)
//surname = 0 // Compiler error due to assignment of incompatible type
var country = "australia"
country.append(Character("!")) // API methods of the Swift String type used to manipulate values
var countryUp = country.capitalizedString
print(countryUp)

let pi = 3.14
var age = 34.3 // Double type inferred based on provided literal
let fingers = 10 // Int type inferred based on provided literal
let hairs = 10_000_000 // Underscore as thousand seperator
var retired = 2 * pi * Double(fingers) // Numeric Type Conversions must be explicit

var overflow = Int.max &+ 1 // Overflow Operator '&+' used to allow overflow truncation without error
print(Int.max)
print(overflow)

var address: (Int, String) = (6, "main street") // Tuple type variable composing of different types
print(address.0) // Access values of Tuple using indexes
print(address.1)
let (house, street) = address // Deconstruct Tuple elements and assign to constants
print(house)
print(street)
var telephone: (emergency: Int, mobile: Int) = (emergency: 911, mobile: 0424144241) // Named elements
print(telephone.emergency)
print(telephone.mobile)
print("Mobile number is: " + String(telephone.mobile) + ", Street is: " + street)
print("Mobile number is: \(telephone.mobile) and street is \(street.uppercaseString)") // Swift's String Interpolation

for i in 1...2 { // Control flow for-in loop using the shorthand Closed Range Operator (...)
    print("\(i) - \(address)")
}

var range = 1...2
var range2 = 1..<3 // Partially closed range shorthand
var range3 = Range(start: 1, end: 3) // Struct of type Range is equivalent to Closed Range Operator
for i in range {
    print("\(i) - \(address)") // Mutation within for-in loop Enumerating the Range type
}

//for i in "Luke" {
//    print(i)
//}

var i = 0
while i < 3 { // While Loop
    print("\(i) - \(street)")
    i++
}

i = 0
repeat { // Repeat While Loop (replaces Do-While Loop)
    if i % 2 == 0 {
        print("\(i) - \(street)")
    } else {
        print("\(i) - \(street.uppercaseString)")
    }
    i++
} while i < 4

switch street { // Switch Statement can use any type
    case "MAIN STREET", "main street": // Matches multiple values
        print("uppercase or lowercase used")
    default: // Swift requires default matcher to make the Switch Statement exhaustive
        print("unknown case use")
}

var random = 10000

switch random {
    case 1..<100:
        print("low")
    case 100..<1000:
        print("high")
    case 1000..<Int.max:
        print("outside range not allowed")
    default:
        print("error with random value")
}






