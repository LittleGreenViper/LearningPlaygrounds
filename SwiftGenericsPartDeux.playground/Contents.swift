import Foundation

// This is a completely generic protocol. You can use any type for "T".
protocol GenericBaseProtocol {
    associatedtype T
    
    var myProperty: T {get set}
    init(_ myProperty: T )
}

// You can declare both Comparable and non-Comparable types with this protocol.
// This is Comparable
class GenClassB: GenericBaseProtocol {
    typealias T = Int
    var myProperty: T = 0
    // When you conform to a protocol with an init(), you need to add the "required" keyword to your implementation.
    required init(_ myProperty: T ) {
        self.myProperty = myProperty
    }
}

// This is non-Comparable
class GenClassA: GenericBaseProtocol {
    typealias T = [String:String]
    var myProperty: T = [:]
    required init(_ myProperty: T ) {
        self.myProperty = myProperty
    }
}

// This will not work. You cannot redefine associated types in a protocol extension.
//extension GenericBaseProtocol {
//    associatedtype T: Comparable
//
//    var myProperty: T {get set}
//}

// This will not work. You cannot add an associatedType via an extension.
//extension GenericBaseProtocol {
//    associatedtype S
//}

// Now, here we will add conditional extensions to the original, generic protocol.
// These allow classes based on this protocol to act as Equatable and Comparable, if the data type is Comparable,
// or just Equatable, if the data type is Equatable, but not Comparable.

// This extension is for when the class is not Equatable (or Comparable).
// The == always returns false, and we have an isEquatable Bool that tells us the class is not Equatable.
// Thanks to Alain T. for his guidance: https://stackoverflow.com/a/48711730/879365
// This is the default extension, implementing non-functional stubs.
extension GenericBaseProtocol {
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return false
    }
    
    static func <(lhs: Self, rhs: Self) -> Bool {
        return false
    }
    
    static func >(lhs: Self, rhs: Self) -> Bool {
        return false
    }
    
    var isEquatable:Bool { return false }
    var isComparable:Bool { return false }
}

// This extension uses the Equatable protocol (Comparable extends Equatable). Note the capitalized "Self".
// If the class is Equatable, then we return a true for isEquatable.
// This extension is used when the associated type conforms to the Equatable protocol.
extension GenericBaseProtocol where T: Equatable {
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.myProperty == rhs.myProperty
    }
    
    var isEquatable:Bool { return true }
}

// This extension is used when the associated type conforms to the Comparable protocol.
extension GenericBaseProtocol where T: Comparable {
    static func <(lhs: Self, rhs: Self) -> Bool {
        return lhs.myProperty < rhs.myProperty
    }
    static func >(lhs: Self, rhs: Self) -> Bool {
        return lhs.myProperty > rhs.myProperty
    }
    
    var isComparable:Bool { return true }
}

// Here, we define a Comparable type
class GenClassB3: GenericBaseProtocol {
    typealias T = Int
    var myProperty: T = 0
    
    required init(_ myProperty: T ) {
        self.myProperty = myProperty
    }
}

// Test the Comparable behavior
let lhs2 = GenClassB3(3)
let rhs2 = GenClassB3(4)

print ( "lhs2 is" + (lhs2.isEquatable ? "" : " not") + " Equatable." )
print ( "lhs2 is" + (lhs2.isComparable ? "" : " not") + " Comparable." )

print ( "rhs2 is" + (rhs2.isEquatable ? "" : " not") + " Equatable." )
print ( "rhs2 is" + (rhs2.isComparable ? "" : " not") + " Comparable." )

let leftEqualToRight2 = lhs2 == rhs2
let leftGreaterThanRight2 = lhs2 > rhs2
let leftLessThanRight2 = lhs2 < rhs2

let rightEqualToLeft2 = rhs2 == lhs2
let rightGreaterThanLeft2 = rhs2 > lhs2
let rightLessThanLeft2 = rhs2 < lhs2

let leftEqualToLeft2 = lhs2 == GenClassB3(3)
let rightEqualToRight2 = lhs2 == GenClassB3(4)

// Here, we define a type that is not Comparable.
class GenClassB3A: GenericBaseProtocol {
    typealias T = [String]
    var myProperty: T = []
    
    required init(_ myProperty: T ) {
        self.myProperty = myProperty
    }
}

let lhs2A = GenClassB3A(["HI"])
let rhs2A = GenClassB3A(["Howaya"])

print ( "lhs2A is" + (lhs2A.isEquatable ? "" : " not") + " Equatable." )
print ( "lhs2A is" + (lhs2A.isComparable ? "" : " not") + " Comparable." )

print ( "rhs2A is" + (rhs2A.isEquatable ? "" : " not") + " Equatable." )
print ( "rhs2A is" + (rhs2A.isComparable ? "" : " not") + " Comparable." )

// Because of the game we played up there, these will compile, but the comparisons will always fail.
let leftEqualToRight2A = lhs2A == rhs2A
let leftGreaterThanRight2A = lhs2A > rhs2A
let leftLessThanRight2A = lhs2A < rhs2A

let rightEqualToLeft2A = rhs2A == lhs2A
let rightGreaterThanLeft2A = rhs2A > lhs2A
let rightLessThanLeft2A = rhs2A < lhs2A

let leftEqualToLeft2A = lhs2A == GenClassB3A(["HI"])
let rightEqualToRight2A = lhs2A == GenClassB3A(["Howaya"])

// Here, we define an Equatable (but not Comparable) type
class GenClassB4: GenericBaseProtocol {
    typealias T = Bool
    var myProperty: T = false
    
    required init(_ myProperty: T ) {
        self.myProperty = myProperty
    }
}

let lhs2B = GenClassB4(true)
let rhs2B = GenClassB4(true)

print ( "lhs2B is" + (lhs2B.isEquatable ? "" : " not") + " Equatable." )
print ( "lhs2B is" + (lhs2B.isComparable ? "" : " not") + " Comparable." )

print ( "rhs2B is" + (rhs2B.isEquatable ? "" : " not") + " Equatable." )
print ( "rhs2B is" + (rhs2B.isComparable ? "" : " not") + " Comparable." )

let leftEqualToRight2B = lhs2B == rhs2B
let leftGreaterThanRight2B = lhs2B > rhs2B
let leftLessThanRight2B = lhs2B < rhs2B

let rightEqualToLeft2B = rhs2B == lhs2B
let rightGreaterThanLeft2B = rhs2B > lhs2B
let rightLessThanLeft2B = rhs2B < lhs2B

let leftEqualToLeft2B = lhs2B == GenClassB4(true)
let rightEqualToRight2B = lhs2B == GenClassB4(false)

// This defines a new protocol, based on Comparable.
protocol GenericBaseProtocolBothCompType: Comparable {
    associatedtype T: Comparable
    
    var myProperty: T {get set}
    init(_ myProperty: T )
}

// You cannot define a protocol extension initializer.
//extension GenericBaseProtocolBothCompType {
//    init(_ myProperty: T ) {
//            self.myProperty = myProperty
//    }
//}

// This extension satisfies the Equatable protocol.
extension GenericBaseProtocolBothCompType {
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.myProperty == rhs.myProperty
    }
}

// This extension satisfies the Comparable protocol.
extension GenericBaseProtocolBothCompType {
    static func <(lhs: Self, rhs: Self) -> Bool {
        return lhs.myProperty < rhs.myProperty
    }
}

// This is an error. It will not work, because Dictionary is not Comparable.
//class GenClassA2: GenericBaseProtocolBothCompType {
//    typealias T = [String:String]
//    var myProperty: T = [:]
//}

class GenClassB2: GenericBaseProtocolBothCompType {
    typealias T = Int
    var myProperty: T = 0
    
    required init(_ myProperty: T ) {
        self.myProperty = myProperty
    }
}

let lhs = GenClassB2(3)
let rhs = GenClassB2(4)

let leftEqualToRight = lhs == rhs
let leftGreaterThanRight = lhs > rhs
let leftLessThanRight = lhs < rhs

let rightEqualToLeft = rhs == lhs
let rightGreaterThanLeft = rhs > lhs
let rightLessThanLeft = rhs < lhs

let leftEqualToLeft = lhs == GenClassB2(3)
let rightEqualToRight = lhs == GenClassB2(4)

// This defines a new protocol, based on Comparable, and leaves the associated type as a free agent.
protocol GenericBaseProtocolBothCompType2: Comparable {
    associatedtype T
    
    var myProperty: T {get set}
    init(_ myProperty: T )
}

// However, these won't work, as the data type is not Comparable.
//// This extension satisfies the Equatable protocol.
//extension GenericBaseProtocolBothCompType2 {
//    static func ==(lhs: Self, rhs: Self) -> Bool {
//        return lhs.myProperty == rhs.myProperty
//    }
//}
//
//// This extension satisfies the Comparable protocol.
//extension GenericBaseProtocolBothCompType2 {
//    static func <(lhs: Self, rhs: Self) -> Bool {
//        return lhs.myProperty < rhs.myProperty
//    }
//}

// These will work, because you are specifying that the type needs to be Equatable/Comparable.
// This extension satisfies the Equatable protocol.
extension GenericBaseProtocolBothCompType2 where T: Equatable {
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.myProperty == rhs.myProperty
    }
}

// This extension satisfies the Comparable protocol.
extension GenericBaseProtocolBothCompType2 where T: Comparable {
    static func <(lhs: Self, rhs: Self) -> Bool {
        return lhs.myProperty < rhs.myProperty
    }
}

class GenericClassFromType2: GenericBaseProtocolBothCompType2 {
    typealias T = Int
    var myProperty: T = 0
    
    required init(_ myProperty: T ) {
        self.myProperty = myProperty
    }
}

let lhs4 = GenericClassFromType2(3)
let rhs4 = GenericClassFromType2(4)

let leftEqualToRigh4t = lhs4 == rhs4
let leftGreaterThanRight4 = lhs4 > rhs4
let leftLessThanRight4 = lhs4 < rhs4

let rightEqualToLeft4 = rhs4 == lhs4
let rightGreaterThanLeft4 = rhs4 > lhs4
let rightLessThanLeft4 = rhs4 < lhs4

let leftEqualToLeft4 = lhs4 == GenericClassFromType2(3)
let rightEqualToRight4 = lhs4 == GenericClassFromType2(4)

// This protocol has two associated types.
protocol GenericBaseProtocolWithTwoTypes {
    associatedtype T
    associatedtype S
    
    var myProperty1: T {get set}
    var myProperty2: S {get set}
    
    init(myProperty1: T, myProperty2: S)
}

// This will not work. You need to define and implement BOTH types.
//class GenericTwoTypes: GenericBaseProtocolWithTwoTypes {
//    typealias T = Int
//
//    var myProperty1: T
//
//    required init(myProperty1: T) {
//        self.myProperty1 = myProperty1
//    }
//}

struct GenericTwoTypesStruct: GenericBaseProtocolWithTwoTypes {
    typealias T = Int
    typealias S = [String:String]
    
    var myProperty1: T
    var myProperty2: S
    
    // You do not need the "required" keyword when implementing a struct from the protocol.
    init(myProperty1: T, myProperty2: S) {
        self.myProperty1 = myProperty1
        self.myProperty2 = myProperty2
    }
}

class GenericTwoTypesClass: GenericBaseProtocolWithTwoTypes {
    typealias T = Int
    typealias S = [String:String]
    
    var myProperty1: T
    var myProperty2: S
    
    required init(myProperty1: T, myProperty2: S) {
        self.myProperty1 = myProperty1
        self.myProperty2 = myProperty2
    }
}

