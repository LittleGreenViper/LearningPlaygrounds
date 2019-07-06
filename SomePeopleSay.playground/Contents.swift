protocol P {
    func printAhh();
}

// Default implementation
extension P {
    func printAhh() {
        print("AHHH...")
    }
}

// S0 uses the default
struct S0 : P {
    func printOoh() {
        print("OOOOHHH!")
    }
}

// These replace the default with their own, and add their own functions.
struct S1 : P {
    func printAhh() {
        print("AH")
    }
    func printArgh() {
        print("ARGH...")
    }
}

struct S2 : P {
    func printAhh() {
        print("WHUT?")
    }
    func printOoh() {
        print("OO")
    }
}

// Note that S2 has a "printOoh()" function, just like S0. However, these are different.
// They aren't promised by the protocol, so they can't be considered to be that instance's implementation of a protocol contract.
// They are allowed, because there's no relationship between S2 and S0, other than that specified by the P protocol.

// Note that there's no issue with this. The function can return ANY ONE OF S0, S1, or S2.
func genericProtocolReturn(_ x: Int) -> P {
    switch x {
    case ...5:
        return S0()

    case 5...10:
        return S1()
        
    default:
        return S2()
    }
}

// If you make it a "some" response, though, you have to decide what will be returned. There can only be one (Highlander quote).
func specificProtocolReturnS1(_ x: Int) -> some P {
// Uncomment the lines below to see an error.
//    switch x {
//    case ...5:
//        return S0()
//
//    case 5...10:
//        return S1()
//
//    default:
//        return S2()
//    }

    return S1()
}

func specificProtocolReturnS2(_ x: Int) -> some P {
// Uncomment the lines below to see an error.
//    switch x {
//    default:
//        return S0()
//    }

    return S2()
}

// The below won't work. You get:
// error: Protocol 'Collection' can only be used as a generic constraint because it has Self or associated type requirements
// Collection is a protocol with an associated type
//func giveMeACollection() -> Collection {
//    return [1, 2, 3]
//}

// Protocol P2 is a PAT (Protocol with Associated Type). Currently, Swift does not allow these protocols to be used as type placeholders.
protocol P2 {
    associatedtype PType
    var returnSomething: PType { get }
}

// We define a struct that conforms to P2, giving the type as a String
struct S3 : P2 {
    typealias PType = String
    var returnSomething: PType {
        return "One"
    }
}

// We define a struct that conforms to P2, giving the type as an Int
struct S4 : P2 {
    typealias PType = Int
    var returnSomething: PType {
        return 1
    }
}

// The below won't work. You get:
// error: Protocol 'P2' can only be used as a generic constraint because it has Self or associated type requirements
//func peeToo() -> P2 {
//    return S3()
//}

// However, if you add a "some" keyword, like so:
func peeToo() -> some P2 {
    return S3()
}
// It works.

// This also works:
func peeThree() -> some P2 {
    return S4()
}

// This won't:
//func peeFour(_ x: Int) -> some P2 {
//    return (...5).contains(x) ? S3() : S4()
//}

let functionResponse = peeToo()
print(functionResponse) // Prints "S3()"
let responseVal = functionResponse.returnSomething
print(responseVal)  // Prints "One"

let functionResponse2 = peeThree()
print(functionResponse2) // Prints "S4()"
let responseVal2 = functionResponse2.returnSomething
print(responseVal2)  // Prints "1"

// Note that this is flexible. You can assign multiple types to "genericResponse"
var genericResponse = genericProtocolReturn(1)
print(genericResponse)  // Prints "S0"
// This works:
genericResponse = specificProtocolReturnS1(1)
print(genericResponse)  // Prints "S1"
// That's because genericResponse is not "type safe." It only knows that it is a protocol of P.

// However, when we switch the order, so the first call uses the "some" function:
var genericResponse2 = specificProtocolReturnS1(1)
print(genericResponse2)  // Prints "S1"
// Now, this won't work:
// You get a "fixable" error of "Cannot assign value of type 'P' to type 'some P'"
//genericResponse2 = genericProtocolReturn(1)
// That's because genericResponse2 is now "type safe." Internally, it knows what it is (an S1).

// If you try "fixing" it, as the compiler suggests, then you get this error:
// 'some' types are only implemented for the declared type of properties and subscripts and the return type of functions
//genericResponse2 = genericProtocolReturn(1) as! some P
// That's because you can only use "some" in certain places, and regular variable definitions ain't where they go.

// This is not allowed.
//func foo() -> Equatable {
//    return 5
//}

// Adding "some" enables the return.
func foo() -> some Equatable {
    return 5 // The opaque result type is inferred to be Int.
}

let x = foo()
let y = foo()

print(x == y) // Legal. Both x and y have the return type of foo (which is a hidden Int). We don't care that they are Int; only that they are Equatable, and the same type.

func bar() -> some Equatable {
    return 5 // The opaque result type is again inferred to be Int.
}

let z = bar()
//print(x == z) // This is illegal. Even though both are Int, the context doesn't know that. There's not enough information to satisfy Equatable.

// In this case, the return will be inferred as a String.
func barry() -> some Equatable {
    return "5"
}

let xx = barry()
//print(x == xx) // This is illegal. Since the types are opaque, the compiler errs on the side of caution.

