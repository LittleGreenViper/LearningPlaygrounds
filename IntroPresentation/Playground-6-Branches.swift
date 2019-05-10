/*
 PLAYGROUND 6: Branches
 */

import Foundation

// Branches (decisons) in Swift are done by switch, if, guard, ternary (?:), nil-coalescing (??), for, and while.
// While and for are loops, and incorporate branches.
// You can use the where clause to constrain a branch.

// switch
// Swift has very powerful switch statements. They can have ranges, full Strings, and enums with associated values.
// They can also be [sort of] incorporated into other branches via the case statement.
// You declare a switch thusly:
let someInteger: Int = 13

switch someInteger {    // Will print "13 is between 10 and 15\n"
case 0..<5:
    print("\(someInteger) is between 0 and 4")
case 5..<10:
    print("\(someInteger) is between 5 and 9")
case 10..<15:
    print("\(someInteger) is between 10 and 15")
case 15..<20:
    print("\(someInteger) is between 15 and 20")
case 20:
    print("\(someInteger) is 20")
default:
    print("\(someInteger) is over 20")
}

// First of all, Swift requires that all switch statements be exhaustive. That means that you must have explicit code to handle ALL eventualities.
// Most times, this means that you need to have a default case, although a switch statement that has cases for every possible case in an enum will also work:

enum OneToFive: Int {
    case one = 1, two, three, four, five
}

let three = OneToFive.three

switch three {  // Prints "3\n"
case .one:
    print("ONE IS THE LONLIEST NUMBAH...")
case .two:
    print("2")
case .three:
    print("3")
case .four:
    print("4")
case .five:
    print("5")
}

// If your switch is not exhaustive, the compiler will yell at you.

// There's also a "shortcut" for single-value switch tests:

if case three = OneToFive.three {
    print("TWEE!")
} else {
    print("Something Else!")
}

let two = OneToFive.two
if case two = OneToFive.three {
    print("TWEE!")
} else {
    print("Something Else!")
}

// Also, Swift switch statements, unlike most other language switch statements, will not "fall through" to the next case, unless you explicitly tell it to:
// In other languages, the switch statement above would have printed "3\n4\n5\n". Instead, it, only printed "3\n", because that was where the switch ended.
// You can add a "fallthrough" statement, which will give the same functionality as standard switches:

switch three {  // Prints "3\n4\n5\n"
case .one:
    print("ONE IS THE LONLIEST NUMBAH...")
    fallthrough
case .two:
    print("2")
    fallthrough
case .three:
    print("3")
    fallthrough
case .four:
    print("4")
    fallthrough
case .five:
    print("5")
}

// This allows case clauses to have an explicit context, like braces:

func printSwitch(_ inSwitchVal: OneToFive) {
    var extra = "OUTSIDE ISSUES"
    
    switch inSwitchVal {
    case .one:
        print("ONE IS THE LONLIEST NUMBAH...")
        let oldExtra = extra
        extra = "I AM ONE"
        print(extra)
        extra = oldExtra
        printSwitch(.two)
    case .two:
        print("2")
        let oldExtra = extra
        extra = "I AM TWO"
        print(extra)
        extra = oldExtra
        printSwitch(.three)
    case .three:
        print("3")
        let oldExtra = extra
        extra = "I AM THREE"
        print(extra)
        extra = oldExtra
        printSwitch(.four)
    case .four:
        print("4")
        let oldExtra = extra
        extra = "I AM FOUR"
        print(extra)
        extra = oldExtra
        printSwitch(.five)
    case .five:
        print("5")
        let oldExtra = extra
        extra = "I AM FIVE"
        print(extra)
        extra = oldExtra
    }

    print(extra)
}

printSwitch(.one)

// In the above recursive function, each case had its own context for the "extra" variable, and also called the function to handle the next value, so it printed:
// "ONE IS THE LONLIEST NUMBAH...\nI AM ONE\n2\nI AM TWO\n3\nI AM THREE\n4\nI AM FOUR\n5\nI AM FIVE\nOUTSIDE ISSUES\nOUTSIDE ISSUES\nOUTSIDE ISSUES\nOUTSIDE ISSUES\nOUTSIDE ISSUES"
// That means that the lines between the "case ...:" and the next "case ...:" had their own context that did not go beyond that area. It is as if there were baces there.
// The surrounding context still applied, so you could access and affect the outside context, but the internal context remained internal.

// There's a LOT more down this rabbit-hole, but this gives you a bit of the flavor for the switch statement, which is really powerful in Swift.

// if
// The Swift if statement is also quite powerful. One of the things about Swift, is that if REQUIRES that the test result in a Boolean true or false, EXCEPT when making an assignment from an optional.

// If we want to test if an Int is 0 or 1, we can't do the same as other languages:

let testSubject: Int = 1

// This will result in a compile-time error:
//if testSubject {
//    print("true")
//} else {
//    print("false")
//}

// You need to do this:
if 1 == testSubject {
    print("true")
} else {
    print("false")
}
// That makes the test Boolean.

// The same goes for nil-testing optionals:

var nilTestOptional: Bool! = nil

// This will result in a compile-time error:
//if nilTestOptional {
//    print("true")
//} else {
//    print("false")
//}

// You need to do this:
if nil != nilTestOptional {
    print("true")
} else {
    print("false")
}

// Of course, Swift throws a bit of a curve-ball into things, by allowing you to assign from optionals, and it does allow that to be tested:
// If the assignment results in nil, we execute the else path:
if let fromOptional = nilTestOptional { // Prints "fromOptional is false\n"
    print("fromOptional is \(fromOptional)")
} else {
    print("fromOptional is false")
}

nilTestOptional = true

// If it is non-nil; regardless of the value, we run the if path:
if let fromOptional = nilTestOptional { // Prints "fromOptional is true\n"
    print("fromOptional is \(fromOptional)")
} else {
    print("fromOptional is false")
}

// That's weird. Why did we not use "\(fromOptional)" in the else path?
// That's because "fromOptional" doesn't exist in the else path. It is constrained to the context formed by the if path.
// This is tremendously useful, as you can restrict a context to only if the comparison is successful (or not successful).

// You can also "chain" assignments in an if statement:

var leafValue: String? = "leaf"
var container1: [String?]? = [leafValue]
var container2: [[String?]?]? = [container1]
var dictionary: [String: [[String?]?]?]? = ["TEST": container2]

if let firstStage = dictionary?["TEST"], let secondStage = firstStage?[0], let leaf = secondStage[0] {
    print("Leaf: \(leaf)")
} else {
    print("NOPE")
}

// You need to add question marks, to tell the if that it is unwrapping optionals. The last step doesn't need it, as seconStage will only be valid if its optional unwrapped, so it is sort of an optional.

// Now, let's bork the first step in that chain:

if let firstStage = dictionary?["TURKEY"], let secondStage = firstStage?[0], let leaf = secondStage[0] {
    print("Leaf: \(leaf)")
} else {
    print("NOPE")
}

// Since the first assignment failed, all the ones after it failed as well.

// Now, we can also do that with implicit optionals:
var leafValue2: String! = "leaf"
var container12: [String?]! = [leafValue]
var container22: [[String?]?]! = [container1]
var dictionary2: [String: [[String?]?]?]! = ["TEST": container2]

if let firstStage = dictionary2?["TEST"], let secondStage = firstStage?[0], let leaf = secondStage[0] {
    print("Leaf: \(leaf)")
} else {
    print("NOPE")
}

// Note the question marks still need to be there.

// Again, this is a deep rabbit-hole. We just scratched the surface, but this shows you that there's a lot under the hood, here.

// guard
// Guard is actually a variant of an if that is especially made to interrupt program flow. It can be though of as a "safe exception."
// You use guard to exit a context if a condition resolves to false. It uses the same assignment and test rules as if.
// guard always has an "else" clause. That clause MUST exit the context. You'll get a compile-time error if it doesn't.
// The context must be an "exitable" one, such as a function, loop, or "do," which really just wraps a context.

// Let's look at the above, with guard used to exit a function if the assignmant fails:

func testGuard(_ inDictionaryKey: String, dictionary inDictionary: [String: [[String?]?]?]?) -> Bool {
    let printPass = "Leaf"
    let printFail = "ARGH!"

    guard let firstStage = dictionary?[inDictionaryKey], let secondStage = firstStage?[0], let leaf = secondStage[0] else {
        print(printFail)    // Note that it had access to the main context up to this point.
        return false
    }
    
    print("\(printPass): \(leaf)")  // The leaf variable is available in the main context.
    return true
}

if !testGuard("TEST", dictionary: dictionary) { // Prints "Leaf: leaf\n"
    print("NOPE")
}

// The function printed "Leaf: leaf\n", as the assignment passed.

if !testGuard("TURKEY", dictionary: dictionary) { // Prints "ARGH!\nNOPE\n"
    print("NOPE")
}

// The function didn't print anything other than "ARGH!". It returned false without printing "Leaf: leaf".
// The secondStage and leaf constants were not available to the guard else context.
// Think of it as a "reverse if." If the test passes, then the assignments are available to the surrounding context, and execution continues.
// If the test fails, then the main context is terminated, and the assignments are not available. There is a temporary contained context after "else" before exit.

// We won't cover the ternary operator, as that is really just another flavor of if, and we've already covered the nil-coalescing operator.

// Loops
// Swift discourages use of the traditional for(i = 0; i < 10; i++){...} style loop from C aand other C-based languages.
// Instead, it has a couple of specialized variants of for, and wants you to use iterators and higher-order functions, where possible.
// Remember that Swift has cribbed a lot from Functional Programming. FP doesn't really use loops. Instead, it tends to use collections, higher-order functions and recursion.
// It does have for loops, though; just not the standard ones. It has a for in loop, like many scripting languages, where you provide a collection or range:

let someCollection = [0,1,2,3,4,5,6,7,8,9]
let intRange: Range<Int> = 0..<10

// You can loop iteratively through a collection (This could also be a Dictionary or Set, but order is not guaranteed for them):
for item in someCollection {
    print("Collection Component: \(item)")
}

// Or you could step through a Range:
for item in intRange {
    print("Range Component: \(item)")
}

// However, you can't step through a Float Range the same way:

let floatRange: Range<Float> = 0.0..<10.0

// This will experience a compile-time error:
//for item in floatRange {
//    print("Range Component: \(item)")
//}

// As you can't sequentially step through a Float. We'll cover how to deal with that in a later playground.

// With a collection, you can also use higher-order functions, like forEach:
someCollection.forEach { item in
    print("Collection Component: \(item)")
}

// One difference between using a for in and a forEach, is that the for in can be interrupted:

for item in someCollection {
    if 5 < item {
        break   // Break says "We're done here."
    }
    print("Collection Component: \(item)")
}

for item in someCollection {
    if 5 < item && 8 > item {
        continue    // Continue says "Skip the rest of this stuff, and just go to the next iteration."
    }
    print("Collection Component: \(item)")
}

// Can't do that with forEach. The following will give a compile-time error:
//someCollection.forEach { item in
//    if 5 < item {
//        break
//    }
//    print("Collection Component: \(item)")
//}

// You can also use where to constrain for loops, so that they only get executed for matching states.
// The following will only print even numbers:
for item in someCollection where 0 == item % 2 {
    print("Collection Component: \(item)")
}

// while
// While can be used either at the start of a loop, or at the end.

// Before
// In order to use a while at the start of a loop, you simply declare it and open a context:

var index = 0

while index < someCollection.count {
    let item = someCollection[index]
    print("Collection Component: \(item)")
    index += 1
}

// After
// To test a condition after a loop, use repeat to open the loop, and put the while at the bottom.

index = 0

repeat {
    let item = someCollection[index]
    print("Collection Component: \(item)")
    index += 1
} while index < someCollection.count - 1    // Need to add -1, here, because we are now testing after the increment.

// While can be continued or broken, but not filtered.

// throw
// Swift doesn't really have exceptions, like C++. Instead, it has "throw," which is more of an error-handler than the hard-core stack-unwrapping of C++.
// Throw is a bit like guard. It allows the program flow to be altered upon request. Unlike guard, it isn't a test. It's a simple imperative.
// You use throw by simply setting up the throw keyword, followed by something that conforms to the Error protocol.
// Program flow stops at that point, and is sent to the nearest context that can "capture" that throw.
// Error throws stop at function boundaries, unless a function is specifically marked as a "throws" function. This is a big difference from classic exceptions.
// You will still encounter exceptions, if using Apple operating systems, as Objective-C throws them, and Objective-C is still prevalent in the Cocoa [Touch] toolkit.
// You won't find any from Swift code, though.

// We'll start by defining a simple enum that conforms to Error (You should define enums as errors for throws):
enum MyError: Error {
    case genericError
    case internalError
    case externalError
    case errorWithBaggage(String)   // This is cool, because you can do things like attach specific error information.
}

// Now, we define a function that has an error throw in it:
//func throwsInternalError() {
//    throw MyError()
//}
// The above won't compile, because it isn't handled. We either need to declare the function as "throws":

func throwsExternalError() throws {
    print("about to throw external error")
    throw MyError.externalError
}

// Or add code to the function to catch and deal with the error:

func handlesInternalError() {
    print("about to throw internal error")
    do {
        throw MyError.internalError
    } catch {   // Catch needs to be "exhaustive" That means that we need to have at least one generic "catch" that grabs the error.
        print("Internal Error: " + String(describing: error.self))
    }
}

handlesInternalError()

// In order to handle an external error, you need to either wrap the function in a do...catch structure:

do {
    try throwsExternalError()   // try says "I know that this could throw an error, and I'm ready for it."
} catch {
    print("External Error: " + String(describing: error.self))
}

// Or use a question-mark try, which means that the failure will be ignored:

try? throwsExternalError()  // In this case, you will see "about to throw external error", and then nothing else, as the execution continues.

// If you use a question-mark try in a do...catch block, you'll get a warning, saying that catch will never be executed.

do {
    try? throwsExternalError()
} catch {
    print("External Error: " + String(describing: error.self))
}

// However, the reason for try? is not so you can avoid dealing with errors. It's so that you can deal with them smoothly.
// Here is a more realistic approach:
// This function will return the given String, but if it is empty, it will throw an error, instead.
func returnAStringIfNotEmpty(_ inString: String = "") throws -> String {
    if inString.isEmpty {
        print("Can't Touch This")
        throw MyError.errorWithBaggage("Can't Touch This")
    }
    
    return inString
}

// This tries three variants, with the third one succeeding.
func fetchAString() -> String {
    if let retStr = try? returnAStringIfNotEmpty() { return retStr }                // Can't touch this
    if let retStr = try? returnAStringIfNotEmpty("") { return retStr }              // Can't touch this
    if let retStr = try? returnAStringIfNotEmpty("Hammertime") { return retStr }    // Hammertime!
    return "Oh dear"    // Won't ever touch this
}

print(fetchAString())

// You can also treat catch a bit like a switch statement:

// First, we'll define a func that throws whatever you give it:
func throwsTheGivenError(_ inError: MyError) throws {
    throw inError
}

// Next, we do a do...catch, with catch keying on the types of errors.

func throwAnErrorAndHandleIt(_ inError: MyError) { // Note no "throws."
    do {
        try throwsTheGivenError(inError)
    } catch MyError.genericError {
        print("Generic Error")
    } catch MyError.internalError {
        print("Internal Error")
    } catch MyError.externalError {
        print("External Error")
    } catch MyError.errorWithBaggage(let errStr) where "Tumi" == errStr {
        print("Error With Expensive Baggage: \(errStr)")
    } catch MyError.errorWithBaggage(let errStr) {
        print("Error With Baggage: \(errStr)")
    } catch {   // This will never get called, but is required in order to make the catch exhaustive.
        print("Default Error: " + String(describing: error.self))
    }
}

throwAnErrorAndHandleIt(.genericError)
throwAnErrorAndHandleIt(.internalError)
throwAnErrorAndHandleIt(.externalError)
throwAnErrorAndHandleIt(.errorWithBaggage("Samsonite"))
throwAnErrorAndHandleIt(.errorWithBaggage("Tumi"))

// There's a lot more to go here, but this is a good intro.
