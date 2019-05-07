import Foundation

let aStringArray = ["Some String","AnotherString"]  // Direct type assignment
let myFirstArray = aStringArray     // Implicit type assignment, where "aStringArray" is already a String Array.
let myDirectArray = [String]()      // Explicit empty Array definition, using brackets and an initializer. This is a common way to instantiate an Array.
let mySecondArray:[String] = []     // Explicit basic type definition, using brackets. This is the most common form.
let myThirdArray:Array<String> = [] // This is the first (explicitly defined) generic form.
let myFourthArray = Array<String>() // This is the second (type-assigned) generic form.

typealias SwiftGenericType<T> = T

struct SwiftGenericStruct<T> {
    let value: T
    init(value: T) { self.value = value }
}

class SwiftGenericClass<T> {
    let value: T
    init(value: T) { self.value = value }
}

func swiftGenericEqualityTester<T: Comparable>(_ leftSide: T, _ rightSide: T) -> Bool { return leftSide == rightSide }

let is1EqualTo1 = swiftGenericEqualityTester(1, 1)  // Casts both as Int
let is2EqualTo2Point5 = swiftGenericEqualityTester(2, 2.5)  // Casts both as Double

// You can't do this. It's an error.
// let is1EqualTo1 = swiftGenericEqualityTester<Int>(1, 1)

// You can't do this. It's an error.
// let leftSide: Int = 2
// let rightSide: Double = 2.5
// let is2EqualTo2Point5 = swiftGenericEqualityTester(rightSide, leftSide)

// You can do this, however.
func swiftGenericEqualityTester2<T: Comparable, S: Comparable>(_ leftSide1: T, _ rightSide: S) -> Bool { return true }
let leftSide1: Int = 2
let rightSide1: Double = 2.6
let is2EqualTo2Point6 = swiftGenericEqualityTester2(leftSide1, rightSide1)

// You can't do this. It's an error.
// func swiftGenericEqualityTester3<T: Comparable, S: Comparable>(_ leftSide: T, _ rightSide: S) -> Bool { return rightSide == leftSide }

// You can't do this either. Swift doesn't want the types to be the same.
// func swiftGenericEqualityTester3<T: Comparable, S: Comparable> (_ leftSide: T, _ rightSide: S) -> Bool  where S == T { return rightSide == leftSide }

// You can't do this. It's an error.
// typealias SwiftGenericTuple = Tuple<T>( key: T, value: T )

// You can't do this. It's an error.
// protocol SwiftGenericProtocol<T> {}

