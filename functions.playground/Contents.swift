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

/*:
 # DEFAULT FUNCTION PARAMETERS
 */
//: In this first test, we leave most of the parameters explicitly named, but give one of them a default value:
func testFunc1(_ inFirstUnnamedParam :Int, inFirstNamedParam: Int, inNamedParamWithDefaultValue: Int = 0, inAnotherNamedParam: Int ) {
    print("inFirstUnnamedParam: \(inFirstUnnamedParam), inFirstNamedParam: \(inFirstNamedParam), inNamedParamWithDefaultValue: \(inNamedParamWithDefaultValue), inAnotherNamedParam: \(inAnotherNamedParam)")
}

print("Testing Set 1:")
//: First, we just call them normally, using explicit names for all:
testFunc1(10, inFirstNamedParam: 20, inNamedParamWithDefaultValue: 40, inAnotherNamedParam: 30)
//: Next, we leave out the one that has a default value:
testFunc1(10, inFirstNamedParam: 20, inAnotherNamedParam: 30)
//: This will cause an error (uncomment to see):
//testFunc1(10, inFirstNamedParam: 20, 40, inAnotherNamedParam: 30)
//: The lesson is that we can leave it out, but if we include it, we need to give it an explicit name

//: In this next one, we have two parameters that are not named, and have default values. The first parameter is unnamed, but does not have a default value, also, the parameter between the two named default parameters does not have a default value:
func testFunc2(_ inFirstUnnamedParam :Int, inFirstNamedParam: Int, _ inUnnamedParamWithDefaultValue: Int = 0, inAnotherNamedParam: Int, _ inAnotherUnnamedParamWithDefaultValue: Int = 5 ) {
    print("inFirstUnnamedParam: \(inFirstUnnamedParam), inFirstNamedParam: \(inFirstNamedParam), inNamedParamWithDefaultValue: \(inUnnamedParamWithDefaultValue), inAnotherNamedParam: \(inAnotherNamedParam), inAnotherUnnamedParamWithDefaultValue: \(inAnotherUnnamedParamWithDefaultValue)")
}

print("\nTesting Set 2:")
//: This will cause an error (uncomment to see the error):
//testFunc2(inFirstNamedParam: 10, inAnotherNamedParam: 30)
//: Note that we MUST supply a value for the first unnamed parameter, as well as the one that sits between the two unnamed parameters with default values:
testFunc2(10, inFirstNamedParam: 103, inAnotherNamedParam: 30)
//: Note that skipping the unnamed default parameters is OK:
testFunc2(10, inFirstNamedParam: 103, 20, inAnotherNamedParam: 30)
//: Note that the "in-between" named parameter allows us to specify a value for the last unnamed default parameter, without having to specify a value for the first unnamed default parameter:
testFunc2(10, inFirstNamedParam: 103, inAnotherNamedParam: 30, 60)
//: Everything specified:
testFunc2(10, inFirstNamedParam: 103, 20, inAnotherNamedParam: 30, 60)

//: This one is almost the same as the one above, but the first unnamed parameter has a default value, so it can be skipped:
func testFunc3(_ inFirstUnnamedParamWithDefaultValue: Int = 0, inFirstNamedParam: Int, _ inUnnamedParamWithDefaultValue: Int = 0, inAnotherNamedParam: Int, _ inAnotherUnnamedParamWithDefaultValue: Int = 5 ) {
    print("inFirstUnnamedParam: \(inFirstUnnamedParamWithDefaultValue), inFirstNamedParam: \(inFirstNamedParam), inNamedParamWithDefaultValue: \(inUnnamedParamWithDefaultValue), inAnotherNamedParam: \(inAnotherNamedParam), inAnotherUnnamedParamWithDefaultValue: \(inAnotherUnnamedParamWithDefaultValue)")
}

print("\nTesting Set 3:")
//: Minimal: We specify only the two parameters that have required names:
testFunc3(inFirstNamedParam: 10, inAnotherNamedParam: 20)
//: Notice that the first named parameter allows us to specify a default value for the SECOND unnamed default value parameter, allowing us to skip the first one:
testFunc3(inFirstNamedParam: 10, 20, inAnotherNamedParam: 30)
//: We can still specify the first default unnamed parameter:
testFunc3(100, inFirstNamedParam: 10, inAnotherNamedParam: 20, 60)
//: Everything specified:
testFunc3(100, inFirstNamedParam: 10, 20, inAnotherNamedParam: 30, 40)

//: OK. Now we get jiggy. We have a function with 5 unnamed and default parameters:
func testFunc4(_ param0: Int = 0, _ param1: Int = 1, _ param2: Int = 2, _ param3: Int = 3, _ param4: Int = 4) {
    print("param0: \(param0), param1: \(param1), param2: \(param2), param3: \(param3), param4: \(param4)")
}

print("\nTesting Set 4:")
//: Note that we can only cascade linearly through the list. You can't pick and choose which parameters to ignore and specify:
testFunc4()
testFunc4(10)
testFunc4(10,20)
testFunc4(10,20,30)
testFunc4(10,20,30,40)
testFunc4(10,20,30,40,50)

//: We stick a named default parameter in the middle of the list:
func testFunc5(_ param0: Int = 0, _ param1: Int = 1, namedParam2: Int = 2, _ param3: Int = 3, _ param4: Int = 4) {
    print("param0: \(param0), param1: \(param1), namedParam2: \(namedParam2), param3: \(param3), param4: \(param4)")
}

print("\nTesting Set 5:")
//: Since everything has a default, we can use the empty tuple argument:
testFunc5()
//: The inline named parameter will allow us to specify unnamed parameters AFTER the named parameter:
//: param0 and param1 are ignored:
testFunc5(namedParam2:64)
testFunc5(namedParam2:64,98)
testFunc5(namedParam2:64,98,34)
//: And we can specify before, but, like the first example, the values need to be linerarly specified:
testFunc5(76)
testFunc5(76,namedParam2:64)
testFunc5(76,namedParam2:64,98)
testFunc5(76,54,namedParam2:64,98)
testFunc5(76,54,namedParam2:64,98,34)

//: In our final example, we add another named default parameter inline, and that will allow us to have a bit more granularity in picking which unnamed ones we want to affect:
func testFunc6(_ param0: Int = 0, namedParam1: Int = 1, _ param2: Int = 2, namedParam3: Int = 3, _ param4: Int = 4) {
    print("param0: \(param0), namedParam1: \(namedParam1), param2: \(param2), namedParam3: \(namedParam3), param4: \(param4)")
}

print("\nTesting Set 6:")
testFunc6()
//: This affects ONLY the first unnamed default parameter (param0):
testFunc6(76)
//: This affects the first unnamed default parameter (param0), and THE UNNAMED PARAMETER AFTER THE FIRST NAMED ONE (param2). It ignores namedParam1, namedParam3 and param4:
testFunc6(76,64)
//: This sets all three of the UNNAMED parameters, but leaves out the named ones:
testFunc6(76,64,98)
//: This ignores param0, namedParam1, param2 and param4. It sets ONLY namedParam3:
testFunc6(namedParam3: 87)
//: This ignores namedParam1, param2 and param4:
testFunc6(76, namedParam3: 87)
//: This ignores param0, param2 and param4:
testFunc6(namedParam1: 65, namedParam3: 87)
//: This causes an error (Uncomment to see the error):
//testFunc6(76, namedParam3: 87, namedParam1: 65)
//: This ignores param0 and param4:
testFunc6(namedParam1: 65, 32, namedParam3: 87)
//: This ignores param0, namedParam1 and param2:
testFunc6(namedParam3: 87, 51)
//: This ignores namedParam1 and param2:
testFunc6(98, namedParam3: 87, 51)
//: This causes an error (uncomment to see the error):
//testFunc6(_, 98, namedParam3: 87, 51)
//: This causes an error (uncomment to see the error):
//testFunc6(nil, 98, namedParam3: 87, 51)

/*:
 # DEFAULT OPTIONALS:
 
 Note that with optional, a value of nil does NOT trigger the default value. It is a legitimate value. You actually have to have no value supplied:
 */

func functionWithOptionalGivenADefaultValue(_ optionalParam: Int? = -7) {
    if nil == optionalParam {
        print("Optional Value is nil")
    } else {
        if -7 == optionalParam! {
            print("Optional Value is the default")
        } else {
            print("Optional Value is: \(optionalParam!)")
        }
    }
}

//: We give an explicit positive 3 value.
functionWithOptionalGivenADefaultValue(3)
//: We give it no value at all, which should result in the default value of -7
functionWithOptionalGivenADefaultValue()
//: We give it a value of nil, which DOES NOT result in the default value.
functionWithOptionalGivenADefaultValue(nil)

func swiftFunctionWithAnOptionalAndANonOptional(param1: Int, param2: Int = 1, param3: Int) {
    print("param1: \(param1), param2: \(param2), param3: \(param3)")
}

//: We will see that optional parameter values do not propagate to function values.

let funcReference = swiftFunctionWithAnOptionalAndANonOptional

swiftFunctionWithAnOptionalAndANonOptional(param1: 10, param2: 20, param3: 30)
swiftFunctionWithAnOptionalAndANonOptional(param1: 10, param3: 30)

funcReference(10, 20, 30)
//: This is an error. Uncomment to see the error.
//funcReference(10, 30)

func swiftAnotherFunctionWithAnOptionalAndANonOptional(_ param1: Int, _ param2: Int = 1, _ param3: Int = 1) {
    print("param1: \(param1), param2: \(param2), param3: \(param3)")
}
swiftAnotherFunctionWithAnOptionalAndANonOptional(10, 20, 30)
swiftAnotherFunctionWithAnOptionalAndANonOptional(10, 20)
swiftAnotherFunctionWithAnOptionalAndANonOptional(10)

let funcReference2 = swiftAnotherFunctionWithAnOptionalAndANonOptional
funcReference2(10, 20, 30)
//: This is an error. Uncomment to see the error.
//funcReference2(10, 20)

//: ## FUNCTION SIGNATURE COLLISION
//: Let's define a function where all of its parameters have defaults.
func swiftFunctionWithPotentiallyEmptyParameterList(param1: Int = 0, param2: Int = 0, param3: Int = 0) {
    print("param1: \(param1), param2: \(param2), param3: \(param3)")
}
//: This means that a valid call to this function would be swiftFunctionWithPotentiallyEmptyParameterList()
//: Now, let's define one with an ACTUAL empty parameter list:
func swiftFunctionWithPotentiallyEmptyParameterList() {
    print("BORK")
}
//: and one with a single fixed parameter:
func swiftFunctionWithPotentiallyEmptyParameterList(param1: Int) {
    print("this is ONLY param1: \(param1)")
}
//: You are allowed to specify a function with a subset of the parameter signature:
func swiftFunctionWithPotentiallyEmptyParameterList(param1: Int = 0, param2: Int = 0) {
    print("This does not have param3 -param1: \(param1), param2: \(param2)")
}
//: Notice where it gets called below. The smaller, more specific parameter list will always trump the more general one.
//: However, you are not allowed to define a function with the same signature, where the only difference is defaults.
//: This causes an error. Uncomment to see the error.
//func swiftFunctionWithPotentiallyEmptyParameterList(param1: Int, param2: Int = 0, param3: Int = 0) {
//    print("param1: \(param1), param2: \(param2), param3: \(param3)")
//}
//: Swift allows you to define them, as they are different function signatures.
//: However, try calling it with an empty parameter list:
swiftFunctionWithPotentiallyEmptyParameterList()
//: Only the actual empty one gets called. There's no way to call the one with all defaults, unless you specify one of its parameters:
swiftFunctionWithPotentiallyEmptyParameterList(param1: 10)
swiftFunctionWithPotentiallyEmptyParameterList(param1: 10, param2: 20)
swiftFunctionWithPotentiallyEmptyParameterList(param1: 10, param2: 20, param3: 30)
swiftFunctionWithPotentiallyEmptyParameterList(param2: 20)
swiftFunctionWithPotentiallyEmptyParameterList(param1: 10, param2: 20)
swiftFunctionWithPotentiallyEmptyParameterList(param2: 20, param3: 30)
swiftFunctionWithPotentiallyEmptyParameterList(param3: 30)
swiftFunctionWithPotentiallyEmptyParameterList(param1: 10, param3: 30)
swiftFunctionWithPotentiallyEmptyParameterList(param2: 20, param3: 30)
//: Now, let's define a function where the first of its parameters has no default.
func anotherSwiftFunctionWithManyDefaultsInParameterList(param1: Int, param2: Int = 0, param3: Int = 0) {
    print("param1: \(param1), param2: \(param2), param3: \(param3)")
}
//: You are allowed to define a function with a fixed single parameter with the same name as the one with a default:
func anotherSwiftFunctionWithManyDefaultsInParameterList(param1: Int) {
    print("only param1: \(param1)")
}

//: This will call the fixed parameter one
anotherSwiftFunctionWithManyDefaultsInParameterList(param1: 100)
//: This will call the one with all the defaults.
anotherSwiftFunctionWithManyDefaultsInParameterList(param1: 100, param2: 200)

/*:
 # FUNCTION SIGNATURES VARIED BY RETURN TYPE
 
 One of the really cool (and potentially dangerous) things about Swift, is that functions can be varied by *return type*; not just the parameter list.
 */

//: Here, we have a standard function that returns an Int:
func returnAnInt() -> Int {
    return 0
}

//: When we call it, we simply assign it, like so:
let thisWillBeAnInt = returnAnInt()

//: "thisWillBeAnInt" will be implicitly declared an Int.

//: However, we can also have the same function, with the same argument list, return different types:
func returnSomething(inParameter: Bool) -> Bool {
    return inParameter
}

func returnSomething(inParameter: Bool) -> Int {
    return inParameter ? 1 : 0
}

func returnSomething(inParameter: Bool) -> Double {
    return inParameter ? 1.0 : 0.0
}

func returnSomething(inParameter: Bool) -> String {
    return inParameter ? "OH, IT'S TWOO, IT'S TWOO, IT'S TWOO!" : "FALSE"
}

//: In a language like C, the above declarations would be illegal, as C uses the parameter list and function name to determine the signature.

//: This does have acaveat, though. You can no longer implicitly declare. You now need to explicitly declare the type expected when calling the function.

//: This will cause an error. Uncomment to see the error:
//let response = returnSomething(inParameter: true)

//: You need to specify each one:
let intResponse: Int = returnSomething(inParameter: true)
let boolResponse: Bool = returnSomething(inParameter: true)
let doubleResponse: Double = returnSomething(inParameter: true)
let stringResponse: String = returnSomething(inParameter: true)

//: Here's an example of how this could be useful.
//: I will declare a type that we'll pretend cleaves to [the Sequence Protocol](https://developer.apple.com/documentation/swift/sequence). It doesn't (because I'm lazy), but let's say that the subscript can be coerced:

class FauxSequence {
    typealias DataTuple = (string: String, int: Int, double: Double, bool: Bool)
    private var _internalData: [DataTuple]
    
    init(_ inDataTuples: [DataTuple]) {
        self._internalData = inDataTuples
    }
    
    //: Now, here's the beef. We have several types of subscripts:
    subscript(_ zeroBasedIndex: Int) -> String {
        let item = self._internalData[zeroBasedIndex]
        
        return item.string
    }
    
    subscript(_ zeroBasedIndex: Int) -> Int {
        let item = self._internalData[zeroBasedIndex]
        
        return item.int
    }
    
    subscript(_ zeroBasedIndex: Int) -> Double {
        let item = self._internalData[zeroBasedIndex]
        
        return item.double
    }
    
    subscript(_ zeroBasedIndex: Int) -> Bool {
        let item = self._internalData[zeroBasedIndex]
        
        return item.bool
    }
}

let fauxData: [FauxSequence.DataTuple] = [
    (string: "Zed", int: 0, double: 0.0, bool: false),
    (string: "Uno", int: 1, double: 1.0, bool: false),
    (string: "Two", int: 2, double: 2.0, bool: true),
    (string: "Twoo", int: 2, double: 2.0, bool: true)
]

let fauxSequence = FauxSequence(fauxData)

let twooString: String = fauxSequence[3]
let zedInt: Int = fauxSequence[0]
let twoDouble: Double = fauxSequence[2]
let wonBool: Bool = fauxSequence[1]

