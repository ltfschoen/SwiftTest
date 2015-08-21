import Foundation

//func square(number: Double) {
//    // Function parameters are Constants by default (same behaviour as 'let')
//    number = number * number
//}

///* Variable Parameter usage does not produce desired output since the number variable is a local copy of the value passed into the function but does not affect the variable declared outside the function call
//*/
//func square(var number: Double) {
//    number = number * number
//}
//
//var a = 2.0
//square(a)
//print(a)

// Parameters of any type may be designated as in-out
func square(inout number: Double) {
    number = number * number
}

var a = 2.0
// Pass the Value By Reference so the function can modify the value of 'a'
square(&a)
print(a)