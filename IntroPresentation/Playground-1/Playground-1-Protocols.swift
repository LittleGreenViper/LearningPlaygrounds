/*
 PLAYGROUND 1: Protocols Example
 
 ©2019 Rift Valley Software. All Rights Reserved.
 */

// You define a protocol in much the same way that you define a class or a struct, except that you do not provide any "body" to the methods or properties
protocol A {
    var someVar: String { get } // The "get" means that you (as a user of a class or struct conforming to the protocol) can only read from the property. You can't write to it.
    var someOtherVar: String { get set }    // You can read and write to this property. That means that calculated properties need to have both a "get" and a "set" handler.
    func someFunc() -> Bool // You define a method/function as a "bald" declaration.
}

// You can inherit a protocol. B has the same requirements as A, plus any that it adds.
protocol B: A {
    var yetAnotherVar: String { get set }
    func someFunc() -> Bool // There's no problem defining the same function signature as the inherited one.
    func someOtherFunc() -> Bool
}

// Protocols A and B are both "open" protocols. They can be applied to classes, structs, other protocols or enums.

// Protocol C, on the other hand, cannot be applied to structs or enums; only classes. Other protocols can inherit it, but then they need to be class protocols, as well.
protocol C: class, A {
    func someSpecialCFunc() -> Bool
}

// We can write a struct that conforms to Protocol A. Because Protocol A has no default implementation, SA is required to implement everything.
struct SA: A {
    var someVar: String = "SomeVar"
    
    var someOtherVar: String {
        get {
            return "SomeOtherVar"
        }
        
        set {
            print("I am ignoring \(newValue)")
        }
    }
    
    func someFunc() -> Bool {
        return false
    }
}

let structA = SA()

let string1 = structA.someVar
let string2 = structA.someOtherVar

// Now, let's add a default to B:
// Adding this default effectively makes "yetAnotherVar" "optional." It is not required for classes, structs or enums that conform to it.
extension B {
    var yetAnotherVar: String { // In the default extension, we print nothing, and ignore any input.
        get {
            return ""
        }
        
        set {
            
        }
    }
}

// We can write a struct that conforms to Protocol B. We implement the same vars as struct SA, and add a method for "someOtherFunc()". Note that we don't do "yetAnotherVar".
struct SB: B {
    var someVar: String = "SomeVar"
    
    var someOtherVar: String {
        get {
            return "SomeOtherVar"
        }
        
        set {
            print("I am ignoring \(newValue)")
        }
    }
    
    func someFunc() -> Bool {
        return false
    }
    
    func someOtherFunc() -> Bool {  // This is required.
        return true
    }
}

/* This is an error. You can't define a struct from a class protocol.
struct SC: C {
    
}
*/

// You can, however, define a class from it.
class CC: C {
    // You need to implement all the Protocol A stuff:
    var someVar: String = "SomeVar"
    
    var someOtherVar: String {
        get {
            return "SomeOtherVar"
        }
        
        set {
            print("I am ignoring \(newValue)")
        }
    }
    
    func someFunc() -> Bool {
        return false
    }
    
    // Note that we don't need to do any Protocol B stuff, as C was based on A; not B.
    
    // And the new func that Protocol C requires:
    func someSpecialCFunc() -> Bool {
        return false
    }
}

// Now, define Protocol D, from C:
protocol D: C {
    // In this one, we will define the same stuff that B defined
    var yetAnotherVar: String { get set }
    func someOtherFunc() -> Bool
}

// Now, let's try defining a struct from D:
/*
 No dice. An error. D requires a class, because C required a class.
struct SD: D {
}
*/

class CD: D {
    // You need to implement all the Protocol A stuff:
    var someVar: String = "SomeVar"
    
    var someOtherVar: String {
        get {
            return "SomeOtherVar"
        }
        
        set {
            print("I am ignoring \(newValue)")
        }
    }
    
    func someFunc() -> Bool {
        return false
    }
    
    // And the new func that Protocol C requires:
    func someSpecialCFunc() -> Bool {
        return false
    }
    
    // However, it won't work unless we add the calculated property that was default for B. We defined it in D, but didn't get the default that B defined:
    var yetAnotherVar: String {
        get {
            return "I AM GROOT"
        }
        
        set {
            print("I AM GROOT")
        }
    }
    
    // But we're not done yet. We also need to add that method that D required:
    func someOtherFunc() -> Bool {
        return false
    }
}

let classD = CD()
let yetAnotherString = classD.yetAnotherVar

