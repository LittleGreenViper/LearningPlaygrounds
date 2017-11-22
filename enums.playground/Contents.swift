/*:
 # ENUMS
 
 Here, we'll play with associated value enums.
 
 The scenario is an error reporting system.
 
 We have multiple classes of errors, and, within those classes, specific errors.
 
 We have a localized error string, and a universal error code for each specific error.
 
 This is for a fictional nuclear power plant, run by our favorite plant operator.
 */

import Foundation

//: First, we'll set up a Dictionary of localized strings. The key will be the localized string placeholder. This mimics the standard iOS localization pattern.

let localizedStrings:[String:String] = [
//: First, we have reactor core errors.
    "ERROR-CORE-HEADER"         :       "CORE ERROR!",
    "ERROR-CORE-LO-TEMP"        :       "The core temperature is too low.",
    "ERROR-CORE-HI-TEMP"        :       "The core temperature is too high.",
    "ERROR-CORE-LO-WATER-LEVEL" :       "The water level in the core is too low.",
    "ERROR-CORE-HI-WATER-LEVEL" :       "The water level in the core is too high.",
//: Next, we have generator errors.
    "ERROR-GEN-HEADER"          :       "GENERATOR ERROR!",
    "ERROR-GEN-LO-RPM"          :       "The generator is running too slowly.",
    "ERROR-GEN-HI-RPM"          :       "The generator is running too quickly.",
//: Finally, we have operator errors.
    "ERROR-HOMER-HEADER"        :       "OPERATOR ERROR!",
    "ERROR-HOMER-ASLEEP"        :       "Homer is snoring at his post.",
    "ERROR-HOMER-DONUT-MESS"    :       "Homer has covered the control panel in jelly",
    "ERROR-UNKOWN"              :       "UNKOWN ERROR"
                        ]

//: This is a trick to make the NSLocalizedString call easier to deal with. In this case, we'll be indexing the dictionary instead.

extension String {
    var localized: String {
        get { return localizedStrings[self] ?? (localizedStrings["ERROR-UNKOWN"] ?? "LOCALIZATION POOCHED") }
    }
}

//: Now, we set up our error enums.

//: These are specific errors. We have made them Strings.

enum CoreErrors : String, Swift.Error {
    case header             =   "ERROR-CORE-HEADER"
    case loTemp             =   "ERROR-CORE-LO-TEMP"
    case hiTemp             =   "ERROR-CORE-HI-TEMP"
    case lowWaterLevel      =   "ERROR-CORE-LO-WATER-LEVEL"
    case highWaterLevel     =   "ERROR-CORE-HI-WATER-LEVEL"
}

enum GeneratorErrors : String, Swift.Error {
    case header             =   "ERROR-GEN-HEADER"
    case lowRPM             =   "ERROR-GEN-LO-RPM"
    case highRPM            =   "ERROR-GEN-HI-RPM"
}

enum HomerErrors : String, Swift.Error {
    case header             =   "ERROR-HOMER-HEADER"
    case asleep             =   "ERROR-HOMER-ASLEEP"
    case donutMess          =   "ERROR-HOMER-DONUT-MESS"
}

//: These are the general categories, and are expressed as Ints.

enum ReactorErrors {
    case coreError(_:CoreErrors)
    case generatorError(_:GeneratorErrors)
    case homerError(_:HomerErrors)
    //: This is the "secret sauce." This calculated property decodes the current enum value, extracts the specific string, and also localizes it before returning it.
    var error: (header: String, details: String) {
        get {
            var containedError = "ERROR-UNKOWN"
            var header = "ERROR-UNKOWN"
            
            switch self {
            case let .coreError(specificError) :
                header = CoreErrors.header.rawValue
                containedError = specificError.rawValue
            case let .generatorError(specificError) :
                header = GeneratorErrors.header.rawValue
                containedError = specificError.rawValue
            case let .homerError(specificError) :
                header = HomerErrors.header.rawValue
                containedError = specificError.rawValue
            }
            return (header: header.localized, details: containedError.localized)
        }
    }
}

//: Now, let's put these to the test.

//: We simply set a variable to the specific type of error
let reactorError1 = ReactorErrors.coreError(.loTemp)
//: Then we display the decoded error.
let err1 = "ERROR: \(reactorError1.error.header) -\(reactorError1.error.details)"

let reactorError2 = ReactorErrors.generatorError(.highRPM)

let err2 = "ERROR: \(reactorError2.error.header) -\(reactorError2.error.details)"

let reactorError3 = ReactorErrors.homerError(.donutMess)
let errorTuple = reactorError3.error
let err3 = "ERROR: \(errorTuple.header) -\(errorTuple.details)"

let reactorError4 = ReactorErrors.homerError(.asleep)

// Test for generic errors (ignoring associated values):
if case .coreError = reactorError3 {
    print("ERROR: Generic Core Error! (if - case - ignoring associated value)")
}

if case .generatorError = reactorError3 {
    print("ERROR: Generic Generator Error! (if - case - ignoring associated value)")
}

if case .homerError = reactorError3 {
    print("ERROR: Generic Operator Error! (if - case - ignoring associated value)")
}

// Switch on specific associated values:
switch reactorError3 {
case .homerError(.asleep):
    print("ERROR: Homer is asleep! (switch)")
case .homerError(.donutMess):
    print("ERROR: Homer had a donut mess! (switch)")
default:
    print("ERROR: some other error (\(reactorError4))! (switch)")
}

// Or catch them in if - case:
if case .homerError(.asleep) = reactorError4 {
    print("ERROR: Homer is asleep! (if - case)")
}

if case .homerError(.donutMess) = reactorError4 {
    print("ERROR: Homer had a donut mess! (if - case)")
}

//: Now, remember that closures are first-class citizens in Swift, so we can pass in closures.
enum GenericErrorHandler {
    typealias ErrorHandlerRoutine = ()->Void
    
    case systemError(_:ErrorHandlerRoutine)
    case communicationError(_:ErrorHandlerRoutine)
    case userError(_:ErrorHandlerRoutine)
    
    private func _handleSystemError(_ inErrorHandler:ErrorHandlerRoutine) {
        print("THIS IS A SYSTEM ERROR!")
        inErrorHandler()
    }
    
    private func _handleCommError(_ inErrorHandler:ErrorHandlerRoutine) {
        print("THIS IS A COMMUNICATION ERROR!")
        inErrorHandler()
    }
    
    private func _handleUserError(_ inErrorHandler:ErrorHandlerRoutine) {
        print("THIS IS A USER ERROR!")
        inErrorHandler()
    }
    
    func handleError() {
        switch self {
        case .systemError(let handler):
            self._handleSystemError(handler)
        case .communicationError(let handler):
            self._handleCommError(handler)
        case .userError(let handler):
            self._handleUserError(handler)
        }
    }
}

func displaySystemError() {
    print("Pretend we're displaying an alert, with our particular error, here.")
}

var sysErr = GenericErrorHandler.systemError(displaySystemError)
sysErr.handleError()

sysErr = GenericErrorHandler.systemError({print("This is a very different closure.")})
sysErr.handleError()

let commErr = GenericErrorHandler.communicationError({print("This Could be your code.")})
commErr.handleError()

let userErr = GenericErrorHandler.userError({print("Spank User.")})
userErr.handleError()

