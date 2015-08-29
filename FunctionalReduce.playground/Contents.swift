// Progress: Page 152
//
// Questions:
//
// - Is it correct that to convert to integer we use 'Int(digits)!' instead of 'digits.toInt()' now?

// Purpose: take array input computing sum of even numbers b/w 1 to 10

// Imperative Approach
var evens = [Int]()
for i in 1...10 {
    if i % 2 == 0 {
        evens.append(i)
    }
}

var evenSum = 0
for i in evens {
    evenSum += i
}

print(evenSum)

// Functional Approach (with "reduce" Function)
evenSum = Array(1...10)
    // Construct array with "filter"
    .filter { (number) in number % 2 == 0 }

    /* Execute Function for each element and accumulate the results (page 155).
       - "reduce" Signature: func reduce<U>(initial: U, combine: (U, T) -> U) -> U
       Where:
         - 1st Param - Initial Value (of inferred Type U)
         - 2nd Param - "combine" Function executed once for each element of array
           (taking param U result of previous "combine" invocation, and param T is value of array element being combined)
         - Result U returned from "reduce" is the value returned by last "combine"
    */
    .reduce(0) { (total, number) in total + number }

print(evenSum)

// Purpose: find maximum number in array of integers

let maxNumber = Array(1...10)
    // "total" is result of "max" on last iteration of "reduce"
    .reduce(0) { (total, number) in max(total, number) }
print(maxNumber)

// Purpose: reduce an array of integers into a string

let numbers = Array(1...10)
    .reduce("numbers: ") { (total, number) in total + "\(number) " }
print(numbers)

// Use reduce to take array of digits and convert into integer
let digits = ["3", "1", "4", "1"]
    .reduce(0) { (total, digit) in total * 10 + Int(digit)! }
print(digits)

/* Implement a Custom 'myReduce' Method to Array to mimic the built-in 'reduce' Function. This approach may be used to add our own Functional Methods to Swift
*/
extension Array {
    // Iterate over each item in Array and invoke combiner each time
    func myReduce<T, U>(seed:U, combiner:(U, T) -> U) -> U {
        var current = seed
        for item in self {
            current = combiner(current, item as! T)
        }
        return current
    }
}

// Implementation of Custom 'myReduce' Method
let withMyReduce = Array(1...10)
    .filter { $0 % 2 == 0 }
    .myReduce(0) { $0 + $1 }
print(withMyReduce)