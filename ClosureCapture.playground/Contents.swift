import Foundation

var count = 0

print("\nSimple Closure (No capture list):\n")
let closure = {print("count is \(count)")}
for counter in 0..<5 {
    count = counter
    closure()
}

var optionalCount: Int! = 0

print("\nSimple Closure (No capture list, optional global):\n")
let optionalClosure = {print("optionalCount is \(optionalCount)")}
for counter in 0..<5 {
    optionalCount = counter
    optionalClosure()
}

print("\nSimple Closure (No capture list, optional global -clear optional):\n")
for counter in 0..<5 {
    optionalCount = counter
    optionalCount = nil
    optionalClosure()
}

optionalCount = 5

print("\nSimple Closure (With capture list, optional global -clear optional):\n")
let optionalClosure2 = {[optionalCount] in print("optionalCount is \(optionalCount)")}
for counter in 0..<5 {
    optionalCount = counter
    optionalCount = nil
    optionalClosure2()
}

class ReferencedClass { var integerValue: Int = 5 }

var referencedClass: ReferencedClass! = ReferencedClass()

print("\nSimple Closure (With capture list, optional global reference value):\n")
let optionalClosure3 = {[referencedClass] in print("referencedClass.integerValue is \(referencedClass!.integerValue)")}
for counter in 0..<5 {
    referencedClass!.integerValue = counter
    optionalClosure3()
}

print("\nSimple Closure (With capture list, optional global reference value -clear optional):\n")
let optionalClosure4 = {[referencedClass] in print("referencedClass.integerValue is \(referencedClass!.integerValue)")}
referencedClass = nil
for counter in 0..<5 {
    // This is an error. You can't access a nil optional.
    //    referencedClass!.integerValue = counter
    optionalClosure4()
}

var referenceCounter: Int = 0

class ReferencedClass2 {
    var integerValue: Int = 6
    init() { referenceCounter += 1 }
    deinit { referenceCounter -= 1 }
}

var referencedClass2: ReferencedClass2! = ReferencedClass2()

print("\nSimple Closure (With capture list, optional global reference value -clear optional, but incremented internally):\n")
let optionalClosure5 = {[referencedClass2] in print("referencedClass.integerValue is \(referencedClass2!.integerValue)"); referencedClass2!.integerValue += 1}
referencedClass2 = nil
for counter in 0..<5 {
    optionalClosure5()
}

print("referenceCounter is \(referenceCounter)")

referenceCounter = 0

var referencedClass3: ReferencedClass2! = ReferencedClass2()

print("\nSimple Closure (With capture list, optional global reference value -clear optional, but incremented internally. Optional closure):\n")
var optionalClosure6: (() -> Void)! = {[referencedClass3] in print("referencedClass.integerValue is \(referencedClass3!.integerValue)"); referencedClass3!.integerValue += 1}
referencedClass3 = nil
for counter in 0..<5 {
    optionalClosure6()
}
optionalClosure6 = nil

print("referenceCounter is \(referenceCounter)")

referenceCounter = 0

var referencedClass4: ReferencedClass2! = ReferencedClass2()

print("\nSimple Closure (With capture list, optional global reference value -clear optional, but incremented internally. Optional closure with weak reference):\n")
var optionalClosure7: (() -> Void)! = {[weak referencedClass4] in print("referencedClass.integerValue is \(referencedClass4!.integerValue)"); referencedClass4!.integerValue += 1}
// This will be an error. We need to wait until we're done.
//referencedClass4 = nil
for counter in 0..<5 {
    optionalClosure7()
}
referencedClass4 = nil

print("referenceCounter is \(referenceCounter)")

print("\nClosure with Capture List Closure (count is captured at 4 at closure instantiation):\n")
let closure0 = {[count] in print("count is \(count)")}
for counter in 0..<5 {
    count = counter
    closure0()
}

count = 955
var illRatOutCount: Int = 0

print("\nClosure with Capture List Closure (count is set to 955 at capture time, and illRatOutCount is not captured):\n")
let closure955 = {[count] in print("count is \(count) and illRatOutCount is \(illRatOutCount)")}
for counter in 0..<5 {
    count = counter
    illRatOutCount = count
    closure955()
}

count = 1024

print("\nClosure with Capture List Closure (count is set to 1024, and illRatOutCount is set to 4 -the last value of count- at capture time):\n")
let closure1024 = {[count, illRatOutCount] in print("count is \(count) and illRatOutCount is \(illRatOutCount)")}
for counter in 0..<5 {
    count = counter
    illRatOutCount = count
    closure1024()
}

count = 3

print("\nClosure with Capture List Closure (capture is done inside the list, so you get the current values -however, illRatOutCount is set after the capture, so you see these values after the fact):\n")
for counter in 0..<5 {
    count = counter
    let closure3 = {[count, illRatOutCount] in print("count is \(count) and illRatOutCount is \(illRatOutCount)")}
    illRatOutCount = count
    closure3()
}

count = 0

// The following is an error. You can only capture a variable if it is in context.
//print("\nClosure with Capture List Closure (count is set to index at capture time):\n")
//let closureCounter = {[counter] in print("count is \(count)")}
//for counter in 0..<5 {
//    count = counter
//    closureCounter()
//}

