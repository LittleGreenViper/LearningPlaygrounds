// ##########################################################
// SET UP FOUR CONSTANT ARRAYS OF INT
// ##########################################################
let array1 = [0,1,2,3,4]
let array2 = [5,6,7,8,9]
let array3 = [10,11,12,13,14]
let array4 = [15,16,17,18,19]

// ##########################################################
// WE USE AN IMPLICITLY UNRWAPPED OPTIONAL
// ##########################################################

// couldBeNil is an implicitly unwrapped unwound optional, and it is a var.
var couldbeNil: [Int]!

// The compiler lets you get away with these. Note they are declared "let" (constant, or immutable).
let couldBeNilButIsnt: [Int]!
let couldBeNilButIsntReally: [Int]?

// Because Swift allows a "first one is free" setting of declared constants
couldBeNilButIsnt = array1
couldBeNilButIsntReally = array1

// You get a compiler error if you try this.
//couldBeNilButIsnt = array2
//couldBeNilButIsntReally = array2

// ##########################################################
// START BY SETTING THE IMPLICITLY UNRWAPPED OPTIONAL TO ARRAY ONE
// ##########################################################

// We initialize the implicitly unwrapped optional to an Array of the first five integers.
couldbeNil = array1

// This variable will be used to receive the set Arrays. Note that it is not optional.
var ifVar: [Int]

// All of these will end up with [0,1,2,3,4]
// DIRECT ASSIGNMENT
// Assigning it to a regular (non-optional) Array works fine. Just like it says on the tin.
ifVar = couldbeNil

// THE IF...ELSE CLAUSE
if nil == couldbeNil {
    ifVar = array2
} else {
    ifVar = couldbeNil
}

// THE TERNARY OPERATOR
// Since the implicitly unwrapped optional is non-nil, we use its value
ifVar = nil == couldbeNil ? array2 : couldbeNil

// THE NIL-COALESCING OPERATOR
// If we use the nil-coalescing operator in the assignment, the first choice is used in the assignment, as the implicitly unwrapped optional is non-nil.
ifVar = couldbeNil ?? array2

// ##########################################################
// NOW, CLEAR THE IMPLICITLY UNRWAPPED OPTIONAL
// ##########################################################

couldbeNil = nil

// All of these will end up with [5,6,7,8,9]
// DIRECT ASSIGNMENT
// This would result in a runtime error. You can't assign nil to a regular (non-optional) Array
//ifVar = couldbeNil

// THE IF...ELSE CLAUSE
if nil == couldbeNil {
    ifVar = array2
} else {
    ifVar = couldbeNil
}

// THE TERNARY OPERATOR
// Since the implicitly unwrapped optional is nil, we use array2
ifVar = nil == couldbeNil ? array2 : couldbeNil

// THE NIL-COALESCING OPERATOR
// If we use the nil-coalescing operator in the assignment, the second choice is used in the assignment, as the implicitly unwrapped optional is nil.
ifVar = couldbeNil ?? array2

// ##########################################################
// SET THE IMPLICITLY UNRWAPPED OPTIONAL TO ARRAY THREE
// ##########################################################

couldbeNil = array3

// All of these will end up with [10,11,12,13,14]
// DIRECT ASSIGNMENT
// Assigning it to a regular (non-optional) Array works fine. Just like it says on the tin.
ifVar = couldbeNil

// THE IF...ELSE CLAUSE
if nil == couldbeNil {
    ifVar = array2
} else {
    ifVar = couldbeNil
}

// THE TERNARY OPERATOR
// Since the implicitly unwrapped optional is non-nil, we use its value
ifVar = nil == couldbeNil ? array2 : couldbeNil

// THE NIL-COALESCING OPERATOR
// If we use the nil-coalescing operator in the assignment, the first choice is used in the assignment, as the implicitly unwrapped optional is non-nil.
ifVar = couldbeNil ?? array2

// ##########################################################
// CASCADED NIL-COALESCING OPERATORS
// ##########################################################
// Now that we see how the nil-coalescing operator works in general, lets' go a little deeper down the rabbit-hole.

// We create a couple more implicitly unwrapped optionals.
var couldbeNil1: [Int]? = array1    // Note that this is a "full" (not implicitly-unwrapped) optional.
var couldbeNil2: [Int]! = array2
var couldbeNil3: [Int]! = array3

// This will be set to [0,1,2,3,4]. Note that we don't need to force-unwrap the full optional.
ifVar = couldbeNil1 ?? couldbeNil2 ?? couldbeNil3 ?? []

// This is the equivalent of this:
if nil != couldbeNil1 {
    ifVar = couldbeNil1!    // Note that we need to force-unwrap the full optional, here.
} else if nil != couldbeNil2 {
    ifVar = couldbeNil2
} else if nil != couldbeNil3 {
    ifVar = couldbeNil3
} else {
    ifVar = []
}

// Or using this ternary operator:
// Again, note that we need to force-unwrap the full optional here.
ifVar = nil != couldbeNil1 ? couldbeNil1! : nil != couldbeNil2 ? couldbeNil2 : nil != couldbeNil3 ? couldbeNil3 : []

// You could try improving the redability with parentheses.
ifVar = (nil != couldbeNil1) ? couldbeNil1! : ((nil != couldbeNil2) ? couldbeNil2 : ((nil != couldbeNil3) ? couldbeNil3 : []))

// Now, we set the first part of the test to nil.
couldbeNil1 = nil

// This will be set to [5,6,7,8,9]
ifVar = couldbeNil1 ?? couldbeNil2 ?? couldbeNil3 ?? []

// The next part...
couldbeNil2 = nil

// This will be set to [10,11,12,13,14]
ifVar = couldbeNil1 ?? couldbeNil2 ?? couldbeNil3 ?? []

// And finally, the last part:
couldbeNil3 = nil

// This will be set to []
ifVar = couldbeNil1 ?? couldbeNil2 ?? couldbeNil3 ?? []

// Set the middle test to a value:
couldbeNil2 = array2

// This will be set to [5,6,7,8,9]
ifVar = couldbeNil1 ?? couldbeNil2 ?? couldbeNil3 ?? []

// ##########################################################
// VARIOUS TYPES OF VALUES AND REFERENCES
// ##########################################################
var fullOptional: [Int]? = array1
var implictOptional: [Int]! = array2
var notOptional: [Int] = array3

// This method will return either nil, or an Array of Int, as a full optional.
// If the optional parameter is set to true (default is false), nil is returned. Otherwise, we get a value.
func thisFuncReturnsAnOptionalResult(gimmeANil: Bool = false) -> [Int]? {
    return gimmeANil ? nil : [15,16,17,18,19]
}

// This will be set to [15,16,17,18,19], as the first test "passes."
let test1: [Int] = thisFuncReturnsAnOptionalResult() ?? implictOptional

// This will be set to [5,6,7,8,9] (the implicitly-unwrapped optional will evaluate as if it were a normal, non-optional value).
let test2: [Int] = thisFuncReturnsAnOptionalResult(gimmeANil: true) ?? implictOptional

// This won't work (compile-time error), because the second argument is a full optional that is defined to be possibly nil.
//let test4: [Int] = thisFuncReturnsAnOptionalResult(gimmeANil: true) ?? fullOptional

// The "correctest" way to deal with this issue is like so:
// That gives us a "fallback," in case the second argument is nil. It will set test4 to [0,1,2,3,4]
let test4: [Int] = thisFuncReturnsAnOptionalResult(gimmeANil: true) ?? fullOptional ?? notOptional

// If you do this:
implictOptional = nil

// This will have a runtime error, when the second, nil value is assigned.
// The fact it is implicitly-unwrapped means that it passes compile-time checks.
//let test3: [Int] = thisFuncReturnsAnOptionalResult(gimmeANil: true) ?? implictOptional

// This will work, as the compiler knows that the second argument is an optional, even though it's pretending not to be one.
let test3: [Int] = thisFuncReturnsAnOptionalResult(gimmeANil: true) ?? implictOptional ?? notOptional

// ##########################################################
// YOU WANNA SEE SOMETHING REALLY SCARY?
// ##########################################################
// It's possible to abuse cascading nil-coalescing operators, like so:

var fullOptional2: [Int]? = array1
var fullOptional3: [Int]? = array2

func returnThisValue(_ inValue: Int, fromThisArray inArray: [Int]) -> Int? {
    for value in inArray where inValue == value {
        return value
    }
    return nil
}

let tester1 = 25
let tester2 = 1000
let tester4 = 13

// SPOILER: This will set someInt to 13
let someInt: Int = returnThisValue(tester1, fromThisArray: []) ?? returnThisValue(tester1, fromThisArray: fullOptional2 ?? []) ?? returnThisValue(tester1, fromThisArray: fullOptional3 ?? [])  ?? returnThisValue(tester2, fromThisArray: fullOptional2 ?? []) ?? returnThisValue(tester2, fromThisArray: fullOptional3 ?? []) ?? returnThisValue(tester4, fromThisArray: array3) ?? nil ?? 0
