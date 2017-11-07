import Foundation

/*:
 # PASSING NESTED FUNCTION REFERENCES
 */
//: In this function, we have a signature, where an internal prefix is passed in as a constant argument.
//: The function return is a type reference for a nested function that uses that argument, prepending it to a passed-in runtime argument.
func wrapperFunc1(inTest:String)->((String)->String) {

//: Once the function has been called, the argument becomes "captured." It can't be changed after the fact, and the function is basically a "pass by value" instance.
    
    func internalFunc(inString:String)->String {
        return  inTest + "! " + inString + "?"
    }
    
    return internalFunc
}

//: If we call it and execute it inline, we can expect it to behave correctly.
print(wrapperFunc1(inTest: "HAI")("Howaya"))
//: Now, we get a function reference, with a string denoting the prefix.
let funcPointer1 = wrapperFunc1(inTest: "HAI")
//: At this point, the behavior is pretty much what you'd expect.
print(funcPointer1("Howaya"))
//: Now, the $64,000 question is whether or not this changes that value.
//: If we call it and execute it inline, we can expect it to behave correctly with a new string.
print(wrapperFunc1(inTest: "OHAI")("What Up"))
//: Let's see if it affected the value in the first function reference.
print(funcPointer1("Howaya, Homeboy!"))
//: We set up a second function reference with a new string.
let funcPointer2 = wrapperFunc1(inTest: "OHAI")
print(funcPointer2("What Up"))
//: Let's look at that first function reference again.
print(funcPointer1("Howaya, Homeboy!"))
//: Looks like the answer is "No, it didn't." funcPointer1 still contains the original data, and we can pass in a new suffix string.

//: Now, we try it again, but this time, the initial argument is an inout (pass by reference).
//: Since this causes a compile error, you'll need to uncomment it to see what happens.
//func wrapperFunc2(inTest:inout String)->((String)->String) {
//    func internalFunc(inString:String)->String {
//        return  inTest + "! " + inString + "?"
//    }
//
//    return internalFunc
//}
//: That didn't work.
//: Now, we'll set up a container for the whole test, and use a "globa" scope variable.
//func theBigKahuna(inInitialPrefix: inout String) {
//    //: This time, we don't pass in a prefix value, and use the global, instead.
//    func wrapperFunc()->((String)->String) {
//        func internalFunc(inString:String)->String {
//            return  inInitialPrefix + "! " + inString + "?"
//        }
//
//        return internalFunc
//    }
//
//    print(wrapperFunc()("Howaya"))
//}
//
var bigKahunaString = "HAI"
//theBigKahuna(inInitialPrefix: &bigKahunaString)
//: Damn. That didn't work.
//: Now, we'll set up a container for the whole test, and use a "global" scope variable.
func theBigKahuna2(inInitialPrefix: String) {
    var pseudoGlobal = inInitialPrefix

//: This time, we don't pass in a prefix value, and use the "global," instead.
    
    func wrapperFunc()->((String)->String) {
        func internalFunc(inString:String)->String {
            return  pseudoGlobal + "! " + inString + "?"
        }

        return internalFunc
    }

    print("Pseudoglobal: \(pseudoGlobal)")
    print("Function Inline: " + wrapperFunc()("Howaya"))
    let funcPointer1 = wrapperFunc()

//: OK. At this point, we are changing the value of the "global."
    
    pseudoGlobal = "OHAI"
    print("Pseudoglobal: \(pseudoGlobal)")
    
//: It's not captured, so the new value is shown.
    
    print("Function 1 Reference: " + funcPointer1("Howaya"))
    
//: This also shows the new value.
    
    print("Function Inline: " + wrapperFunc()("What Up"))
    
//: OK. This should show the new value.
    
    let funcPointer2 = wrapperFunc()
    print("Function 2 Reference: " + funcPointer2("What Up"))
    
//: This just proves that we're completely divorced from the main variable.
    
    bigKahunaString = "HAI"
    print("Pseudoglobal: \(pseudoGlobal)")
    print("Function Inline: " + wrapperFunc()("Howaya"))
    print("Function 1 Reference: " + funcPointer1("Howaya"))
    print("Function 2 Reference: " + funcPointer2("Howaya"))
    
//: Back to the internal "global":
    
    pseudoGlobal = "HAI"
    print("Pseudoglobal: \(pseudoGlobal)")
    print("Function Inline: " + wrapperFunc()("Howaya"))
    print("Function 1 Reference: " + funcPointer1("Howaya"))
    print("Function 2 Reference: " + funcPointer2("Howaya"))
}

theBigKahuna2(inInitialPrefix: bigKahunaString)

//: Now, let's look at referencing internal properties.

func hasInternalProperties(inPropertyValue: String)->String {
    let internalProperty = inPropertyValue
    return internalProperty
}

//: The internal properties are obviously "captured."
print(hasInternalProperties(inPropertyValue: "HELO"))
let funky = hasInternalProperties(inPropertyValue: "HOWAYA")
print(hasInternalProperties(inPropertyValue: "JSTDCKY"))
print(funky)

/*:
 Now, we see how a "captured" scope variable can actually be affected, and act as a "captured golbal."
 The "inPrimer" parameter allows an initial value to be set by the factory user.
 This is one of the nice cool things about Swift. When you use a function as a factory, the function's scope *at the time of generation* is captured, and a new context is created.
 Also, subsequent calls to a function reference created from the factory will affect the *captured scope*, not the current scope.
 Iterators and sequences depend heavily on this.
 */

func makeMeASparky(_ inPrimer: Int = 0)->(Int)->Int {
    var totalCount = inPrimer
    
    return {inAddToTotal in totalCount += inAddToTotal; return totalCount}
}

let sparky = makeMeASparky()
print(sparky(10))
print(sparky(10))
print(sparky(10))
print(sparky(10))
print(sparky(10))

let sparky2 = makeMeASparky(1_000)
print(sparky2(10))
print(sparky2(10))
print(sparky2(10))
print(sparky2(10))
print(sparky2(10))

//: In the above calls, the "captured" totalCount variable in the factory function is incremented.
//: Now, this shows that the two captured contexts are distinct:

print(sparky(10))
print(sparky2(10))

