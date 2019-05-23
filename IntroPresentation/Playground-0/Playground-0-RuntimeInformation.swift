/*
 PLAYGROUND 0: Runtime Information Example
 
 ©2019 Rift Valley Software. All Rights Reserved.
 */

func printInfo(_ inVal: Any) {
    print("\n\tValue of Parameter:")
    print("\t\tSimple Value         : \(inVal)")
    print("\t\tSelf                 : \(inVal.self)")
    print("\t\tDescription          : \(String(describing: inVal))")
    print("\t\tReflection           : \(String(reflecting: inVal))")
    dump(inVal, name: "Dump              ", indent: 9)
    
    print("\n\tType of Parameter:")
    print("\t\tType Of              : \(type(of: inVal))")
    print("\t\tType Of Self         : \(type(of: inVal).self)")
    print("\t\tType Of Description  : \(String(reflecting: type(of: inVal)))")
    print("\t\tType Of Reflection   : \(String(reflecting: type(of: inVal)))")
    dump(type(of: inVal), name: "Dump              ", indent: 9)
}

print("-- Direct Allocations:")
let integerConstant = 10
var integerVariable = 11
let stringConstant = "10"
var stringVariable = "11"

printInfo(integerConstant)
printInfo(integerVariable)
printInfo(stringConstant)
printInfo(stringVariable)

print("\n-- Class Allocations:")
class A {
    let integerConstant = 10
    var integerVariable = 11
    let stringConstant = "10"
    var stringVariable = "11"
}

class B: A {
    override var integerVariable: Int { get { return 1 } set {} }
    override var stringVariable: String { get { return "1" } set {} }
    let anotherIntegerConstant = 12
    var anotherIntegerVariable = 13
    let anotherStringConstant = "12"
    var anotherStringVariable = "13"
}

let a = A()
let b = B()

printInfo(a)
printInfo(b)
printInfo(a.integerVariable)
printInfo(b.integerVariable)

print("\n-- Function Allocations:")
let functionA = { (_ inBool: Bool) -> Bool in return inBool }
let functionB = { () -> A in return A() }

printInfo(functionA)
printInfo(functionB)
printInfo(functionB())
printInfo(functionB().integerVariable)

print("\n-- Introspection:")
func mirrorMask(_ inValue: Any, indent inIndent: Int = 1) {
    for case let (label?, value) in Mirror(reflecting: inValue).children {  // That "label?" thing means that only children that actually have a label will be selected.
        let indentStr = String(repeating: "\t", count: inIndent)
        
        if let moBunny = value as? RabbitHole {
            if nil != moBunny.babyBunny {
                print("\(indentStr)\(label):")
                mirrorMask(moBunny, indent: inIndent + 1)
            } else {
                print("\(indentStr)\(label): \(moBunny.name)")
            }
        } else {
            print("\(indentStr)\(label): \(value)")
        }
    }
}

class RabbitHole {
    let name: String
    var babyBunny: RabbitHole!
    
    func makeBabies(_ inBunnies: [String]! = nil) {
        if 1 == inBunnies.count {
            babyBunny = type(of: self).init(name: inBunnies[0])
        } else if let newBunniesArray = inBunnies?.dropFirst(), !newBunniesArray.isEmpty {
            babyBunny = type(of: self).init(name: inBunnies[0], babies: [String](newBunniesArray))
        }
    }
    
    required init(name inName: String, babies inBunnies: [String]! = nil) {
        name = inName
        if nil != inBunnies {
            makeBabies(inBunnies)
        }
    }
}

let bunny = RabbitHole(name: "MoBunnyMoBunny", babies: ["Fiver", "Hazel", "BigWig", "Dandelion", "KEEHAR"])

mirrorMask(bunny)

class RabbitHoleCustomReflectable: RabbitHole, CustomReflectable {
    var customMirror: Mirror {
        if let shorties = babyBunny, "KEEHAR" != shorties.name {
            return Mirror(self, children: ["tag": name, "shorties": shorties as Any])
        } else {
            return Mirror(self, children: ["tag": name, "OMG! Your kid is a bird!": "Yeah...not sure how that happened."])
        }
    }
    
    required init(name inName: String, babies inBunnies: [String]! = nil) {
        super.init(name: inName, babies: inBunnies)
    }
}

let bunny2 = RabbitHoleCustomReflectable(name: "MoBunnyMoBunny", babies: ["Fiver", "Hazel", "BigWig", "Dandelion", "KEEHAR"])

mirrorMask(bunny2)
