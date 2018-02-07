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

// This extension uses the Equatable protocol (Comparable extends Equatable). Note the capitalized "Self".
extension GenericBaseProtocol where T: Equatable {
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.myProperty == rhs.myProperty
    }
}

// This extension uses the Comparable protocol.
extension GenericBaseProtocol where T: Comparable {
    static func <(lhs: Self, rhs: Self) -> Bool {
        return lhs.myProperty < rhs.myProperty
    }
    static func >(lhs: Self, rhs: Self) -> Bool {
        return lhs.myProperty > rhs.myProperty
    }
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

// None of this will work, because the static functions aren't available.
//let leftEqualToRight2A = lhs2A == rhs2A
//let leftGreaterThanRight2A = lhs2A > rhs2A
//let leftLessThanRight2A = lhs2A < rhs2A
//
//let rightEqualToLeft2A = rhs2A == lhs2A
//let rightGreaterThanLeft2A = rhs2A > lhs2A
//let rightLessThanLeft2A = rhs2A < lhs2A
//
//let leftEqualToLeft2A = lhs2A == GenClassB3A(["HI":"Howaya"])
//let rightEqualToRight2A = lhs2A == GenClassB3A(["HI":"Howaya"])

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

