import Foundation

//: Ranges (Open-Ended) can be empty
let rangeIsEmpty = (0..<0).isEmpty
//: ClosedRanges cannot be empty.
let closedRangeIsEmpty = (0...0).isEmpty

//: This will cause a nasty error. Uncomment to see the error.
//let downwardSpiral = 1...0
//: Same here (which makes sense).
//let downwardSpiral = 1..<0

//: You cannot specify Ranges backwards. This will cause an error.
//let downwardSpiral = 1>..0

//: You can specify Ranges and ClosedRanges as Int:
let openIntRange = 0..<10
let closedIntRange = 0...10
//: You can specify Ranges and ClosedRanges as Float:
let openFloatRange = 0.0..<1.0
let closedFloatRange = 0.0...1.0
//: And even as Strings:
let openStringRange = "aardvark"..<"zebra"
let closedStringRange = "aardvark"..."zebra"
//: This will work, as Int has discrete, iterable steps:
for integ in openIntRange {
    print(integ)
}
//: These will not work, because Doubles and Strings don't have discrete steps:
//for fl in openFloatRange {
//    print(fl)
//}
//for animal in openStringRange {
//    print(animal)
//}
//: Now, let's do a simple Int switch.
//: Pay close attention to what happens here:
let someNumber = 3
switch someNumber {
case openIntRange:
    //: It will get caught here. 3 is within both Ranges, so the first match gets it.
    print("We has a match (open)! \(someNumber)")
case closedIntRange:
    print("We has a match (closed)! \(someNumber)")
default:
    print("No Match! \(someString)")
}
switch someNumber {
case closedIntRange:
    //: First match.
    print("We has a match (closed)! \(someNumber)")
case openIntRange:
    print("We has a match (open)! \(someNumber)")
default:
    print("No Match! \(someString)")
}
let someOtherNumber = 10
switch someOtherNumber {
case openIntRange:
    //: 10 is not actually in this Range.
    print("We has a match (open)! \(someOtherNumber)")
case closedIntRange:
    //: It is in here.
    print("We has a match (closed)! \(someOtherNumber)")
default:
    print("No Match! \(someString)")
}
//: OK. Let's get weird.
var someString = "antelope"
switch someString {
case openStringRange:
    print("We have a match! \(someString)")
default:
    print("No Match! \(someString)")
}

someString = "monster"
switch someString {
case openStringRange:
    print("We have a match! \(someString)")
default:
    print("No Match! \(someString)")
}

someString = "zeb"
switch someString {
case openStringRange:
    print("We have a match! \(someString)")
default:
    print("No Match! \(someString)")
}

someString = "zebr"
switch someString {
case openStringRange:
    print("We have a match! \(someString)")
default:
    print("No Match! \(someString)")
}

someString = "zebra"
switch someString {
case openStringRange:
    print("We have a match! \(someString)")
default:
    print("No Match! \(someString)")
}

someString = "zebpa"
switch someString {
case openStringRange:
    print("We have a match! \(someString)")
default:
    print("No Match! \(someString)")
}

func nameSort(_ inName: String) -> String {
    var ret = "No Match!"
    
    switch inName {
    case "a"..<"ab", "A"..<"AB":
        ret = "Group 0"
    case "ab"..<"ac", "AB"..<"AC":
        ret = "Group 1"
    case "ac"..<"ad", "AC"..<"AD":
        ret = "Group 2"
    case "ad"..<"ae", "AD"..<"AE":
        ret = "Group 3"
    case "ae"..<"af", "AE"..<"AF":
        ret = "Group 4"
    case "af"..<"ag", "AF"..<"AG":
        ret = "Group 5"
    case "ag"..<"ah", "AG"..<"AH":
        ret = "Group 6"
    case "ah"..<"ai", "AH"..<"AI":
        ret = "Group 7"
    case "ai"..<"ak", "AI"..<"AK":
        ret = "Group 8"
    case "ak"..<"al", "AK"..<"AL":
        ret = "Group 9"
    case "al"..<"am", "AL"..<"AM":
        ret = "Group 10"
    default:
        break
    }
    return ret
}

print(nameSort("abby"))
print(nameSort("aiesha"))
print(nameSort("aeisha"))
print(nameSort("akbar"))
print(nameSort("andy"))
//: So this should work, right?
print(nameSort("Abby"))
//: Damn. No dice. How about this?
print(nameSort("ABBY"))
//: Well, won't bother fixing it. The best way is to force case on the string, and do a simple comparison. This is really just a demo.

let strider = stride(from: 10.0, to: -10.0, by: -0.25)
for aragorn in strider {
    print(aragorn)
}
