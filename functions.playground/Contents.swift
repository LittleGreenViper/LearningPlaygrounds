import Foundation

/*:
 # SWIFT FUNTIONS, FUNCTION TYPES AND CLOSURES
 
 Swift has a powerful function handling syntax, but it does have a couple of minor "gotchas," which we'll cover here.
 
 ## FUNCTIONS
 
 ### SIMPLE VOID FUNCTIONS
First, we have standard function declarations (**NOTE:** These are also usually referred to as "methods" when associated with classes).
 */

/*: This is an empty function. It does not accept any inputs, nor does it return anything. It simply prints out a phrase that persons "of a certain age" will recognize:
    The only reason for this type of function is to do something in its own context.
    We use these types of functions to consolidate a repetitive simple task into one place. You call it. It does something, then comes back.
 */
func emptyDoNothingFunc01_0() {
    print("\tI know NUH-ting.\n\tnuhhh-TING!")
}

//: Calling it simply executes code in its own context. The only thing that happens in this case, is that something gets output to the console.
print("Calling the first raw function:")
emptyDoNothingFunc01_0()

//: This is the same thing, but the return type is explicitly indicated (an empty tuple ()):
func emptyDoNothingFunc01_1() ->() {
    print("\tI see NUH-ting.\n\tnuhhh-TING!")
}

//: The call to this is exactly the same as the call to the original, and the results are the same.
print("Calling the second raw function:")
emptyDoNothingFunc01_1()

//: This is the same thing, but the return type is explicitly indicated (Void):
func emptyDoNothingFunc01_2() ->Void {
    print("\tI hear NUH-ting.\n\tnuhhh-TING!")
}

//: The call to this is exactly the same as the call to the original, and the results are the same.
print("Calling the third raw function:")
emptyDoNothingFunc01_2()

/*:
 ### SIMPLE DATA TYPE RETURN FUNCTIONS
 Next, we have functions that return something. We'll still avoid parameters for now:
 This is an empty function. It does not accept any inputs, but does emit a String, as opposed to printing something out. Note the return type is now String:
 */
func emptyDoNothingFunc02()->String {
    return "\tI know NUH-ting.\n\tnuhhh-TING!" // We return, as opposed to print.
}

//: The call to this is exactly the same as the call to the original, but now you need to do something with the response:
print("Calling the String return function:")
print(emptyDoNothingFunc02())
//: Note that we wrapped the function in a print statement, as the string is no longer being output to the console. It's being returned as a String.
//: If we tird printing the return from the first (Void) function, we get:
print("Calling the first Void return function, and printing the results:")
print(emptyDoNothingFunc01_0())
//: See? Just an empty tuple (). However, the function still output to the console before returning the tuple.

//: Now, let's return an integer:
func emptyDoNothingFunc03()->Int {
    return 0 // What does Schultz know?
}

//: We'll call the function and print the result:
print("Calling the Int return function:")
print(emptyDoNothingFunc03())
//: Note that it simply output zero. Not so useful. Let's gussy it up:
print("Sexing up the Int return function:")
print("\tI know \(emptyDoNothingFunc03())")

/*:
 ### COMPLEX DATA TYPE RETURN FUNCTIONS
 Next, we have functions that return collection data types:
 
 Let's start with an Array of String:
 */
func emptyDoNothingFunc04()->[String] {
    return ["know", "see", "hear"]
}

//: Now, we'll loop through the Array:
print("Calling the String Array return function:")
for whatDoesSchultz in emptyDoNothingFunc04() {
    print("\tI \(whatDoesSchultz) NUH-ting.\n\tnuhhh-TING!")
}

//: Next, a Dictionary ([String,String]):
func emptyDoNothingFunc05()->[String:String] {
    return ["know":"nuuu-TING!", "see":"nicht", "hear":"eh? WHAT? SPEAK UP!"]
}
//: Now, we'll loop through the Dictionary:
print("Calling the Dictionary return function:")
for (whatDoesSchultz,doHere) in emptyDoNothingFunc05() {
    print("\tI \(whatDoesSchultz) \(doHere)")
}
//: Let's use the Array version to set the order of our output:
print("Calling the Dictionary AND Array return function2:")
for whatDoesSchultz in emptyDoNothingFunc04() {
    let retString = "\tI " + whatDoesSchultz + " " + (emptyDoNothingFunc05()[whatDoesSchultz] ?? "HUH?")
    print(retString)
}
//: Next, let's return a Tuple.
func emptyDoNothingFunc06()->(whatDoesSchultz: String, doHere: String) {
    return (whatDoesSchultz: "know", doHere: "NUH-ting")
}
print("Calling the tuple return function:")
//: We use the tuple directly.
print("\tI " + emptyDoNothingFunc06().whatDoesSchultz + " " + emptyDoNothingFunc06().doHere + ".")
//: This is not optimal...
func emptyDoNothingFunc07()->(whatDoesSchultz: String, doHere: String) {
    print("the function is being called.")
    return (whatDoesSchultz: "know", doHere: "NUH-ting")
}
print("\tI " + emptyDoNothingFunc07().whatDoesSchultz + " " + emptyDoNothingFunc07().doHere + ".")
//: Uh-oh. Not so good. The function was called twice. Let's optimize...
let schultzReport = emptyDoNothingFunc07()
print("\tI " + schultzReport.whatDoesSchultz + " " + schultzReport.doHere + ".")

//: ### PARAMETERS AND ARGUMENTS
//: First, lets' send in one parameter:

