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

public var jsonInterpretations: [[String: Any]] = []

public func convertJSONToDictionary(_ inJSON: String) -> [String: Any] {
    do {
        if let stringData = inJSON.data(using: .utf8), let jsonDict = try JSONSerialization.jsonObject(with: stringData) as? [String: Any] {
            return jsonDict
        }
    } catch(let error) {
        print(String(describing: error))
    }
    return [:]
}

public func loadJSONIntoDictionaries() {
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
}

let whatWeWantToSee: [String] = ["Element Value 01", "Element Value 02", "Element Value 03", "Element Value 04", "Element Value 05"]

print("What We Want the results to be:\n" + String(describing: whatWeWantToSee))

loadJSONIntoDictionaries()

func robustRecursiveDescentParser(_ inDictionaryToBeParsed: [String: Any],
                                  notTheseKeys inNotTheseKeys: [String] = [],
                                  onlyTheseKeys inOnlyTheseKeys: [String] = []) -> [String] {
    return inDictionaryToBeParsed.reduce([]) { (current, next) -> [String] in
        var ret = current

        if let asString = next.value as? String {
            if (inOnlyTheseKeys.isEmpty || inOnlyTheseKeys.contains(next.key)) && (inNotTheseKeys.isEmpty || !inNotTheseKeys.contains(next.key)) {
                ret += [asString]
            }
        } else if let asDictionaryArray = next.value as? [[String: Any]] {
            asDictionaryArray.forEach { elem in
                ret += robustRecursiveDescentParser(elem, notTheseKeys: inNotTheseKeys, onlyTheseKeys: inOnlyTheseKeys)
            }
        } else if let asDictionary = next.value as? [String: Any] {
            ret += robustRecursiveDescentParser(asDictionary, notTheseKeys: inNotTheseKeys, onlyTheseKeys: inOnlyTheseKeys)
        } else if let asStringArray = next.value as? [String] {
            asStringArray.forEach { elem in
                ret += robustRecursiveDescentParser([next.key: elem], notTheseKeys: inNotTheseKeys, onlyTheseKeys: inOnlyTheseKeys)
            }
        }
        
        return ret
    }
}

print("\nWhat The Results Are:")

print("Inclusive:")
jsonInterpretations.forEach {
    let result = robustRecursiveDescentParser($0, onlyTheseKeys: ["value", "arrayElement"])
    if result != whatWeWantToSee {
        print("ERROR! - Result: \(result)\n\tInput: \($0)")
    }
    print(result)
}

print("\nExclusive:")
jsonInterpretations.forEach {
    let result = robustRecursiveDescentParser($0, notTheseKeys: ["index", "row"])
    if result != whatWeWantToSee {
        print("ERROR! - Result: \(result)\n\tInput: \($0)")
    }
    print(result)
}
