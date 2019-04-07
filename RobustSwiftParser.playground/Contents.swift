/*
 <containerElement>
 <arrayElement>Element Value 01</arrayElement>
 <arrayElement>Element Value 02</arrayElement>
 <arrayElement>Element Value 03</arrayElement>
 <arrayElement>Element Value 04</arrayElement>
 <arrayElement>Element Value 05</arrayElement>
 </containerElement>
 
 <!--
 {"containerElement": [  {"arrayElement": "Element Value 01"},
 {"arrayElement": "Element Value 02"},
 {"arrayElement": "Element Value 03"},
 {"arrayElement": "Element Value 04"},
 {"arrayElement": "Element Value 05"}
 ]
 }
 
 
 {"containerElement": {"arrayElement": [ "Element Value 01",
 "Element Value 02",
 "Element Value 03",
 "Element Value 04",
 "Element Value 05"
 ]
 }
 }
 
 {"containerElement": [  {"arrayElement": {"value": "Element Value 01"}},
 {"arrayElement": {"value": "Element Value 02"}},
 {"arrayElement": {"value": "Element Value 03"}},
 {"arrayElement": {"value": "Element Value 04"}},
 {"arrayElement": {"value": "Element Value 05"}}
 ]
 }
 -->
 
 <containerElement>
 <arrayElement>
 <value>Element Value 01</value>
 <value>Element Value 02</value>
 <value>Element Value 03</value>
 <value>Element Value 04</value>
 <value>Element Value 05</value>
 </arrayElement>
 </containerElement>
 
 <!--
 {"containerElement": {"arrayElement": [ {"value": "Element Value 01"},
 {"value": "Element Value 02"},
 {"value": "Element Value 03"},
 {"value": "Element Value 04"},
 {"value": "Element Value 05"}
 ]
 }
 }
 
 {"containerElement": {"arrayElement": [ "Element Value 01",
 "Element Value 02",
 "Element Value 03",
 "Element Value 04",
 "Element Value 05"
 ]
 }
 }
 -->
 
 <containerElement>
 <arrayElement value="Element Value 01"/>
 <arrayElement value="Element Value 02"/>
 <arrayElement value="Element Value 03"/>
 <arrayElement value="Element Value 04"/>
 <arrayElement value="Element Value 05"/>
 </containerElement>
 
 <!--
 {"containerElement": [  {"arrayElement": {"attributes": [{"value": "Element Value 01"}]}},
 {"arrayElement": {"attributes": [{"value": "Element Value 02"}]}},
 {"arrayElement": {"attributes": [{"value": "Element Value 03"}]}},
 {"arrayElement": {"attributes": [{"value": "Element Value 04"}]}},
 {"arrayElement": {"attributes": [{"value": "Element Value 05"}]}}
 ]
 }
 
 {"containerElement": [  {"arrayElement": {"attributes": {"value": "Element Value 01"}}},
 {"arrayElement": {"attributes": {"value": "Element Value 02"}}},
 {"arrayElement": {"attributes": {"value": "Element Value 03"}}},
 {"arrayElement": {"attributes": {"value": "Element Value 04"}}},
 {"arrayElement": {"attributes": {"value": "Element Value 05"}}}
 ]
 }
 -->
 
 <containerElement>
 <arrayElement index="0">Element Value 01</arrayElement>
 <arrayElement index="1">Element Value 02</arrayElement>
 <arrayElement index="2">Element Value 03</arrayElement>
 <arrayElement index="3">Element Value 04</arrayElement>
 <arrayElement index="4">Element Value 05</arrayElement>
 </containerElement>
 
 <!--
 {"containerElement": [  {"arrayElement": [{"attributes": [{"index": 0}]}, {"value": "Element Value 01"}]},
 {"arrayElement": [{"attributes": [{"index": 1}]}, {"value": "Element Value 02"}]},
 {"arrayElement": [{"attributes": [{"index": 2}]}, {"value": "Element Value 03"}]},
 {"arrayElement": [{"attributes": [{"index": 3}]}, {"value": "Element Value 04"}]},
 {"arrayElement": [{"attributes": [{"index": 4}]}, {"value": "Element Value 05"}]}
 ]
 }
 
 {"containerElement": [  {"arrayElement": [{"attributes": [{"index": "0"}]}, {"value": "Element Value 01"}]},
 {"arrayElement": [{"attributes": [{"index": "1"}]}, {"value": "Element Value 02"}]},
 {"arrayElement": [{"attributes": [{"index": "2"}]}, {"value": "Element Value 03"}]},
 {"arrayElement": [{"attributes": [{"index": "3"}]}, {"value": "Element Value 04"}]},
 {"arrayElement": [{"attributes": [{"index": "4"}]}, {"value": "Element Value 05"}]}
 ]
 }
 
 {"containerElement": [  {"arrayElement": [{"attributes": {"index": "0"}}, {"value": "Element Value 01"}]},
 {"arrayElement": [{"attributes": {"index": "1"}}, {"value": "Element Value 02"}]},
 {"arrayElement": [{"attributes": {"index": "2"}}, {"value": "Element Value 03"}]},
 {"arrayElement": [{"attributes": {"index": "3"}}, {"value": "Element Value 04"}]},
 {"arrayElement": [{"attributes": {"index": "4"}}, {"value": "Element Value 05"}]}
 ]
 }
 
 {"containerElement": [  {"arrayElement": [{"attributes": [{"index": "0"}, {"value": "Element Value 01"}]}]},
 {"arrayElement": [{"attributes": [{"index": "1"}, {"value": "Element Value 02"}]}]},
 {"arrayElement": [{"attributes": [{"index": "2"}, {"value": "Element Value 03"}]}]},
 {"arrayElement": [{"attributes": [{"index": "3"}, {"value": "Element Value 04"}]}]},
 {"arrayElement": [{"attributes": [{"index": "4"}, {"value": "Element Value 05"}]}]}
 ]
 }
 -->
 
 <containerElement>
 <arrayElement row="0" value="Element Value 01"/>
 <arrayElement row="1" value="Element Value 02"/>
 <arrayElement row="2" value="Element Value 03"/>
 <arrayElement row="3" value="Element Value 04"/>
 <arrayElement row="4" value="Element Value 05"/>
 </containerElement>
 
 <!--
 {"containerElement": [  {"arrayElement": {"attributes": [{"row": 0}, {"value": "Element Value 01"}]}},
 {"arrayElement": {"attributes": [{"row": 1}, {"value": "Element Value 02"}]}},
 {"arrayElement": {"attributes": [{"row": 2}, {"value": "Element Value 03"}]}},
 {"arrayElement": {"attributes": [{"row": 3}, {"value": "Element Value 04"}]}},
 {"arrayElement": {"attributes": [{"row": 4}, {"value": "Element Value 05"}]}}
 ]
 }
 
 {"containerElement": [  {"arrayElement": [{"attributes": [{"row": 0}, {"value": "Element Value 01"}]}]},
 {"arrayElement": [{"attributes": [{"row": 1}, {"value": "Element Value 02"}]}]},
 {"arrayElement": [{"attributes": [{"row": 2}, {"value": "Element Value 03"}]}]},
 {"arrayElement": [{"attributes": [{"row": 3}, {"value": "Element Value 04"}]}]},
 {"arrayElement": [{"attributes": [{"row": 4}, {"value": "Element Value 05"}]}]}
 ]
 }
 
 {"containerElement": [  {"arrayElement": {"attributes": [{"row": "0"}, {"value": "Element Value 01"}]}},
 {"arrayElement": {"attributes": [{"row": "1"}, {"value": "Element Value 02"}]}},
 {"arrayElement": {"attributes": [{"row": "2"}, {"value": "Element Value 03"}]}},
 {"arrayElement": {"attributes": [{"row": "3"}, {"value": "Element Value 04"}]}},
 {"arrayElement": {"attributes": [{"row": "4"}, {"value": "Element Value 05"}]}}
 ]
 }
 
 {"containerElement": [  {"arrayElement": [{"attributes": [{"row": "0"}, {"value": "Element Value 01"}]}]},
 {"arrayElement": [{"attributes": [{"row": "1"}, {"value": "Element Value 02"}]}]},
 {"arrayElement": [{"attributes": [{"row": "2"}, {"value": "Element Value 03"}]}]},
 {"arrayElement": [{"attributes": [{"row": "3"}, {"value": "Element Value 04"}]}]},
 {"arrayElement": [{"attributes": [{"row": "4"}, {"value": "Element Value 05"}]}]}
 ]
 }
 -->
 */

import Foundation

func convertJSONToDictionary(_ inJSON: String) -> [String: Any] {
    do {
        if let stringData = inJSON.data(using: .utf8), let jsonDict = try JSONSerialization.jsonObject(with: stringData) as? [String: Any] {
            return jsonDict
        }
    } catch(let error) {
        print(String(describing: error))
    }
    return [:]
}

var jsonInterpretations: [[String: Any]] = []

var jsonInterpretationsSecondaryTests: [[String: Any]] = []

func loadJSONIntoDictionaries() {
    // Initial test set
    jsonInterpretations.append(convertJSONToDictionary("{\"containerElement\": [{\"arrayElement\": \"Element Value 01\"}, {\"arrayElement\": \"Element Value 02\"}, {\"arrayElement\": \"Element Value 03\"}, {\"arrayElement\": \"Element Value 04\"}, {\"arrayElement\": \"Element Value 05\"}]}"))
    jsonInterpretations.append(convertJSONToDictionary("{\"containerElement\": {\"arrayElement\": [\"Element Value 01\", \"Element Value 02\", \"Element Value 03\", \"Element Value 04\", \"Element Value 05\"]}}"))
    jsonInterpretations.append(convertJSONToDictionary("{\"containerElement\": [{\"arrayElement\": {\"value\": \"Element Value 01\"}}, {\"arrayElement\": {\"value\": \"Element Value 02\"}}, {\"arrayElement\": {\"value\": \"Element Value 03\"}}, {\"arrayElement\": {\"value\": \"Element Value 04\"}}, {\"arrayElement\": {\"value\": \"Element Value 05\"}}]}"))
    jsonInterpretations.append(convertJSONToDictionary("{\"containerElement\": {\"arrayElement\": [{\"value\": \"Element Value 01\"}, {\"value\": \"Element Value 02\"}, {\"value\": \"Element Value 03\"}, {\"value\": \"Element Value 04\"}, {\"value\": \"Element Value 05\"}]}}"))
    jsonInterpretations.append(convertJSONToDictionary("{\"containerElement\": {\"arrayElement\": [\"Element Value 01\", \"Element Value 02\", \"Element Value 03\", \"Element Value 04\", \"Element Value 05\"]}}"))
    jsonInterpretations.append(convertJSONToDictionary("{\"containerElement\": [{\"arrayElement\": {\"attributes\": [{\"value\": \"Element Value 01\"}]}}, {\"arrayElement\": {\"attributes\": [{\"value\": \"Element Value 02\"}]}}, {\"arrayElement\": {\"attributes\": [{\"value\": \"Element Value 03\"}]}}, {\"arrayElement\": {\"attributes\": [{\"value\": \"Element Value 04\"}]}}, {\"arrayElement\": {\"attributes\": [{\"value\": \"Element Value 05\"}]}}]}"))
    jsonInterpretations.append(convertJSONToDictionary("{\"containerElement\": [{\"arrayElement\": {\"attributes\": {\"value\": \"Element Value 01\"}}}, {\"arrayElement\": {\"attributes\": {\"value\": \"Element Value 02\"}}}, {\"arrayElement\": {\"attributes\": {\"value\": \"Element Value 03\"}}}, {\"arrayElement\": {\"attributes\": {\"value\": \"Element Value 04\"}}}, {\"arrayElement\": {\"attributes\": {\"value\": \"Element Value 05\"}}}]}"))
    jsonInterpretations.append(convertJSONToDictionary("{\"containerElement\": [{\"arrayElement\": [{\"attributes\": [{\"index\": 0}]}, {\"value\": \"Element Value 01\"}]}, {\"arrayElement\": [{\"attributes\": [{\"index\": 1}]}, {\"value\": \"Element Value 02\"}]}, {\"arrayElement\": [{\"attributes\": [{\"index\": 2}]}, {\"value\": \"Element Value 03\"}]}, {\"arrayElement\": [{\"attributes\": [{\"index\": 3}]}, {\"value\": \"Element Value 04\"}]}, {\"arrayElement\": [{\"attributes\": [{\"index\": 4}]}, {\"value\": \"Element Value 05\"}]}]}"))
    jsonInterpretations.append(convertJSONToDictionary("{\"containerElement\": [{\"arrayElement\": [{\"attributes\": [{\"index\": \"0\"}]}, {\"value\": \"Element Value 01\"}]}, {\"arrayElement\": [{\"attributes\": [{\"index\": \"1\"}]}, {\"value\": \"Element Value 02\"}]}, {\"arrayElement\": [{\"attributes\": [{\"index\": \"2\"}]}, {\"value\": \"Element Value 03\"}]}, {\"arrayElement\": [{\"attributes\": [{\"index\": \"3\"}]}, {\"value\": \"Element Value 04\"}]}, {\"arrayElement\": [{\"attributes\": [{\"index\": \"4\"}]}, {\"value\": \"Element Value 05\"}]}]}"))
    jsonInterpretations.append(convertJSONToDictionary("{\"containerElement\": [{\"arrayElement\": [{\"attributes\": {\"index\": \"0\"}}, {\"value\": \"Element Value 01\"}]}, {\"arrayElement\": [{\"attributes\": {\"index\": \"1\"}}, {\"value\": \"Element Value 02\"}]}, {\"arrayElement\": [{\"attributes\": {\"index\": \"2\"}}, {\"value\": \"Element Value 03\"}]}, {\"arrayElement\": [{\"attributes\": {\"index\": \"3\"}}, {\"value\": \"Element Value 04\"}]}, {\"arrayElement\": [{\"attributes\": {\"index\": \"4\"}}, {\"value\": \"Element Value 05\"}]}]}"))
    jsonInterpretations.append(convertJSONToDictionary("{\"containerElement\": [{\"arrayElement\": [{\"attributes\": [{\"index\": \"0\"}, {\"value\": \"Element Value 01\"}]}]}, {\"arrayElement\": [{\"attributes\": [{\"index\": \"1\"}, {\"value\": \"Element Value 02\"}]}]}, {\"arrayElement\": [{\"attributes\": [{\"index\": \"2\"}, {\"value\": \"Element Value 03\"}]}]}, {\"arrayElement\": [{\"attributes\": [{\"index\": \"3\"}, {\"value\": \"Element Value 04\"}]}]}, {\"arrayElement\": [{\"attributes\": [{\"index\": \"4\"}, {\"value\": \"Element Value 05\"}]}]}]}"))
    jsonInterpretations.append(convertJSONToDictionary("{\"containerElement\": [{\"arrayElement\": {\"attributes\": [{\"row\": 0}, {\"value\": \"Element Value 01\"}]}}, {\"arrayElement\": {\"attributes\": [{\"row\": 1}, {\"value\": \"Element Value 02\"}]}}, {\"arrayElement\": {\"attributes\": [{\"row\": 2}, {\"value\": \"Element Value 03\"}]}}, {\"arrayElement\": {\"attributes\": [{\"row\": 3}, {\"value\": \"Element Value 04\"}]}}, {\"arrayElement\": {\"attributes\": [{\"row\": 4}, {\"value\": \"Element Value 05\"}]}}]}"))
    jsonInterpretations.append(convertJSONToDictionary("{\"containerElement\": [{\"arrayElement\": [{\"attributes\": [{\"row\": 0}, {\"value\": \"Element Value 01\"}]}]}, {\"arrayElement\": [{\"attributes\": [{\"row\": 1}, {\"value\": \"Element Value 02\"}]}]}, {\"arrayElement\": [{\"attributes\": [{\"row\": 2}, {\"value\": \"Element Value 03\"}]}]}, {\"arrayElement\": [{\"attributes\": [{\"row\": 3}, {\"value\": \"Element Value 04\"}]}]}, {\"arrayElement\": [{\"attributes\": [{\"row\": 4}, {\"value\": \"Element Value 05\"}]}]}]}"))
    jsonInterpretations.append(convertJSONToDictionary("{\"containerElement\": [{\"arrayElement\": {\"attributes\": [{\"row\": \"0\"}, {\"value\": \"Element Value 01\"}]}}, {\"arrayElement\": {\"attributes\": [{\"row\": \"1\"}, {\"value\": \"Element Value 02\"}]}}, {\"arrayElement\": {\"attributes\": [{\"row\": \"2\"}, {\"value\": \"Element Value 03\"}]}}, {\"arrayElement\": {\"attributes\": [{\"row\": \"3\"}, {\"value\": \"Element Value 04\"}]}}, {\"arrayElement\": {\"attributes\": [{\"row\": \"4\"}, {\"value\": \"Element Value 05\"}]}}]}"))
    jsonInterpretations.append(convertJSONToDictionary("{\"containerElement\": [{\"arrayElement\": [{\"attributes\": [{\"row\": \"0\"}, {\"value\": \"Element Value 01\"}]}]}, {\"arrayElement\": [{\"attributes\": [{\"row\": \"1\"}, {\"value\": \"Element Value 02\"}]}]}, {\"arrayElement\": [{\"attributes\": [{\"row\": \"2\"}, {\"value\": \"Element Value 03\"}]}]}, {\"arrayElement\": [{\"attributes\": [{\"row\": \"3\"}, {\"value\": \"Element Value 04\"}]}]}, {\"arrayElement\": [{\"attributes\": [{\"row\": \"4\"}, {\"value\": \"Element Value 05\"}]}]}]}"))
    
    // Extra Credit
    jsonInterpretations.append(convertJSONToDictionary("{\"arrayElement\": [{\"value\": \"Element Value 01\"}, {\"value\": \"Element Value 02\"}, {\"value\": \"Element Value 03\"}, {\"value\": \"Element Value 04\"}, {\"value\": \"Element Value 05\"}]}"))
    jsonInterpretations.append(convertJSONToDictionary("{\"containerElement\": [{\"arrayElement\": {\"attributes\": [{\"row\": 3}, {\"value\": \"Element Value 04\"}]}}, {\"arrayElement\": {\"attributes\": [{\"row\": 2}, {\"value\": \"Element Value 03\"}]}}, {\"arrayElement\": {\"attributes\": [{\"row\": 1}, {\"value\": \"Element Value 02\"}]}}, {\"arrayElement\": {\"attributes\": [{\"row\": 4}, {\"value\": \"Element Value 05\"}]}}, {\"arrayElement\": {\"attributes\": [{\"row\": 0}, {\"value\": \"Element Value 01\"}]}}]}"))
    
    // Differing Data
    jsonInterpretationsSecondaryTests.append(convertJSONToDictionary("{\"containerElement\": [{\"arrayElement\": {\"attributes\": [{\"row\": 3}, {\"value\": 3}]}}, {\"arrayElement\": {\"attributes\": [{\"row\": 2}, {\"value\": \"3.14\"}]}}, {\"arrayElement\": {\"attributes\": [{\"index\": 1}, {\"value\": \"0123456789!@~*&^%$#.,;:?/'\"}]}}, {\"arrayElement\": {\"attributes\": [{\"row\": 4}, {\"value\": 1234567890}]}}, {\"arrayElement\": {\"attributes\": [{\"index\": 0}, {\"value\": \"12345.6789\"}]}}]}"))
    jsonInterpretationsSecondaryTests.append(convertJSONToDictionary("{\"containerElement\": [{\"arrayElement\": \"3\"}, {\"arrayElement\": \"3.14\"}, {\"arrayElement\": \"0123456789!@~*&^%$#.,;:?/'\"}, {\"arrayElement\": \"1234567890\"}, {\"arrayElement\": \"12345.6789\"}]}"))
    jsonInterpretationsSecondaryTests.append(convertJSONToDictionary("{\"containerElement\": [{\"arrayElement\": 3}, {\"arrayElement\": 3.14}, {\"arrayElement\": \"0123456789!@~*&^%$#.,;:?/'\"}, {\"arrayElement\": 1234567890}, {\"arrayElement\": 12345.6789}]}"))
}

loadJSONIntoDictionaries()

let whatWeWantToSee: [String] = ["Element Value 01", "Element Value 02", "Element Value 03", "Element Value 04", "Element Value 05"]
let whatWeWantToSee2: [String] = ["0123456789!@~*&^%$#.,;:?/'", "12345.6789", "1234567890", "3", "3.14"]

func recursiveDescentParser(_ inDictionaryToBeParsed: [AnyHashable: Any], blackList inBlacklist: [String] = []) -> [String] {
    var ret = [String]()
    
    inDictionaryToBeParsed.forEach {
        if let asFloat = ($0.value as? Double ?? Double($0.value as? String ?? "ERROR")) {
            let formatter = NumberFormatter()
            formatter.minimumIntegerDigits = 1
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 20
            if let keyString = $0.key as? String, !inBlacklist.contains(keyString) {
                ret += [String(formatter.string(from: asFloat as NSNumber) ?? "")]
            }
        } else if let asString = $0.value as? String, let keyString = $0.key as? String, !inBlacklist.contains(keyString) {
            ret += [asString]
        } else if let asDictionary = $0.value as? [AnyHashable: Any] {
            ret += recursiveDescentParser(asDictionary, blackList: inBlacklist)
        } else if let asDictionaryArray = $0.value as? [[AnyHashable: Any]] {
            asDictionaryArray.forEach { elem in
                ret += recursiveDescentParser(elem, blackList: inBlacklist)
            }
        } else if let asArray = $0.value as? [String] {
            asArray.forEach { elem in
                ret += recursiveDescentParser(["": elem], blackList: inBlacklist)
            }
        }
    }
    
    return ret.sorted()
}

// Test Set 1
jsonInterpretations.forEach {
    let parsedResult = recursiveDescentParser($0, blackList: ["index", "row"])
    if whatWeWantToSee != parsedResult {
        print("ERROR! Bad Result: \(parsedResult) for \($0)")
    } else {
        //        print("\($0) Passes!")
    }
}

// Test Set 2
jsonInterpretationsSecondaryTests.forEach {
    let parsedResult = recursiveDescentParser($0, blackList: ["index", "row"])
    if whatWeWantToSee2 != parsedResult {
        print("ERROR! Bad Result: \(parsedResult) for \($0)")
    } else {
        //        print("\($0) Passes!")
    }
}
