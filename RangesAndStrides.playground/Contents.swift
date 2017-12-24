import Foundation

//: Ranges (Open-Ended) can be empty
let rangeIsEmpty = (0..<0).isEmpty
//: ClosedRanges cannot be empty.
let closedRangeIsEmpty = (0...0).isEmpty

//: This will cause a nasty error. Uncomment to see the error.
//let downwardSpiral = 1...0
//: Same here (which makes sense).
//let downwardSpiral = 1..<0

let onwardAndUpward1 = -10..<10 // This is a half-open Range, from -10 to &lt;10, in integer steps (19 steps, 20 values).
let onwardAndUpward2 = -10...10 // This is a closed Range, from -10 to 10, in integer steps (20 steps, 21 values).

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
    print("No Match! \(someNumber)")
}
switch someNumber {
case closedIntRange:
    //: First match.
    print("We has a match (closed)! \(someNumber)")
case openIntRange:
    print("We has a match (open)! \(someNumber)")
default:
    print("No Match! \(someNumber)")
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
    print("No Match! \(someNumber)")
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

let strider = stride(from: 10.0, to: -10.0, by: -3.25)
for aragorn in strider {
    print(aragorn)
}

/*:
 # SEQUENCES
 
 This is about as simple as you'll get.
 
 The data is stored internally in a Sequence (an Array of Int), so most of our work is passing the protocol into our storage Array.
 */
struct SimpleListy: Sequence {
    typealias Element = Int
    typealias Iterator = Array<Element>.Iterator
    
    private var _myInts:[Element] = []
    func makeIterator() -> SimpleListy.Iterator {
        return self._myInts.makeIterator()
    }
    
    mutating func addInteger(_ inInt: Element) {
        self._myInts.append(inInt)
    }
}

var myIntBucket = SimpleListy()

myIntBucket.addInteger(10)
myIntBucket.addInteger(3)
myIntBucket.addInteger(1000)
myIntBucket.addInteger(21)
myIntBucket.addInteger(450)
myIntBucket.addInteger(105)

print("\nPrint the integers:\n")
for integ in myIntBucket {
    print(integ)
}

/*:
 The following code implements a simple sequence, where items are stored in a Dictionary, which has an unspecified sort order, but are iterated alphabetically, by first name.
 
 An iterator is basically a struct or class with a "next()" method. How it gets there is why you may (or may not) want to do your own custom one.
 
 This is a simple demo of why you may want a custom iterator. Say that you want an unorganized list to be iterated in an organized manner?
 */
//: First, we declare a crony type, with the important information.
typealias MyLittleCrony = (name: String, favorsOwed: Int, isRelative: Bool)

//: Next, we declare a Sequence struct, which will include a custom ordered iterator.
struct CronyList: Sequence {
    //: This is a typealias for our internal Dictionary
    typealias CronyListDictionary = [String:Element]
    //: This is required by the protocol
    typealias Element = MyLittleCrony
    //: This is our internal opaque storage.
    private var _cronyList: CronyListDictionary = [:]
    
    //: This is the iterator we'll use. Note that it sorts the response, using the Dictionary keys.
    struct Iterator : IteratorProtocol {
        //: We capture a copy of the list here.
        private let _iteratorList:CronyListDictionary
        //: This is an array of Dictionary keys that we use to sort.
        private let _keysArray:[String]
        //: This is the current item index.
        private var _index: Int
        
        //: Just capture the main object at the time the iterator is made.
        init(_ myLittleCronies: CronyListDictionary) {
            self._iteratorList = myLittleCronies
            self._keysArray = self._iteratorList.keys.sorted()    // This sorts the iteration
            self._index = 0
        }
        
        //: This is required by the protocol.
        mutating func next() -> Element? {
            //: We use the sorted keys array to extract our response.
            if self._index < self._keysArray.count {
                let ret = self._iteratorList[self._keysArray[self._index]]
                
                self._index += 1
                
                return ret
            } else {
                return nil
            }
        }
    }
    
    //: This is required by the protocol.
    func makeIterator() -> CronyList.Iterator {
        return Iterator(self._cronyList)
    }
    
    //: We are legion
    var count: Int {
        get {
            return self._cronyList.count
        }
    }

    //: This is simply a convenient way to cast our random Dictionary into an ordered Array.
    var cronies: [Element] {
        get {
            var ret: [Element] = []
            
            //: We use the iterator to order the Array.
            for crony in self {
                ret.append(crony)
            }
            
            return ret
        }
    }
    
    //: This allows us to make believe we're an Array.
    subscript(_ index: Int) -> Element {
        return self.cronies[index]
    }
    
    //: This is just how we'll load up the list.
    mutating func append(_ crony: Element) {
        self._cronyList[crony.name] = crony
    }
}

var myCronies = CronyList()

myCronies.append((name: "Babs", favorsOwed: 7, isRelative: true))
myCronies.append((name: "Zulinda", favorsOwed: 10, isRelative: true))
myCronies.append((name: "Adriaaaaaan!", favorsOwed: 3, isRelative: false))
myCronies.append((name: "Sue", favorsOwed: 14, isRelative: true))
myCronies.append((name: "Cross-Eyed Mary", favorsOwed: 14, isRelative: false))
myCronies.append((name: "Charmain", favorsOwed: 14, isRelative: false))
myCronies.append((name: "Lucrecia McEvil", favorsOwed: 2, isRelative: false))

print("\nWe have \(myCronies.count) cronies.\n")
print("\nFirst, this is the order in which the entries are stored in the Dictionary:\n")
print(myCronies)

print("\nNext, we iterate the Dictionary, using our custom iterator, which sorts alphabetically:\n")
for (name, favorsOwed, isRelative) in myCronies {
    print("\(name) is owed \(favorsOwed) favors, and is \(isRelative ? "" : "not ")family.")
}

print("\nNext, we show how our accessor has sorted the contents of the Dictionary for us:\n")
print(myCronies.cronies)

print("\nFinally, we show how we can subscript our Sequence directly, and get it in order:\n")

for index in 0..<myCronies.count {
    let (name, favorsOwed, isRelative) = myCronies[index]
    print("myCronies[\(index)]:\(name) is owed \(favorsOwed) favors, and is \(isRelative ? "" : "not ")family.")
}
