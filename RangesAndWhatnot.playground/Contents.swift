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
// let range7:Range<Float>             = 0..<10    /* This is an error. Floats can't be incremented. */
// let range8:Range                    = 0.0...9.0 /* This is also an error. */
// let range9:Range<String>            = "0"..."9" /* This is an error. Even though these are strings in sequence, they can't be incremented. */

// 1.2: INTERVALS

// Next, let's look at the Interval type. Intervals represent spreads of values, and can be non-integer types.

// 1.2.1: TYPES OF INTERVALS

// 1.2.1.1: CLOSED

// Closed intervals
let closed1:ClosedRange<Int>                     = 1...5         /* This represents 1,2,3,4,5 */
let closed2:ClosedRange                          = 3...7         /* This represents 3,4,5,6,7 */
// let closed3:ClosedInterval                          = 3..<8         /* This is an error. You can't specify a closed interval with an open operator. */

let closed4                                         = 3...7         /* This is not an Interval. It is a Range. */
let closed5                                         = 3..<8         /* This is not an Interval. It is a Range. */

let closed6Float:ClosedRange<Float>              = 2...9         /* This represents 2.0 -> 9.0 as a continuous range. */
let closed7Double                                   = 2.0...9.0     /* This represents 2.0 -> 9.0 as a continuous range. Specifying as a Double makes it an Interval.  */

// String Intervals
// These are odd. Looks like it is using the ASCII values. I should experiment with Unicode, and see where we go...
let aThroughFClosed:ClosedRange<String>          = "A"..."F"
let dThroughQClosed:ClosedRange                  = "D"..."Q"
let mThroughSClosed:ClosedRange                  = "M"..."S"
let tThroughWClosed:ClosedRange                  = "T"..."W"
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
