import Foundation
import CoreLocation

// Pretend this Dictionary is the result of parsing a "Localizable.strings" file.
// In this case, we are translating from Engineering to Marketing.
let g_localized_strings: [String: String] = [
    "This app's infested with bugs.": "This app's loaded with features!",
    "What you are asking for is impossible.": "We'll have this ready for beta-testing in a month!",
    "This project is a nightmare.": "This is the project that I've been dreaming of!",
    "This schedule is completely unrealistic.": "This sounds like a fascinating challenge!"
]

// Now that's out of the way, let's extend String.

// You cannot add stored properties to a class, struct or enum.
// For example, this is an error:
// extension String {
//     var alternateValue: String = ""
// }

// However, you can add calculated properties:
extension String {
    // NOTE: In "Real Life," I'd have this more like so:
    // var localizedVariant: String { return NSLocalizedString(self, "") }
    var localizedVariant: String { return g_localized_strings[self] ?? self }
}

// Let's see that in action!
let engineeringStatement = "This app's infested with bugs."
let projectManagementHears = engineeringStatement.localizedVariant
let projectManagementAlsoHears = "What you are asking for is impossible.".localizedVariant

print("Engineering says: \"\(engineeringStatement)\".\nProject Management hears: \"\(projectManagementHears)\".")

print("Project Management hears: \"\("This app's infested with bugs.".localizedVariant)\".")

// You can add a static (or class) property:
extension String {
    static var Parrot: String { return "Norwegian Blue" }
}

let deadParrotWas = String.Parrot

// Here's an example of extending Double to return its value (assumed to be Degrees) as Radians.
extension Double {
    // radians = degrees * π / 180.0
    var radians: Double { return (self * Double.pi)/180.0 }
}

// You can also get cheeky (Remember that Swift is UTF-8 compatible):
extension Double {
    static var π: Double { return self.pi as Double }
    var π: Double { return type(of: self).π }
}

let maipai:Double = .π

// You can also add functions in extensions
extension Double {
    func multiplyMeBy(_ inValue: Double) -> Double { return self * inValue }
}

let result = 2.multiplyMeBy(7)

// This returns the value's "Golden Ratio," either higher or lower.
extension Double {
    static var goldenRatio: Double { return (1 + 5.0.squareRoot()) / 2 }
    var goldenRatioValues: (below: Double, above: Double) { return (self / type(of: self).goldenRatio, self * type(of: self).goldenRatio) }
}

let itsGolden = Double.goldenRatio
let mySize: Double = 1.234567
let sizeOfSmallerElement = mySize.goldenRatioValues.below
let sizeOfLargerElement = mySize.goldenRatioValues.above

let degrees90 = 90.0
let degreesToRadians90 = degrees90.radians
let degreesToRadians180 = 180.0.radians

// Adapted from here: https://github.com/raywenderlich/swift-algorithm-club/tree/master/HaversineDistance
func haversineDistance(la1: Double, lo1: Double, la2: Double, lo2: Double, radius: Double = 6367444.7) -> Double {
    let haversin = { (angle: Double) -> Double in
        return (1 - cos(angle))/2
    }
    
    let ahaversin = { (angle: Double) -> Double in
        return 2*asin(sqrt(angle))
    }
    
    return (radius * ahaversin(haversin(la2.radians - la1.radians) + cos(la1.radians) * cos(la2.radians) * haversin(lo2.radians - lo1.radians))) / 1000.0
}

let amsterdam = (52.3702, 4.8952)
let newYork = (40.7128, -74.0059)

print("The distance from Amsterdam to New York is \(haversineDistance(la1: amsterdam.0, lo1: amsterdam.1, la2: newYork.0, lo2: newYork.1)) kilometers.")

extension CLLocationCoordinate2D {
    func distanceInKilometersFrom(_ inFrom: CLLocationCoordinate2D) -> Double {
        let haversin = { (angle: Double) -> Double in
            return (1 - cos(angle))/2
        }
        
        let ahaversin = { (angle: Double) -> Double in
            return 2 * asin(sqrt(angle))
        }
        
        return 6367.4447 * ahaversin(haversin(inFrom.latitude.radians - self.latitude.radians) + cos(self.latitude.radians) * cos(inFrom.latitude.radians) * haversin(inFrom.longitude.radians - self.longitude.radians))
    }
}

let amsterdamCoords = CLLocationCoordinate2D(latitude: 52.3702, longitude: 4.8952)
let newYorkCoords = CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0059)

print("The distance from Amsterdam to New York is \(newYorkCoords.distanceInKilometersFrom(amsterdamCoords)) kilometers.")

// You can extend enums, as well:
extension DecodingError {
    // You can't do this:
    // case WTF
    
    // However, You can declare a static var that will smell a bit like another case...or...something...
    static var WTF: String { return "\u{1F4A9}" }
    // Or an instance var
    var WTF: String { return type(of: self).WTF }
    // And you can declare static or instance functions:
    static func noReallyWTFDude() -> String { return self.WTF }
    func noReallyWTFDude() -> String { return self.WTF }
}

let dailyWTF = DecodingError.WTF
let crapData = DecodingError.dataCorrupted(DecodingError.Context(codingPath:[], debugDescription: dailyWTF, underlyingError: nil))
let thisDataStinks = crapData.noReallyWTFDude()

// You cannot extend tuples:
typealias Coordinates = (x: Double, y: Double)
// These are both errors:
//extension Coordinates {
//
//}
//extension (x: Double, y: Double) {
//
//}
