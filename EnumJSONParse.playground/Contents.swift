// Progress: Page 143
//
// Questions:
//
// - 

/* Import Foundation so the following are identified: NSUTF8StringEncoding, NSJSONSerialization, NSJSONReadingOptions, NSNumber, NSDictionary
*/

import Foundation

// Start - Copied From JSON.swift (since Playground's can't reference other files)
enum JSONValue {
    
    case JSONObject([String:JSONValue])
    case JSONArray([JSONValue])
    case JSONString(String)
    case JSONNumber(NSNumber)
    case JSONBool(Bool)
    case JSONNull
    
    var object: [String:JSONValue]? {
        switch self {
        case .JSONObject(let value):
            return value
        default:
            return nil
        }
    }
    
    var array: [JSONValue]? {
        switch self {
        case .JSONArray(let value):
            return value
        default:
            return nil
        }
    }
    
    var string: String? {
        switch self {
        case .JSONString(let value):
            return value
        default:
            return nil
        }
    }
    
    var integer: Int? {
        switch self {
        case .JSONNumber(let value):
            return value.integerValue
        default:
            return nil
        }
    }
    
    var double: Double? {
        switch self {
        case .JSONNumber(let value):
            return value.doubleValue
        default:
            return nil
        }
    }
    
    var bool: Bool? {
        switch self {
        case .JSONBool(let value):
            return value
        case .JSONNumber(let value):
            return value.boolValue
        default:
            return nil
        }
    }
    
    subscript(i: Int) -> JSONValue? {
        get {
            switch self {
            case .JSONArray(let value):
                return value[i]
            default:
                return nil
            }
        }
    }
    
    subscript(key: String) -> JSONValue? {
        get {
            switch self {
            case .JSONObject(let value):
                return value[key]
            default:
                return nil
            }
        }
    }
    
    static func fromObject(object: AnyObject) -> JSONValue? {
        switch object {
        case let value as NSString:
            return JSONValue.JSONString(value)
        case let value as NSNumber:
            return JSONValue.JSONNumber(value)
        case let value as NSNull:
            return JSONValue.JSONNull
        case let value as NSDictionary:
            var jsonObject: [String:JSONValue] = [:]
            for (k: AnyObject, v: AnyObject) in value {
                if let k = k as? NSString {
                    if let v = JSONValue.fromObject(v) {
                        jsonObject[k] = v
                    } else {
                        return nil
                    }
                }
            }
            return JSONValue.JSONObject(jsonObject)
        case let value as NSArray:
            var jsonArray: [JSONValue] = []
            for v in value {
                if let v = JSONValue.fromObject(v) {
                    jsonArray.append(v)
                } else {
                    return nil
                }
            }
            return JSONValue.JSONArray(jsonArray)
        default:
            return nil
        }
    }
    
}
// end Copied From JSON.swift

let json = "{\"success\":true,\"data\":{\"numbers\":[1,2,3,4,5],\"animal\":\"dog\"}}"

// Approach #1 - Parse JSON (hard way)
if let jsonData = (json as NSString).dataUsingEncoding(NSUTF8StringEncoding) {
    let parsed: AnyObject? = NSJSONSerialization.JSONObjectWithData(
        jsonData,
        options: NSJSONReadingOptions(0),
        error: nil)
    
    // JSON Parsing
    if let parsed = parsed as? [String:AnyObject] {
        if let success = parsed["success"] as? NSNumber {
            if success.boolValue == true {
                if let data = parsed["data"] as? NSDictionary {
                    if let numbers = data["numbers"] as? NSArray {
                        print(numbers)
                    }
                    if let animal = data["animal"] as? NSString {
                        print(animal)
                    }
                }
            }
        }
    }
}

// Approach #2 - Parse JSON using JSON.swift
/* Enums used to simplify JSON parsing. JSON.swift contains an Enum Name Type "JSONValue" that has a Case and Associated Values (of Associated Computed Property Accessors) to describe each possible different type of object format (i.e. array, string, number, bool, null).
   - Subscripts are used to read different types of object formats that return an Optional JSONValue type (returns value in Associated Value or otherwise nil)
   - Computed Properties are used to read different objects (i.e. string, bool) from the values that return Options JSONValue type (returns value in Associated Value or otherwise nil)
   - Conversion from JSON Object into JSONValue using a Method used with NSJSONSerialization that checks and converts the JSON Object type and returns the appropriate JSONValue Enum Instance
   This approach requires JSON.swift, and the following code that maintains safety.
*/
if let jsonData = (json as NSString).dataUsingEncoding(NSUTF8StringEncoding) {
    // Use NSJSONSerialization to convert JSON objects into Foundation objects
    if let parsed: AnyObject = NSJSONSerialization.JSONObjectWithData(
        jsonData,
        options: <#T##NSJSONReadingOptions#>(0),
        error: nil) {
            // Returns an Optional that needs unwrapping using "if" statement
            if let jsonParsed = JSONValue.fromObject(parsed) {
                // JSON Parsing
                if jsonParsed["success"]?.bool == true {
                    // Optional Chaining whereby if the "data" key does not exist then it returns nil and "numbers" key is not reached
                    if let numbers = jsonParsed["data"]?["numbers"]?.array {
                        print(numbers)
                    }
                    if let animal = jsonParsed["data"]?["animal"]?.string {
                        print(animal)
                    }
                }
            }
    }
    
}