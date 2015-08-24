// Progress: Page 140
//
// Questions:
//
// - Using a rawValue that does not correspond with an index from the Enum's cases gives error that the 'instance cannot be constructed as it does not have any accessible initializers' (instead of providing a result of 'nil' as page 133 implies should be expected)?
// - Why is it necessary to 'import GLKit' in order to use 'CGRect' without getting error 'use of undeclared type CGRect'? (page 141)?

import GLKit

// Declare Enum with multiple Cases, each represent an Enumerated Value, for use as a Type
enum Shape {
    case Rectangle
    case Square
    case Triangle
    case Circle
}

/* Where:
   - Shape      - Enum's Type Name
   - .Triangle  - Enum's Specific Case

   Swift Type Inference allows dropping of the Enum Type Name from the value side
*/
//var aShape = Shape.Triangle
var aShape: Shape = .Triangle // Declared as being of Type 'Shape'
aShape = .Square // Type already established

/* Declare Enum where the syntax means the Enum holds Raw Values of Type Int. Additionally since the Enum has a Raw Value Type it gains:
    - Property      - rawValue
    - Initialiser   - init(rawValue:)
   Index of the second case rawValue has been changed to 10, so subsequent cases increment after 10 (i.e. 11, 12, etc)

   Raw Values help with Serialising and Deserialising in communication between a server and the app. Defined enumeration on each side allows translation between enumeration case index values and their associated values (i.e. Rectangle)
*/
enum Body: Int {
    case Wide
    case Thin = 10
    case Tall
}

var test1 = Body(rawValue: 0)
var test2 = Body(rawValue: 1)
var thin = Body(rawValue: 10)
var test3 = Body(rawValue: 11)

var tall = Body.Tall
tall.rawValue // returns the Raw Value (zero-indexed) associated with the given Enum Case

//var notAShape = Shape(rawValue: 100)

enum Ratios: Float {
    case tenfold = 10.01
    case decade = 20.02
//    case mummy // Values must be specified when using Raw Values with non-Integer types
}

enum Country {
    case Australia
    case NewZealand
    case Canada
}

var aCountry = Country.Australia

/* Swift Switch Statements must be exhaustive and include the Default case (safety) but Swift has No Fall-Through Logic (such as in Objective-C where each case falls through to the next for cases where no 'break' is included
*/
switch(aCountry) {
    case .Australia, .NewZealand: // Swift handles multiple Enum Cases at once
        print("Asia Pacific")
    case .Canada:
        print("North America")
//    default:
//        break
}

/* Declare Enum Type Name with declared Associated Labels (readability of order and meaning) and Values attached to each Enum Case (to hold dimensions of each kitchen object.
   Associated Values are Not Directly Accessible (differs from access to Properties in Struct or Class) and are not to be confused with Raw Values (that allow representation of Enum Name Type with another type)
   Associated Values may be Accessed when Testing an Enum with a Switch Statement
*/
enum Kitchen {
    case Cutlery(length: Float)
    case Microwave(width: Float, height: Float, depth: Float)
    case Fridge(width: Float, height: Float, depth: Float)
    case Stove(width: Float, height: Float, depth: Float)
}

// Create new instance of the Enum Type with Associate Values
var stove = Kitchen.Stove(width: 50, height: 100, depth: 200)

// Switch Statement to Access Associated Values in Enum by binding them to local variables. Multiple cases for .Stove are included using a 'where' matcher. Order of the Cases in the Switch Statement matter as the the first case than matches is executed first
switch (stove) {
    case .Stove(let width, let height, let depth) where width <= 100 && height <= 100 && depth < 100:
        print("Thin Stove: \(width) x \(height) x \(depth)")
    case .Stove(let width, let height, let depth):
        print("Wide Stove: \(width) x \(height) x \(depth)")
    default:
        print("Other Item")
}

enum Food {
    case Cookie(size: String, toppings: Int)
    case Icecream(size: String, toppings: Int)
    case Slice(width: Float, height: Float)
    
    // Instance Method added to Enum
    func price() -> Float {
        switch(self) {
            case .Cookie(let size, let toppings) where size == "Large" || toppings > 1:
                return 2.5
            case .Icecream(let size, let toppings) where size == "Large" || toppings > 1:
                return 3.5
            case .Slice(let width, let height):
                return 4
            default:
                return 1.75
        }
    }
    
    // Initialiser added to Enum to allow construction of the Enum 'Food' using CGRect. Within the Initialiser we assign to 'self' instead of returning a value
    init(_ rect: CGRect) {
        let width = Float(CGRectGetWidth(rect))
        let height = Float(CGRectGetHeight(rect))
        self = Slice(width: width, height: height)
    }

    /* Static (Factory) Method (called on the Type, i.e. Food, and belongs to the Type itself rather than any Instance) that takes a String and returns the relevant Food value or nil incase of no match (since we have used an Optional return type)
    */
    static func fromString(string: String) -> Food? {
        switch(string) {
            case "cookie":
                return Cookie(size: "Large", toppings: 2)
            case "icecream":
                return Icecream(size: "Large", toppings: 1)
            case "slice":
                return Slice(width: 10, height: 20)
            default:
                return nil
        }
    }
}

var cookie = Food.Cookie(size: "Large", toppings: 3)
var icecream1 = Food.Icecream(size: "Large", toppings: 0)
var slice = Food.Slice(width: 1, height: 2)

switch (cookie) {
    case .Cookie(let size, let toppings) where toppings > 2:
        print("Special")
    case .Cookie(let size, let toppings):
        print("For Sale")
    default:
        print("Not For Sale")
}

cookie.price()
icecream1.price()

// Enum Initialiser Constructor used to create Slice with CGRect
var sliceRect = Food(CGRect(x: 0, y: 0, width: 5, height: 10))
sliceRect.price()

/* Use Static Factory Method of the Enum "Food" to create a Food from a String. Unwrap  the return type (since it is Optional) by using an "if" statement that binds to a local variable
*/
if let moreFood = Food.fromString("slice") {
    moreFood.price()
}