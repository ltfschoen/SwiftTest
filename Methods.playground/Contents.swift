// Progress: Page 118
//
// Questions:
//
// - What does private(set) do (page 116)?
// - Why doesn't cell.skip(x: 2) work without error. Example implies it works (page 118)?

// Class defined by the CustomStringConvertible (previously known as Printable) Protocol
class Cell: CustomStringConvertible {
    // Properties
    private(set) var row = 0
    private(set) var column = 0
    
    // Mutation Methods
    func move(x: Int, y: Int) {
        row += y
        column += x
    }
    
    // Similar Naming Convention to Apple APIs standard from Objective-C
    func moveByX(x: Int) {
        column += x
    }
    
    func moveByY(y: Int) {
        row += y
    }
    
    // Default Argument Values
    func skip(x: Int = 1, y: Int = 1) {
        row += y
        column += x
    }
    
    // Property
    var description: String {
        get {
            return "Cell [row=\(row), col=\(column)]"
        }
    }
}

// Instantiate Cell Instance. Modify Location
var cell = Cell()
cell.moveByX(4)
cell.move(4, y: 7)
cell.skip()
cell.skip(1, y: 1)
cell.skip(y: 2) // x is left off by Default Value always applies

// Only include Name for second argument
print(cell.description)

/* Methods are First-Class since we can create a Cell Class Instance, assign the moveByY Instance Method to a variable, and invoke the method with a Variable Reference
*/
var cell2 = Cell()
var instanceFunc = cell2.moveByY
instanceFunc(34)
print(cell2.description)

/* Instead of using an Instance Method, a reference to moveByY is obtained using a Class Method on the Cell
*/
var cell3 = Cell()
var moveFunc = Cell.moveByY
// Curried Function invocation Binds to Cell Instance (similar to instanceFunc)
moveFunc(cell3)(68)
print(cell3.description)

