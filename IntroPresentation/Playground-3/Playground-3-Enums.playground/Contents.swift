/*
 PLAYGROUND 3: Basic Enum Stuff
 
 ©2019 Rift Valley Software. All Rights Reserved.
 */

// In this exercise, I compare the bahaivor of Swift enums to structs
enum EA {
    case caseA
    case caseB
    case caseC
}

// Internally, this is a lot more like this:
struct SEA {
    struct caseA { }
    struct caseB { }
    struct caseC { }
}

// So when you define an instance of EA:
let ea_caseB = EA.caseB

// It is very similar to this:
let sea_caseB = SEA.caseB()

// The similarity only increases if you add associated values:
enum EB {
    case caseA(String)
    case caseB(String)
    case caseC(String)
}

struct SEB {
    struct caseA {
        var value: String = ""
        
        init(_ inValue: String) {
            value = inValue
        }
    }
    
    struct caseB {
        var value: String = ""
        
        init(_ inValue: String) {
            value = inValue
        }
    }
    
    struct caseC {
        var value: String = ""
        
        init(_ inValue: String) {
            value = inValue
        }
    }
}

let eb_caseB = EB.caseB("caseB")
let seb_caseB = SEB.caseB("caseB")

// Where the difference comes in, is when you use them:

// There are two different ways to resolve an enum.

// The first is the structic switch:
switch eb_caseB {
case let .caseB(value):
    print("Case Value (switch): \(value)")
default:
    print("Something Else")
}

// The second is as a case clause in an if.
if case let EB.caseB(value) = eb_caseB {
    print("Case Value (if): \(value)")
} else {
    print("Something Else")
}

// It's a bit more complicated to get the value of the struct we defined.

/*
 You can't do this:
switch type(of: seb_caseB) {
case SEB.caseB.self:
    let value = seb_caseB.value
    print("Struct Value: \(value)")
default:
    print("Something Else")
}
 */

// So you do a direct compare, instead.
if type(of: seb_caseB) == SEB.caseB.self {
    let value = seb_caseB.value
    print("Struct Value: \(value)")
} else {
    print("Something Else")
}

// Now, enums that are based on types are different. They act more like static variables in structes:
enum EC: String {
    case caseA = "caseA"    // In regular use, you wouldn't need to do this.
    case caseB = "caseB"
    case caseC = "caseC"
}

// Probably looks more like this:
struct SEC {
    struct caseA {
        static var value: String = "caseA"
    }
    
    struct caseB {
        static var value: String = "caseB"
    }
    
    struct caseC {
        static var value: String = "caseC"
    }
}

// In the above case, you would not be able to associate a value with an instance of SEC. You can't associate a value with an enum that is type-based, either.

// Next, let's talk extension. You can extend an enum, but you can't add new cases:

/*
 This won't work
 
extension EB {
    case caseD
}
*/

// This will work.
extension EB {
    func caseD(_ inString: String) {
        print("I got this String from you: \"\(inString)\"")
    }
}

// But you can't store the string, because you can't add stored properties to extended entities.
// Instead, this may be more along what you want to do:

extension EB {
    var caseD2: String {
        return "caseD"
    }
    static var s_caseD: String {
        return "caseD"
    }
}

let eb_eb = EB.caseD

// Waitaminute...something's strange.

print("What dis? \(String(reflecting: eb_eb))")

// How about this?

let eb_eb_eb = EB.s_caseD

// That's better.

print("What dis? \(String(reflecting: eb_eb_eb))")

// But we can't use the .caseD2 calculated property.
// Looks like enums won't let us access general type properties unless we instantiate them, and we can't do that without an initializer.
// You can't instantiate EB. Only contained "classes" in EB, and Swift won't let you extend them.
