import Foundation

struct StackIterator<T>: IteratorProtocol {
    var stack: Stack<T>
    
    mutating func next() -> T? {
        return stack.pop()
    }
}

struct Stack<Element> : Sequence {
    var items = [Element]()
    
    mutating func push(_ newItem: Element) {
        items.append(newItem)
    }
    
    mutating func pushAll<S: Sequence>(_ sequence: S) where S.Iterator.Element == Element {
        for item in sequence {
            self.push(item)
        }
    }
    
    mutating func pop() -> Element? {
        guard !items.isEmpty else {
            return nil
        }
        return items.removeLast()
    }
    
    func makeIterator() -> StackIterator<Element> {
        return StackIterator(stack: self)
    }
    
    func filter(_ infilterFunc: (_ inValue: Element) -> Bool) -> Stack<Element> {
        var ret = Stack<Element>()
        
        for elem in self.items {
            if infilterFunc(elem) {
                ret.push(elem)
            }
        }
        
        return ret
    }
}

func myMap<T,U>(_ items: [T], _ f: (T) -> (U)) -> [U] {
    var result = [U]()
    for item in items {
        result.append(f(item))
    }
    return result
}

var intStack = Stack<Int>()
intStack.push(1)
intStack.push(2)

print(intStack.pop()) // Prints Optional(2)
print(intStack.pop()) // Prints Optional(1)
print(intStack.pop()) // Prints nil

var stringStack = Stack<String>()
stringStack.push("this is a string")
stringStack.push("another string")

print(stringStack.pop()) // Prints Optional("another string")

let strings = ["one", "two", "three"]
let stringLengths = myMap(strings) { $0.characters.count }
print(stringLengths) // Prints [3, 3, 5]

func testFunc<T>(_ inValue: T){print("T says: \"\(inValue)\"")}
func testFunc2<T>(_ inValue: [T]){print("T says: \"\(inValue)\"")}
func testFunc3<T,U>(_ param0: T, _ param1: U){print("T says: \"\(param0)\", U says: \"\(param1)\"")}
func testFunc4<T,U>(_ param0: T, _ param1: T, _ param2: U){print("T1 says: \"\(param0)\", T2 says: \"\(param1)\", U says: \"\(param1)\"")}

testFunc("This is it to a T")
testFunc(5)
testFunc(true)

testFunc2(["This is it to a T","HELO"])
testFunc2([5])
testFunc2([true,true,false,true])
testFunc3(5,"String")
testFunc4(5,6,"String")

func checkIfEqual<T: Equatable>(_ first: T, _ second: T) -> Bool {
    return first == second
}

print(checkIfEqual(1, 1))
print(checkIfEqual("a string", "a string"))
print(checkIfEqual("a string", "a different string"))

func checkIfDescriptionsMatch<T: CustomStringConvertible, U: CustomStringConvertible>(
    _ first: T, _ second: U) -> Bool {
    return first.description == second.description
}

print(checkIfDescriptionsMatch(Int(1), UInt(1)))
print(checkIfDescriptionsMatch(1, 1.0))
print(checkIfDescriptionsMatch(Float(1.0), Double(1.0)))

var myStack = Stack(items: [1,2,3,4,5])
for value in myStack {
    print("for-in loop: got \(value)")
}

myStack.pushAll([1, 2, 3])
for value in myStack {
    print("after pushing: got \(value)")
}

var myOtherStack = Stack<Int>()
myOtherStack.pushAll([3,2,1])
myStack.pushAll(myOtherStack)
for value in myStack {
    print("after pushing items onto stack, got \(value)")
}

let stackRet = myStack.filter({0 != $0 % 2})
print(stackRet)

func findall<T : Equatable, U : Collection>(_ inCollection: U, _ inValue: T) -> [U.Indices] where U.Element == T {
    var ret:[U.Indices] = []
    
    return ret
}

let ret = findall([3,5,3,7,3,9,3],3)
let ret2 = findall(["HI","BYE","HELO","HI","HOWAYA"],"HI")

