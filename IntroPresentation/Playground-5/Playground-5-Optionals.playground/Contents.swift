/*
 PLAYGROUND 5: Optionals
 
 ©2019 Rift Valley Software. All Rights Reserved.
 */

// Optionals are declared by either using a question mark:

var optionalVar: String?

// It is automatically set to nil when you declare it, so assignment after the fact clears the nil state:

optionalVar = "Hello, World."

// Or an exclamation point:

var implicitOptionalVar: String!

// Same deal here:

implicitOptionalVar = "HELO WRLD"

// You can declare an optional with let:

let anotherOptionalVar: String?

// But once you set it the first time, it's for keeps.

anotherOptionalVar = "Helow Woild"

// That applies to all let constants, but optionals actually have a nil value when first declared.
// This is a compile-time error:
// anotherOptionalVar = "Hello, World"

// if you simply assign from an optional, you get an optional:

let myValue = optionalVar

// This will print "Optional("Hello, World.")", and you will get a compile-time warning; telling you that it was cast to Any:
print(String(describing: myValue))

// In order to uwrap an optional, you use an exclamation mark:
let myNewValue = optionalVar!

// If you do that, then myNewValue is now a regular String.

// This will print "Hello, World":
print(myNewValue)

// If you try that with a nil value:
optionalVar = nil

// It will result in a runtime (not compile time) fatal error:
// let myNewValue2 = optionalVar!

// You can unwrap an optional with a question mark, or even directly, but that needs to happen in some kind of branch statement:

tryMeOut: do {  // Yeah that looks like a GOTO, but it isn't; I swear.
    guard let yetAnotherNewValue = optionalVar else {
        print("Ah-Ah-Ah! You didn't say the magic word!")
        break tryMeOut
    }
    
    print(yetAnotherNewValue)
}

// What happened up there, was that the guard test figured out that optionalVar is nil, and triggered the break. The print after the guard never got called.

// You can also unwrap with a question mark, if the optional has another "stage" to it, like a property or a subscript (which is a function):

var optionalArray: [String]? = ["A", "B", "C"]

// The guard will pass this, and print "C"
tryMeOut: do {
    guard let yetAnotherNewValue = optionalArray?[2] else {
        print("Ah-Ah-Ah! You didn't say the magic word!")
        break tryMeOut
    }
    
    print(yetAnotherNewValue)
}

// Now, we set the optional to nil, and try again:

optionalArray = nil

// This time, the guard fails:
tryMeOut: do {
    guard let yetAnotherNewValue = optionalArray?[2] else {
        print("Ah-Ah-Ah! You didn't say the magic word!")
        break tryMeOut
    }
    
    print(yetAnotherNewValue)
}

// Because optionalArray is an explicit optional, you can't do this:
//tryMeOut: do {
//    guard let yetAnotherNewValue = optionalArray[2] else {
//        print("Ah-Ah-Ah! You didn't say the magic word!")
//        break tryMeOut
//    }
//
//    print(yetAnotherNewValue)
//}
// Note that there's no question mark. The guard needs that to indicate that the optional is to be tested before accessing it.

// Now, let's try the same thing with an implicit optional:
var implicitOptionalArray: [String]! = ["D", "E", "F"]

// The guard will pass this, and print "F"
tryMeOut: do {
    guard let yetAnotherNewValue = implicitOptionalArray?[2] else {
        print("Ah-Ah-Ah! You didn't say the magic word!")
        break tryMeOut
    }
    
    print(yetAnotherNewValue)
}

// Now, we set the optional to nil, and try again:

implicitOptionalArray = nil

// This time, the guard fails:
tryMeOut: do {
    guard let yetAnotherNewValue = implicitOptionalArray?[2] else {
        print("Ah-Ah-Ah! You didn't say the magic word!")
        break tryMeOut
    }
    
    print(yetAnotherNewValue)
}

// And let's try without the question mark again:

// This time, you get a different compiler error.
// Since the implicit optional insists on being treated as a nermal value, the guard doesn't think it can make a choice:
//tryMeOut: do {
//    guard let yetAnotherNewValue = implicitOptionalArray[2] else {
//        print("Ah-Ah-Ah! You didn't say the magic word!")
//        break tryMeOut
//    }
//
//    print(yetAnotherNewValue)
//}

// Now, let's look at what Swift calls the "nil-coalescing" operator. This is a double-question mark. It looks like a ternary operator, but is a bit different.
// What it says, is "if the statements/arguments to my left resolve to nil, then use the thing on my right, instead". It is used for assignments; not execution.

var myTargetString: String = "" // We have a normal (non-optional) String
var myOptionalString: String? = "OPTIONA"

myTargetString = myOptionalString! + "L"    // Need to force-unwrap to use directly. NOTE: This is consiodered bad practice, unless you are GUARANTEED content.

print(myTargetString)   // This will print "OPTIONAL".

// Now, we try the same thing with nil-coalescing:
myTargetString = (myOptionalString ?? "ORTHOGONA") + "L"    // Note no need to unwrap. That's handled in the nil-coalescing operator.

print(myTargetString)   // This will print "OPTIONAL", because the nil-coalescing operator was not invoked.

// Now, let's try that with nil:
myOptionalString = nil

// If we try this, we get a runtime error:
// myTargetString = myOptionalString + "L"

// The nil-coalescing operator, however, gives us a smooth changeover:
myTargetString = (myOptionalString ?? "ORTHOGONA") + "L"

print(myTargetString)   // This will print "ORTHOGONAL", because the nil-coalescing operator was invoked, and supplied the alternative value.

// Finally, let's look at optional chaining.
// Optional chaining is best applied in branch statements. We'll use an if, this time:

// First, let's set up a few instances of optional String:
var optionalStringI: String! = "I"
var optionalStringAm: String! = "am"
var optionalStringA: String! = "a"
var optionalStringLeaf: String! = "leaf"
var optionalStringOn: String! = "on"
var optionalStringThe: String! = "the"
var optionalStringWind: String! = "wind"

// Next, let's set up an optional String Array

var famousLastWords: [String?]! = [optionalStringI, optionalStringAm, optionalStringA, optionalStringLeaf, optionalStringOn, optionalStringThe, optionalStringWind]

// So what we have here, is an implicit optional Array of optional String. It should be noted that, even though the Strings are declared implicit optional, they are still
// allowed in the Array.

// This prints "Optional([Optional("I"), Optional("am"), Optional("a"), Optional("leaf"), Optional("on"), Optional("the"), Optional("wind")])"
print(String(describing: famousLastWords))

// Let's try adding a last, normal, non-optional String literal:
famousLastWords.append("GLURK!")

// This prints "Optional([Optional("I"), Optional("am"), Optional("a"), Optional("leaf"), Optional("on"), Optional("the"), Optional("wind"), Optional("GLURK!")])"
print(String(describing: famousLastWords))

// Note that the last "word" was turned into an optional after assignment, even though it was a String literal. The Array is of Optional String.

// OK. We're now set to try chaining.
// Let's assemble a statement:
let inTheWashOrTheRinse: String = famousLastWords.reduce("") { (current, next) -> String in
    return current + " " + next!    // We need to force-unwrap, unless we will use a branch or nil-coalescing operator (more on that in a bit)
}
// We had to fold, because the Array is of optional String, not String (in which case we could have done a simple joined())

print(inTheWashOrTheRinse) // Prints " I am a leaf on the wind GLURK!"

// Let's set one of the elements to nil. Remember that this is an Array of optional, so it is legit to set an element to nil:
famousLastWords[3] = nil    // Was "leaf"

// This time, you will get a runtime error when you get to the nil (we are force-unwrapping the optional in the reduce closure):
//let inTheWashOrTheRinse2: String = famousLastWords.reduce("") { (current, next) -> String in
//    return current + " " + next!
//}
//
//print(inTheWashOrTheRinse2)

// You can use guard to ameliorate that:
let inTheWashOrTheRinse3: String = famousLastWords.reduce("") { (current, next) -> String in
    guard nil != next else { return current }    // If we run into issues, we return what we have so far.
    return current + " " + next!
}

print(inTheWashOrTheRinse3) // Prints " I am a on the wind GLURK!"

// Or a nil-coalescing operator:
let inTheWashOrTheRinse4: String = famousLastWords.reduce("") { (current, next) -> String in
    return current + " " + (next ?? "flatus")   // We don't need to unwrap, because of the nil-coalescing operator.
}

print(inTheWashOrTheRinse4) // Prints " I am a flatus on the wind GLURK!"

// Let's put "leaf" back:

famousLastWords[3] = "leaf"

// We create a class that will hold and render our last words.
class FamousLastWords {
    var declarationString: [String?]!
    
    init(_ inStringArray: [String?]!) {
        declarationString = inStringArray
    }
    
    var tellMeQuicklyBeforeYouCroak: String {
        return declarationString.reduce("") { (current, next) -> String in
            guard nil != next else { return current }
            return current + " " + next!
        }
    }
}

var famousLastWordObject: FamousLastWords! = FamousLastWords(famousLastWords)

// Since everything is copacetic, this prints no problem.
print(famousLastWordObject.tellMeQuicklyBeforeYouCroak) // Prints "I am a leaf on the wind GLURK!"

// Now, time for flies in the ointment...
// Let's mess with "leaf":
famousLastWordObject.declarationString[3] = nil

// The rendering routine won't have an issue with it.
print(famousLastWordObject.tellMeQuicklyBeforeYouCroak) // Prints "I am a on the wind GLURK!"

// However, how will we get this?
// These will give fatal errors:
//let index2 = String.Index(utf16Offset: 2, in: famousLastWordObject.declarationString[3]!)
//let toBePrinted2: Character = (famousLastWordObject.declarationString[3]?[index])!

// We can quickly find out if the string is good.
if let lastWordString = famousLastWordObject.declarationString[3] {
    print("We have a Last Word: \(lastWordString)!")
} else {
    print("No Last Word!")
}

// However, we may switch the object to a different variable, and nil out the original:
let famousLastWordObject2 = famousLastWordObject
famousLastWordObject = nil

// Let's try that again:
// Ooh..That's gonna leave a mark. We get a runtime error here, because we reference an implicit optional (the famousLastWordObject variable).
//if let lastWordString = famousLastWordObject.declarationString[3] {
//    print("We have a Last Word: \(lastWordString)!")
//} else {
//    print("No Last Word!")
//}

// Watch what happens when we add a question mark in there:
if let lastWordString = famousLastWordObject?.declarationString[3] {
    print("We have a Last Word: \(lastWordString)!")
} else {
    print("No Last Word!")
}

// What we just did, was "chain" optionals. There were actually two tests in that assignment. The first, was we checked to see if the object was good (it wasn't).
// The second would have been to make sure that the fourth element was non-nil. We never made it that far. The first test failed.
// You can make long lines, with lots of question marks. If any one of them is bad, the whole thing politely barfs.
