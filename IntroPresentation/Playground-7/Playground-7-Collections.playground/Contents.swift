/*
 PLAYGROUND 7: Collections and Ranges
 
 ©2019 Rift Valley Software. All Rights Reserved.
 */

// Standard Swift Collections
// The Swift Standard Library comes with three basic collection types: Array, Dictionary, Set. They are generic, and will aggregate any type of Swift objects.
// Swift standard collections are value semantic. They aggregate copies of data; not references. You should keep this in mind when using them.
// Array
// Arrays are linear, ordered collections that aggregate data in the order they are stored. Access to Array data is via integer position indexes or iteration.

// Let's set up an Array of Strings:
var stringArray = ["Eeny", "Meeny", "Miney", "Moe"]

// All collections have a "count" calculated property that indicates how many items it stores:
print(stringArray.count)    // Prints "4"

// Arrays can have their contents directly accessed via a 0-based index/subscript:
print(stringArray[2])   // Prints "Miney"

// Or they can iterate via a loop:
for element in stringArray {    // Prints "Eeny\nMeeny\nMiney\nMoe\n"
    print(element)
}

// Or they can be iterated using higher-order functions:
stringArray.forEach { print($0) }                   // Prints "Eeny\nMeeny\nMiney\nMoe\n"
print(stringArray.map { (element) -> Character in   // Prints ["E", "M", "M", "M"]
    return element[element.startIndex]
})
print(stringArray.reduce("") { current, new in      // Prints "Eeny, Meeny, Miney, Moe"
    return current + (!current.isEmpty ? ", " : "") + new
})

// Here's a simple proof that they are value semantics:
let newArray = stringArray
print(newArray) // Prints ["Eeny", "Meeny", "Miney", "Moe"]
stringArray[2] = "Money"
print(stringArray) // Prints ["Eeny", "Meeny", "Money", "Moe"]
print(newArray) // Prints ["Eeny", "Meeny", "Miney", "Moe"]

// All collections also have an "isEmpty" flag, that is true, if there are zero items:
print(stringArray.isEmpty)  // Prints "false"

stringArray = []

print(stringArray.isEmpty)  // Prints "true"

// Dictionary
// Dictionaries are a standard hash table, random-access aggregator type.
// You set up a Dictionary by defining it as Dictionary<AnyHashable, Any>, or [AnyHashable: Any]
// For example, if you were creating a Dictionary of integers, with String keys, you would define it as Dictionary<String, Int> or [String: Int]
var integerDictionary = ["Two": 2, "One": 1, "Four": 4, "Zero": 0, "Three": 3]
// Which is exactly the same as:
//var integerDictionary: [String: Int] = ["Two": 2, "One": 1, "Four": 4, "Zero": 0, "Three": 3]
// or
//var integerDictionary: Dictionary<String, Int> = ["Two": 2, "One": 1, "Four": 4, "Zero": 0, "Three": 3]

// With a Dictionary, you access items directly, using a hash (O1 complexity):
print(integerDictionary["Three"] ?? "ERROR")   // Prints "3"
// Note the nil-coalescing operator (??). That's there, because the lookup could fail. The return type is Int?. If that happens, you get nil. Let's try a failure:
print(integerDictionary["Five"] ?? "ERROR")   // Prints "ERROR"

// The order of the stored items is not guaranteed. A straight printing could yield inconsistent results:
print(integerDictionary)    // Almost certainly will not print ["Zero": 0, "One": 1, "Two": 2, "Three": 3, "Four": 4] or ["Two": 2, "One": 1, "Four": 4, "Zero": 0, "Three": 3]

// You can iterate Dictionaries via higher-order functions.
// The order of the following will be undefined. They will be similar to above.
integerDictionary.forEach { print("\($0.key) = \($0.value)") }   // Since we are iterating a Dictionary, each element is actually a tuple (key: String, value: Int)
print(integerDictionary.map { (element) -> Int in   // Transform to an Array of Int, using map
    return element.value
})
print(integerDictionary.reduce("") { current, new in
    return current + (!current.isEmpty ? ", " : "") + String(new.value)
})

// Or with a standard for in iterator (again, order is not defined):
for element in integerDictionary {
    print("\(element.key) = \(element.value)")
}

// Dictionaries have an Array of Dictionary.Keys type that is called "keys":
var keyArray = integerDictionary.keys
print("Raw: \(keyArray)")

// You can use this to impose some kind of order on the Dictionary.
// You can't do sorts on Dictionaries or Sets; only Arrays.
// This blunt-instrument stupid sort will only work for five sequential values. Don't try this at home.
var sortedKeys = (keyArray.map { return String($0) } as [String]).sorted { return ("Four" == $1) || ("Zero" == $0) || ("One" == $0 && "Zero" != $1) || ("Two" == $0 && "Three" == $1) }

print("Sorted: \(sortedKeys)")

sortedKeys.forEach {
    print(integerDictionary[$0] ?? "ERROR")
}

// Set
// Sets look like unordered Arrays, with a twist: You can't repeat values in a Set, and the values have to be hashable.
// A Set is a keyless hash table; where the value itself is hashed.
// Use a set to force uniqueness, or quickly match for membership.
// A hash lookup is a O(1) operation, while an Array search could be as high as O(n), if you are simply looking for membership (contains() function).
// Since a Set assignment looks exactly like an Array assignment, you need to explicitly indicate that this is a Set:
// Note that we didn't need to indicate Set<String>. That was inferred by Swift (that's what I mean by Swift "hiding" generics).
var integerNameSet: Set = ["Two", "One", "Four", "Zero", "Three", "Zero"]   // Note that we added "Zero" twice, but it will only be in the Set once (look at the print).

print(integerNameSet)   // Since the Set is unordered, this will almost certainly not print ["Two", "One", "Four", "Zero", "Three"]

// You use "contains()" to find membership:
print(integerNameSet.contains("Three")) // Prints "true"
print(integerNameSet.contains("Five"))  // Prints "false"

// There's a whole bunch of other useful operations for sets, like unions, intersections, differences, etc. We won't cover that, here.
// However, we will cover one very useful aspect of Sets. Remember that we added "Zero" twice, above, but it only came up once?
// We'll use that to enforce uniqueness.
// Let's create a String Array with a few repeats:
let repeatingArray = ["Two", "Two", "Three", "One", "Four", "Zero", "Three", "Zero"]
// We didn't need to specify that it was an [String], as the compiler implies this.
// Now, we assign it to a Set:
let filteredSet = Set(repeatingArray)

// In the printout, see the differences between the two:
print(repeatingArray)
print(filteredSet)

// Now, we can use the sorting ability from before, to create a unique, sorted Array from that random, repeated input:
let filteredAndSortedArray = [String](filteredSet).sorted { return ("Four" == $1) || ("Zero" == $0) || ("One" == $0 && "Zero" != $1) || ("Two" == $0 && "Three" == $1) }
print(filteredAndSortedArray)

// PART 1: SPECIFYING RANGES AND INTERVALS
// 1.1: RANGES

// First, we look at the Range type. Ranges are designed for incrementing. They have to be scalar (incrementable, usually, integers).
// Ranges always represent internally as min..<max When you do an inclusive range, it will represent internally as min..<max+1
let range1:CountableRange<Int>          = 0..<10    /* This contains 0,1,2,3,4,5,6,7,8,9 */
let range2:CountableRange               = 0..<10    /* This also contains 0,1,2,3,4,5,6,7,8,9 */
let range3                              = 0..<10    /* This also contains 0,1,2,3,4,5,6,7,8,9 */
let range4:CountableClosedRange<Int>    = 0...9     /* This also contains 0,1,2,3,4,5,6,7,8,9 */
let range5:CountableClosedRange         = 0...9     /* This also contains 0,1,2,3,4,5,6,7,8,9 */
let range6                              = 0...9     /* This also contains 0,1,2,3,4,5,6,7,8,9 */
// let range7:Range<Float>              = 0..<10    /* This is an error. Floats can't be incremented. */
// let range8:Range                     = 0.0...9.0 /* This is also an error. */
// let range9:Range<String>             = "0"..."9" /* This is an error. Even though these are strings in sequence, they can't be incremented. */

// 1.2: INTERVALS

// Next, let's look at the Interval type. Intervals represent spreads of values, and can be non-integer types.

// 1.2.1: TYPES OF INTERVALS

// 1.2.1.1: CLOSED

// Closed intervals
let closed1:ClosedRange<Int>                        = 1...5         /* This represents 1,2,3,4,5 */
let closed2:ClosedRange                             = 3...7         /* This represents 3,4,5,6,7 */
// let closed3:ClosedInterval                       = 3..<8         /* This is an error. You can't specify a closed interval with an open operator. */

let closed4                                         = 3...7         /* This is not an Interval. It is a Range. */
let closed5                                         = 3..<8         /* This is not an Interval. It is a Range. */

let closed6Float:ClosedRange<Float>                 = 2...9         /* This represents 2.0 -> 9.0 as a continuous range. */
let closed7Double                                   = 2.0...9.0     /* This represents 2.0 -> 9.0 as a continuous range. Specifying as a Double makes it an Interval.  */

// String Intervals
// These are odd. Looks like it is using the ASCII values. I should experiment with Unicode, and see where we go...
let aThroughFClosed:ClosedRange<String>             = "A"..."F"
let dThroughQClosed:ClosedRange                     = "D"..."Q"
let mThroughSClosed:ClosedRange                     = "M"..."S"
let tThroughWClosed:ClosedRange                     = "T"..."W"
let whiskeyTangoFoxtrot1                            = "QED"..."WTF" /* Not sure what will happen when I start working with this... */

// 1.2.1.2: HALF-OPEN

// Half-open intervals can only be open in the last value. The first value is inclusive.
let afopen1:Range<Int>                   = 5..<10        /* This represents 5,6,7,8,9 */
let afopen2:Range<Int>                   = 7..<20        /* This represents 7,8,9,10,11,12,13,14,15,16,17,18,19 */
let afopenFloat1:Range<Float>            = 2..<9         /* This represents 2.0 < 9.0 as a continuous range. */
let afopenFloat2:Range<Float>            = 7..<13        /* This represents 7.0 < 13.0 as a continuous range. */
// let afopen3:HalfOpenInterval<Int>                   = 5>..10        /* This is an error. You can't have half-open intervals open on the bottom. */
// let afopenFloat3:HalfOpenInterval<Float>            = 2...9         /* This is an error. You can't specify a half open as a closed. */

let aThroughHHalfOpen:Range<String>      = "A"..<"H"
let dThroughRHalfOpen:Range              = "D"..<"R"
let mThroughTHalfOpen:Range              = "M"..<"T"
let tThroughXHalfOpen:Range              = "T"..<"X"
let whiskeyTangoFoxtrot2                            = "QED"..<"WTF"

// 1.2.2: CLAMPING

// Clamping is basically the same as a set intersect. It selects the highest low value as the start, and the lowest high value as the end.
// You can clamp intervals, but not ranges.
let clampedValue1                                   = closed2.clamped ( to: closed1 )     /* This represents 3,4,5 */
let clampedValue2                                   = afopen2.clamped ( to: afopen1 )     /* This represents 7,8,9 */
// let clampedValue3                                   = closed2.clamped ( to: afopen1 )  /* This is an error. You can't mix interval types. */
// let clampedValue4                                   = afopenFloat2.clamped ( to: afopen1 )   /* This is an error. You can't clamp mixed types. */
// let clampedValue5                                   = closed4.clamped ( to: closed1 )  /* This is an error. Ranges can't clamp. */

let clampedString1 = dThroughQClosed.clamped ( to: aThroughFClosed )  /* This represents "D"..."F" */
let clampedString2 = aThroughFClosed.clamped ( to: dThroughQClosed )  /* This represents "D"..."F" */
let clampedString3 = mThroughSClosed.clamped ( to: dThroughQClosed )  /* This represents "M"..."Q" */
let clampedString4 = tThroughWClosed.clamped ( to: dThroughQClosed )  /* This represents "Q"..."Q" */
let clampedString5 = tThroughWClosed.clamped ( to: aThroughFClosed )  /* This represents "F"..."F" */

let clampedString6 = dThroughRHalfOpen.clamped ( to: aThroughHHalfOpen )  /* This represents "D"..<"G" */
let clampedString7 = aThroughHHalfOpen.clamped ( to: dThroughRHalfOpen )  /* This represents "D"..<"H" */
let clampedString8 = mThroughTHalfOpen.clamped ( to: dThroughRHalfOpen )  /* This represents "M"..<"R" */
let clampedString9 = tThroughXHalfOpen.clamped ( to: dThroughRHalfOpen )  /* This represents "R"..<"R" */
let clampedString0 = tThroughXHalfOpen.clamped ( to: aThroughHHalfOpen )  /* This represents "H"..<"H" (Not exactly sure why) */

// PART 2: USING RANGES AND INTERVALS

// 2.1 USING RANGES

// 2.1.1 RANGES AS LOOP ITERATORS

// The main use for ranges is cheap iterators for loops. They are easy to specify, and easy to use.

// A standard iterator
for i in range1 { print ( "Loop Iteration \(i)" ) }

// You can use the wildcard if you don't care about the actual iterator value.
for _ in range1 { print ( "Another Loop Iteration." ) }

// 2.2: USING INTERVALS

// Intervals are used for purposes of comparison and value matching.

// 2.2.1: INTEGER INTERVALS

// This is an error. You can't iterate Intervals.
// for i in closed1 { print ( "Loop Iteration \(i)" ) }

// 2.2.1.1 INTEGER INTERVALS AS SWITCH TESTS

// Use Intervals in switch statements to specify a range of possible values (a "catchbasket").
var testValue1 = 1

switch ( testValue1 )
{
    // This is an error. You can't match against Ranges.
    //    case closed4:
    //        print ( "In range!" )
    // This is an error. The Interval is a Double, but the test is an Int.
    //    case closed7Double:
    //        print ( "In closed7Double" )
    
case closed1:
    print ( "In closed1." )   /* This will catch the value. */
    
default:
    print ( "In catchall." )
}

switch ( testValue1 )   /* This will test against the interval of 3 -> 5 */
{
case clampedValue1:
    print ( "In clampedValue1." )
    
default:
    print ( "In catchall." )  /* Since it is not in the clamped interval, we fall into the catchall. */
}

// We try it with 3 as the value.
testValue1 = 3

switch ( testValue1 )
{
case closed1:
    print ( "In closed1." )   /* This will catch the value again. */
    
default:
    print ( "In catchall." )
}

switch ( testValue1 )
{
case clampedValue1:
    print ( "In clampedValue1." )   /* Now that the test value is in the interval window, we catch it here. */
    
default:
    print ( "In catchall." )
}

// This is a logical error (but not flagged by the compiler, so it counts as a "gotcha"). The two intervals have overlapping ranges.
// You are allowed to specify intervals that overlap, but only the first "hit" will count.

switch ( testValue1 )
{
case closed1:   /* This will catch all numbers between 1 and 5. */
    print ( "In closed1." )   /* This will catch the value, even though it also falls into the next one. */
    
case clampedValue1: /* This will not catch any numbers, as the interval is 3,4,5. */
    print ( "In clampedValue1." )
    
default:
    print ( "In catchall." )
}

// If we switch the two tests, then the clampedValue1 test is the hit.

switch ( testValue1 )
{
case clampedValue1:
    print ( "In clampedValue1." )   /* This will catch the value, even though it also falls into the next one. */
    
case closed1:
    print ( "In closed1." )
    
default:
    print ( "In catchall." )
}

// However, in this one, the second test will hit, because 1 is not in the first interval.
testValue1 = 1

switch ( testValue1 )
{
case clampedValue1:
    print ( "In clampedValue1." )
    
case closed1:
    print ( "In closed1." )   /* You sunk my battleship! */
    
default:
    print ( "In catchall." )
}

// 2.2.1.2 INTEGER INTERVALS AS BOOLEAN TESTS

// You test by using the Interval.contains() method.

if ( closed1.contains ( testValue1 ) )
{
    print ( "We gots us a match!" )
}

if ( !clampedValue1.contains ( testValue1 ) )
{
    print ( "We gots us a mismatch!" )
}

// 2.2.2: FLOATING POINT INTERVALS

// 2.2.2.1: FLOATING POINT INTERVALS AS SWITCH TESTS

var testValue2:Float = 2.0

switch ( testValue2 )
{
    // This is an error. You can't compare against other types.
    //    case closed1:
    //        print ( "In closed1." )
    
case afopenFloat1:  /* This will catch the value, as it is within the interval range. */
    print ( "In the range of 2..<9!" )
    
case afopenFloat2:
    print ( "In the range of 7..<13!" )
    
default:
    print ( "In catchall." )
}

testValue2 = 7.0

switch ( testValue2 )
{
case afopenFloat1: /* This will catch it, even though it is also in the next test range. */
    print ( "In the range of 2..<9!" )
    
case afopenFloat2:
    print ( "In the range of 7..<13!" )
    
default:
    print ( "In catchall." )
}

testValue2 = 8.999999   /* NOTE: Look at the displayed value. */

switch ( testValue2 )
{
case afopenFloat1: /* This will catch it. */
    print ( "In the range of 2..<9!" )
    
case afopenFloat2:
    print ( "In the range of 7..<13!" )
    
default:
    print ( "In catchall." )
}

// This illustrates a precision "gotcha." Note what happens when we add one more "9" to the end.
testValue2 = 8.9999999

switch ( testValue2 )
{
case afopenFloat1:
    print ( "In the range of 2..<9!" )
    
case afopenFloat2: /* This will catch it, even though the number is "less" than 9.0. */
    print ( "In the range of 7..<13!" )
    
default:
    print ( "In catchall." )
}

testValue2 = 9.0

switch ( testValue2 )
{
case afopenFloat1: /* This will not catch it, as the value needs to be LESS than 9.0 to match. */
    print ( "In the range of 2..<9!" )
    
case closed6Float:
    print ( "In the range of 2...9!" )  /* This will catch the value, as it is within the closed interval range. */
    
case afopenFloat2:
    print ( "In the range of 7..<13!" )
    
default:
    print ( "In catchall." )
}

testValue2 = 9.00001

switch ( testValue2 )
{
    // This is an error. The Interval is a ClosedInterval<Double>, but the test value is a Float
    //    case closed7Double:
    //        print ( "In closed7Double" )
    
case afopenFloat1: /* This will not catch it, as the value needs to be LESS than 9.0 to match. */
    print ( "In the range of 2..<9!" )
    
case closed6Float:
    print ( "In the range of 2...9!" )
    
case afopenFloat2:
    print ( "In the range of 7..<13!" ) /* This will catch the value, as it is within the interval range. */
    
default:
    print ( "In catchall." )
}

testValue2 = 1.0

switch ( testValue2 )
{
case afopenFloat1:
    print ( "In the range of 2..<9!" )
    
case afopenFloat2:
    print ( "In the range of 7..<13!" )
    
default: /* Since neither of the above intervals has this value, we get it. */
    print ( "In catchall." )
}

// Test with a Double (not a Float).
var testValue2Double:Double = 2.0

switch ( testValue2Double )
{
case closed7Double:  /* This will catch it. */
    print ( "In closed7Double" )
    
default:
    print ( "In catchall." )
}

testValue2Double = 1.999999999999999    /* There is enough precision to make this just less than 2.0 */

switch ( testValue2Double )
{
case closed7Double:
    print ( "In closed7Double" )
    
default:  /* This will catch it. */
    print ( "In catchall." )
}

// 2.2.2.2 FLOATING POINT INTERVALS AS BOOLEAN TESTS

testValue2 = 2.345

if ( afopenFloat1.contains ( testValue2 ) )
{
    print ( "We gots us a match!" )
}

if ( !afopenFloat2.contains ( testValue2 ) )
{
    print ( "We gots us a mismatch!" )
}

// 2.2.3: STRING INTERVALS

// String intervals are weird. Just sayin'...

// 2.2.3.1: STRING INTERVALS AS SWITCH TESTS

var testValue3:String = "B"

switch ( testValue3 )
{
case aThroughFClosed:   /* This will catch it. */
    print ( "In A...F." )
    
default:
    print ( "In catchall." )
}

// Looks like the test is only on the first letter.
testValue3 = "Badz-Maru"

switch ( testValue3 )
{
case aThroughFClosed:   /* This will catch it. */
    print ( "In A...F." )
    
default:
    print ( "In catchall." )
}

testValue3 = "\tBadz-Maru"   /* If we add a tab character to the start of the string, then the first test will fail. */

switch ( testValue3 )
{
case aThroughFClosed:
    print ( "In A...F." )
    
default:    /* This will catch it. */
    print ( "In catchall." )
}

// Now, we'll get really strange. Let's look at our multi-character intervals...

testValue3 = "W"

switch ( testValue3 )
{
case whiskeyTangoFoxtrot2:  /* This catches it. */
    print ( "WTF, dude?" )
    
default:
    print ( "In catchall." )
}

testValue3 = "T"

switch ( testValue3 )
{
case whiskeyTangoFoxtrot2:  /* This catches it. */
    print ( "WTF, dude?" )
    
default:
    print ( "In catchall." )
}

testValue3 = "F"

switch ( testValue3 )
{
case whiskeyTangoFoxtrot2:
    print ( "WTF, dude?" )
    
default: /* However, in this case, it falls through to default. */
    print ( "In catchall." )
}

testValue3 = "WT"

switch ( testValue3 )
{
case whiskeyTangoFoxtrot2: /* "WT" is caught. */
    print ( "WTF, dude?" )
    
default:
    print ( "In catchall." )
}

testValue3 = "WTF"

switch ( testValue3 )
{
case whiskeyTangoFoxtrot2:
    print ( "WTF, dude?" )
    
default:    /* "WTF" is not caught. */
    print ( "In catchall." )
}

testValue3 = "QED"

switch ( testValue3 )
{
case whiskeyTangoFoxtrot2:  /* "QED" is caught. */
    print ( "WTF, dude?" )
    
default:
    print ( "In catchall." )
}

testValue3 = "QTF"

switch ( testValue3 )
{
case whiskeyTangoFoxtrot2:  /* "QTF" is caught. */
    print ( "WTF, dude?" )
    
default:
    print ( "In catchall." )
}

testValue3 = "QSF"

switch ( testValue3 )
{
case whiskeyTangoFoxtrot2:  /* "QSF" is caught. */
    print ( "WTF, dude?" )
    
default:
    print ( "In catchall." )
}

testValue3 = "QAF"

switch ( testValue3 )
{
case whiskeyTangoFoxtrot2:
    print ( "WTF, dude?" )
    
default: /* QAF falls through. */
    print ( "In catchall." )
}

// Basically, I don't think we should use multi-character strings in intervals. The behavior seems undefined.

// PART 3: STRIDES

// Strides are sort of a Range. They are mostly used to iterate for loops. Use a stride to iterate in "jumps," or to iterate backwards (Ranges cannot be defined in reverse).

let randallFlagg:StrideTo<Int> = stride ( from: 0, to: 6, by: 3 )   /* StrideTo is a "half open" Range. It does not include the last value. */

for i1 in randallFlagg
{
    print ( "i1 is \(i1)" )
}

let aragorn:StrideThrough<Int> = stride ( from: 0, through: 6, by: 3 )  /* StrideThrough is a "closed" Range, which includes the last value. */

for i2 in aragorn
{
    print ( "i2 is \(i2)" )
}

// We can also use Strides to iterate backwards.

let frodo:StrideThrough<Int> = stride ( from: 6, through: 0, by: -3 )

for i3 in frodo
{
    print ( "i3 is \(i3)" )
}

// You can implicitly type the strides.
let bubbaThrough = stride ( from: 1, through: 5, by: 1 )

for bub in bubbaThrough
{
    print( "Bubba be \(bub)" )
}

let bubbaTo = stride ( from: 0, to: 5, by: 2 )

for bub in bubbaTo
{
    print( "Bubba be \(bub)" )
}

// Strides are often defined directly in the loop declarations.

for bub in stride ( from: 6, through: 0, by: -2 )
{
    print( "Bubba be \(bub)" )
}

// You can define a nonsensical stride, but it won't result in any loop executions.
let bubbaBad = stride ( from: 0, to: 5, by: -2 )

for bub in bubbaBad
{
    print( "Bubba be bad: \(bub)" )
}

// One advantage of Strides, is that you can increment in floating point steps.
let strideFloat:StrideTo<Float> = stride ( from: Float(0), to: 5, by: 2.1 )

for i4 in strideFloat
{
    print( "i4 is \(i4)" )
}

// These are the basics of the Range, Interval and Stride types, but there's a lot more depth to this rabbit hole...

// PART 4: Range Generators (SequenceType)

// Range generators are basically iterators. Iterable classes can spit out a generator, which is basically a disposable iterator.

// This example came from here: http://schani.wordpress.com/2014/06/03/playing-with-swift/

let arr = [1, 2, 3]

for x in arr
{
    print ( x )
}

// Which is really...

var arrGen = arr.makeIterator()

while let x = arrGen.next()
{
    print ( x )
}

// Try the same thing with a dictionary.

let uncleBobIsCool = [ "A":1, "B":2, "C":3, "D":4, "E":5 ]

for x in uncleBobIsCool
{
    print ( x )
}

var dictGen = uncleBobIsCool.makeIterator()

while let x = dictGen.next()
{
    print ( x )
}

// This is an example I plucked from here: http://sketchytech.blogspot.com/2014/08/swift-adopt-sequence-protocol-and-use.html

// This shows how to create a simple struct-based iterator.

// SequenceType is a struct (not a class), and requires a GeneratorType-based struct as a typealias
struct MySequence:Sequence
{
    var x, y, length:Int    // These are the hypothetical struct data members.
    
    // The SequenceType protocol dictates that we have a generate() method that emits a GeneratorType-based struct.
    // Swift is kinda cool, in that you can define a typealias as a required prototype component.
    typealias GeneratorType = MyGenerator
    
    // This function instantiates a generator object, and returns that.
    // Since this is a struct, the object is a struct, and is returned by value.
    // That means that this object will not be affected by the iterator.
    func makeIterator() -> GeneratorType
    {
        // Length indicates how many iterations will be allowed.
        // The other two parameters are the starting values of the data members.
        return MyGenerator ( x:x, y:y, length:length )
    }
    
    mutating func next() -> GeneratorType.Element? {
        if length == 0 {
            return nil
        } else {
            length -= 1
            x += 1
            y += 1
            return ( x, y )
        }
    }
}

// This struct models one generator object.
// The generator is a "disposable" instance that is created by an instance of MySequence.
// The GeneratorType protocol requires a generic type, called "Element," which can be anything you want,
// and a "next()" method that returns one of the "Element" instances.
struct MyGenerator:IteratorProtocol
{
    var x, y, length:Int    // These are the values
    
    typealias Element = ( Int, Int )    // In the case of this example, "Element" is a tuple, containing x and y Int values.
    
    // This is the required next() method. Since this is a struct, we need the "mutating" keyword.
    mutating func next() -> Element?    // The return is optional, as we return nil when done.
    {
        // We just go for as many counts as "length" gave us, incrementing the values as we go.
        if length > 0
        {
            length -= 1
            x += 1
            y += 1
            return ( x, y )
        }
        else
        {
            return nil  // At the end, we return nil.
        }
    }
}

var seq = MySequence ( x:10, y:10, length:10 )

for point in seq
{
    print ( point )
}

// We can go again without a rewind.
// Note the data member values are at the old starting point.
// That's because internally, a new generator is created.

for point in seq
{
    print ( point )
}

// Let's create a new instance.
seq = MySequence ( x:10, y:10, length:10 )

// This is what's going on inside.
// Note that we need a "var", as we are mutating the struct.
var seqGen = seq.makeIterator()

// Since we generated a new generator, we start from the beginning again.
while let x = seqGen.next()
{
    print ( x )
}

// Now, if we try to go again, we won't have any luck.
while let x = seqGen.next()
{
    print ( x )
}

// However, if we reset length in the generator, we can go again, continuing to increment the values.
seqGen.length = 10

while let x = seqGen.next()
{
    print ( x )
}

// Just to prove that the original instance remains untouched.
print ( "x: \( seq.x ), y: \( seq.y ), length: \( seq.length )" )

// Ranges, and Strides
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

