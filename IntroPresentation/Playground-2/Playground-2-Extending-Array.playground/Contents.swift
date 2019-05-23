/*
 PLAYGROUND 2: Extending Array Example
 
 ©2019 Rift Valley Software. All Rights Reserved.
 */

import Foundation  // Foundation is required for DateComponents.

/*
 If this is an Array of String, let's assume that the Array is laid out thusly, with Integer values (as Strings) in the Array:
 
 0 - Hours
 1 - Minutes
 2 - seconds
 */
extension Array where Element == String {
    var time: DateComponents! {
        var ret: DateComponents!
        
        if 2 < count {  // This is a runtime state, so it can't be in the where clause.
            ret = DateComponents()
            ret.hour = Int(self[0])
            ret.minute = Int(self[1])
            ret.second = Int(self[2])
        }
        
        return ret
    }
}

/*
 If this is an Array of Int, let's assume that the Array is laid out thusly, with Integer values in the Array:
 
 0 - Hours
 1 - Minutes
 2 - seconds
 */
extension Array where Element == Int {
    var time: DateComponents! {
        var ret: DateComponents!
        
        if 2 < count {
            ret = DateComponents()
            ret.hour = self[0]
            ret.minute = self[1]
            ret.second = self[2]
        }
        
        return ret
    }
}
