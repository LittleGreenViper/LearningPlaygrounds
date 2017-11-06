import Foundation

/*:
 # FUNCTION TYPES AND PARAMETER NAMES
 */

//: First, we define a function with explicitly named parameters.
func thisIsABasicFunction(with: Int, and: Int) {
    print("\(with), \(and)")
}

//: You call it in the approved fashion.
thisIsABasicFunction(with: 1, and: 2)

//: Now, assign it to a function reference.
let funcPtr1 = thisIsABasicFunction

//: This will not work (uncomment to see the error).
//funcPtr1(with: 3, and: 4)

//: You need to strip the parameter names when you call the reference.
funcPtr1(3,4)

//: This will not work, either (uncomment to see the error).
//let funcPtr2:(with: Int, and: Int)->Void = thisIsABasicFunction

//: Next, we return a named tuple.
func thisIsABasicFunctionThatReturnsATuple(with: Int, and: Int)->(with: Int, and: Int) {
    return (with: with, and: and)
}

//: Pretty straightforward. Does what it says on the tin.

let tupleoGold = thisIsABasicFunctionThatReturnsATuple(with:5, and: 6)
print("\(tupleoGold.with), \(tupleoGold.and)")

//: However, named tuple data members come across.

let funcPtr2 = thisIsABasicFunctionThatReturnsATuple
let tupleoGold2 = funcPtr2(7,8)
print("\(tupleoGold2.with), \(tupleoGold2.and)")

