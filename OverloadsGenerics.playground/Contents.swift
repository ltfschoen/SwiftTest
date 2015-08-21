//// Precondition or verification that checks given Int equals another expected Int. If differ writes to console
//func checkAreEqual(value: Int, expected: Int, message: String) {
//    if expected != value {
//        print(message)
//    }
//}
//
//var input = 3
//checkAreEqual(input, expected: 2, message: "Input value of 2 expected")
//input = 47
//checkAreEqual(input, expected: 47, message: "Input value of 47 expected")
//
//// Overloaded Function that now caters for both String and Int
//func checkAreEqual(value: String, expected: String, message: String) {
//    if expected != value {
//        print(message)
//    }
//}
//
//var inString = "cat"
//checkAreEqual(inString, expected: "dog", message: "An input value of dog expected")

// Generic Function with first two parameters having a Type designated by the Placeholder T that is inferred when the function is invoked. Constraints are that the Type must be the same for all arguments using T and it must adopt the Equatable Protocol in implementation of checkAreEqual that leverages the != operator
func checkAreEqual<T: Equatable>(value: T, expected: T, message: String) {
    if expected != value {
        print(message)
    }
}

var input = 2
checkAreEqual(input, expected: 2, message: "Input value of 2 expected")
