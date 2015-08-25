// Progress: Page 152
//
// Questions:
//
// -

/* Imperative Filtering (Traditional) since explicit instructions using basic control structures ("if", "for-in").
   Imperative Problems:
   - Buried in "for-in" loop is testing whether number is even
   - Tight Coupling (adding number to array inside condition)
   - Reuse of code (printing each even number) is made difficult
*/
var evens = [Int]() // Create empty immutable array
for i in 1...10 { // Iterate over range (... is inclusive)
    if i % 2 == 0 {
        evens.append(i)
    }
}
print(evens)

/* Functional Filtering (Using a Function)
*/
func isEven(number: Int) -> Bool {
    return number % 2 == 0
}
/* Create array with value range to array initialiser. "filter" Statement of Array returns new array of items where parameter function is true. Since the parameter function "isEven" is passed as an argument to another function "filter", it is considered a Higher-order Function.
*/
evens = Array(1...10).filter(isEven)
print(evens)

/* Functional Filtering (Using a Closure). Compiler infers type from context.
*/
evens = Array(1...10).filter { (number) in number % 2 == 0 }
print(evens)

/* Functional Filtering (Using a Closure and Argument Shorthand)
*/
evens = Array(1...10).filter { $0 % 2 == 0 }
print(evens)

/* Custom Implementation as a Generic Function with a "source" input (array of type T) and a "predicate" (function taking instance of T and returning a Bool) where the condition to be checked is supplied as a Function
*/
func myFilter<T>(source: [T], predicate:(T) -> Bool) -> [T] {
    var result = [T]()
    for i in source {
        if predicate(i) {
            result.append(i)
        }
    }
    return result
}

/* Condition to be checked is supplied by the Custom Implementation (Generic Function) rather than hard-coded
*/
evens = myFilter(Array(1...10)) { $0 % 2 == 0 }
print(evens)

/* TODO: Convert from myFilter Global Function into a method on Array using a Class Extension and iterate over the array items using 'self' and by performing a cast (page 153)
*/