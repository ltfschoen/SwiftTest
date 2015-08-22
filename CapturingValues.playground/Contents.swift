// Progress: Page 125
//
// Questions:
//
// -

import Foundation

/* Closures Capturing Values (Constants and Variables) from context for use during and after context destroyed. 
*/
/* Function type that returns integer (each representing a State) on each invocation as the State Machine cycles through
*/
typealias StateMachineType = () -> Int

/* Function that creates a State Machine of required cardinality based on quantity of States it cycles through
*/
func makeStateMachine(maxState: Int) -> StateMachineType {
    /* Local Variable stores current state of machine under construction. 
       - Value Capture is demonstrated in that we expect currentState (Local Variable) to be destroyed when the Function returns, however the State Machine requires this currentValue variable to be captured and still be available to the Closure Expression returned from makeStateMachine for use beyond the lifecycle of its defining context.
       - Memory Management of Captured Values is automatically determined by Swift, such that Swift disposes of them when the Closure is disposed of
    */
    var currentState: Int = 0

    /* Return a Closure Expression that is itself a state machine. Omit Signature of Closure Expression () -> Int since compiler may Infer its Type from Signature of enclosing function
    */
    return {
        currentState++
        if currentState > maxState {
            currentState = 0
        }
        return currentState
    }
}

let tristate = makeStateMachine(2)
print(tristate())
print(tristate())
print(tristate())
print(tristate())
print(tristate())
print(tristate())

let bistate = makeStateMachine(1)
print(bistate())
print(bistate())
print(bistate())
print(bistate())