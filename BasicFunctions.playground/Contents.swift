import Foundation

func square(number: Double) -> Double {
    return number * number
}

// Functions are First-Class Objects
let operation:(Double) -> Double = square

let a = 3.0, b = 4.0

// Import Foundation for use of sqrt
let c = sqrt(operation(a) + operation(b))
print(c)

func logDouble(number:Double) -> Void {
    print(String(format: "%.2f", number))
}
var logger: (Double) -> () = logDouble
logDouble(c)