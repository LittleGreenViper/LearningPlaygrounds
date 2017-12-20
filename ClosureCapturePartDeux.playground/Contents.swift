import Foundation

var externalContextVariable: Int = 5

// These are errors
//let closure = {[inout externalContextVariable] () -> Void in
//let closure = {[var externalContextVariable] () -> Void in

let closure = {[externalContextVariable] () -> Void in
// This is an error.
//    externalContextVariable = 6
    print("externalContextVariable is \(externalContextVariable)")
}

closure()

let closure2 = {
    externalContextVariable = 6
    print("externalContextVariable is \(externalContextVariable)")
}

closure2()

class SomeClass {
    var myString: String = ""
    var myInt: Int = 0
    
    func spewOutAClosure(intValue: Int, stringValue: String) -> () -> Void {
        self.myString = stringValue
        self.myInt = intValue
        
        return {print("externalContextVariable is \(externalContextVariable)\nself.myInt is \(self.myInt)\nself.someString is \"\(self.myString)\"")}
    }
}

externalContextVariable = 10
var oneInstanceOfSomeClass: SomeClass! = SomeClass()
var oneInstanceOfAClassBoundClosure: () -> Void = oneInstanceOfSomeClass.spewOutAClosure(intValue: 1000, stringValue: "One Thousand")
oneInstanceOfAClassBoundClosure()
oneInstanceOfSomeClass.myInt = 20
oneInstanceOfSomeClass.myString = "Twenty"
oneInstanceOfAClassBoundClosure()

class SomeClassWeakOverride: SomeClass {
    override func spewOutAClosure(intValue: Int, stringValue: String) -> () -> Void {
        self.myString = stringValue
        self.myInt = intValue
        
        return {[weak self] in
            if nil != self {
                print("externalContextVariable is \(externalContextVariable)\nself.myInt is \(self!.myInt)\nself.someString is \"\(self!.myString)\"")
            } else {
                print("self is nil!")
            }
        }
    }
}

class SomeClassUnownedOverride: SomeClass {
    override func spewOutAClosure(intValue: Int, stringValue: String) -> () -> Void {
        self.myString = stringValue
        self.myInt = intValue
        
        return {[unowned self] in print("externalContextVariable is \(externalContextVariable)\nself.myInt is \(self.myInt)\nself.someString is \"\(self.myString)\"")}
    }
}

var oneWeakInstanceOfSomeClass: SomeClassWeakOverride! = SomeClassWeakOverride()
oneInstanceOfAClassBoundClosure = oneWeakInstanceOfSomeClass.spewOutAClosure(intValue: 900, stringValue: "Nine Hundred")
oneInstanceOfAClassBoundClosure()

oneInstanceOfSomeClass = SomeClass()
oneInstanceOfAClassBoundClosure = oneInstanceOfSomeClass.spewOutAClosure(intValue: 10, stringValue: "Ten")
oneInstanceOfAClassBoundClosure()
oneInstanceOfSomeClass.myInt = 15
oneInstanceOfSomeClass.myString = "Fifteen"
oneInstanceOfSomeClass = nil
oneInstanceOfAClassBoundClosure()

print("\n")

var anotherInstanceOfSomeClass: SomeClassWeakOverride! = SomeClassWeakOverride()
var anotherInstanceOfAClassBoundClosure = anotherInstanceOfSomeClass.spewOutAClosure(intValue: 10, stringValue: "Ten")
anotherInstanceOfAClassBoundClosure()
anotherInstanceOfSomeClass.myInt = 15
anotherInstanceOfSomeClass.myString = "Fifteen"
anotherInstanceOfAClassBoundClosure()
anotherInstanceOfSomeClass = nil
anotherInstanceOfAClassBoundClosure()

print("\n")

var contextCheck: String = "Declaration"

// This is the declaration phase of the closure. It is declared, but not instantiated.
func generateAClosureForMe() -> () -> String {
    return {[contextCheck] in return contextCheck}
}

contextCheck = "Instantiation"

// This is the instantiation phase. We ask the factory function to give us an instance of the closure.
let myClosure = generateAClosureForMe()

contextCheck = "Execution"

// This is the execution phase. We run the closure here.
print("The state was captured during the " + myClosure() + " phase.")

