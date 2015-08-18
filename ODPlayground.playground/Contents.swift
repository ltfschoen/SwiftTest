//
// OrderedDictionary.swift
// FlickrSearch
//
// Created by LS on 18/08/2015.
// Copyright © 2015 LS. All rights reserved.
//
// Progress: Page 84/XX (Ch3) / 257

// Questions:
//
// - What does copy-on-write mean in relation to mutable Structs?

import Foundation

// Generic Struct with value semantics that may hold any type of values
// Type Parameters of the Generic (i.e. KeyType, ValueType) used in place of types
/* Constrained Generic Type Parameter to conform to a Protocol depending on usage. In this case the type passed for KeyType for OrderedDictionary must conform to Hashable Protocol to be acceptable to hash keys for underlying dictionary in implementation.
*/
struct OrderedDictionary<KeyType: Hashable, ValueType> {
    
    /* Implement an Ordered Dictionary with:
    - Array to hold order of Keys
    - Dictionary to hold Mapping
    */
    
    /* Declared Type Aliases with shorter new names for complex existing types
    using Type Parameters from the Struct Definition
    */
    typealias ArrayType = [KeyType]
    typealias DictionaryType = [KeyType: ValueType]
    
    // Declared Properties
    var array = ArrayType() // Array of KeyTypes (of type passed to Generic instance)
    var dictionary = DictionaryType()
    
    //
    //  READ from dictionary data structure
    //
    
    // Computed Property to get the count of OrderedDictionary (same as array count)
    var count: Int {
        return self.array.count
    }
    
    //
    //  ADD to dictionary data structure
    //
    
    // Key-Value Pair parameters: value, key, index
    // Structs state is immutable by default unless mutating keyword used
    mutating func insert(value: ValueType,
        forKey key: KeyType,
        atIndex index: Int) -> ValueType?
    {
        var adjustedIndex = index
        // pass key to Dictionary indexer to return existing value if any
        let existingValue = self.dictionary[key]
        if existingValue != nil {
            // find array index for key if exists
            let existingIndex = self.array.indexOf(key)!
            // adjust insertion index if existing key is before insertion index
            if existingIndex < index {
                adjustedIndex--
            }
            // remove existing key
            self.array.removeAtIndex(existingIndex)
        }
        
        // update array and dictionary
        self.array.insert(key, atIndex:adjustedIndex)
        self.dictionary[key] = value
        
        // return existing value (Optional as may not exist)
        return existingValue
    }
    
    //
    //  REMOVE from dictionary data structure
    //
    
    // Mutate internal state of Struct. Best practice mirroring APIs of system library
    mutating func removeAtIndex(index: Int) -> (KeyType, ValueType)
    {
        // Check index is within array bounds to prevent runtime error
        // precondition failure terminates app (similar to assert)
        precondition(index < self.array.count, "Index out-of-bounds")
        // retrieve key at given array index and remove its value
        let key = self.array.removeAtIndex(index)
        /* retrieve value at given dictionary key and remove its value and returns Optional incase no value retrieved for given key, however we know the dictionary will contain a value for a given key since only our insert method may add to the dictionary, so we unwrap the Optional
        */
        let value = self.dictionary.removeValueForKey(key)!
        // return key and value in Tuple
        return (key, value)
    }
    
    //    // Access dictionary elements using subscript syntax
    //    let dictionary = [1: "one", 2: "two"]
    //    let one = dictionary[1] // Subscript
    
    // Add Subscript behaviour to Custom Classes comprising getters and setters
    // key parameter defines object expected inside square brackets
    // Subscript returns an Optional to account for when no value exists for key
    subscript(key: KeyType) -> ValueType? {
        // Getter
        get {
            return self.dictionary[key]
        }
        // Setter
        set {
            // Check if key already exists in OrderedDictionary
            if let index = self.array.indexOf(key) {
            } else {
                // Add key to end of array if not already exist in OrderedDictionary
                self.array.append(key)
            }
            // Add new value for given key to Dictionary
            self.dictionary[key] = newValue
        }
    }
    
    // Multiple Subscript definitions in Class or Struct for different argument types
    // Accessing array by index
    subscript(index: Int) -> (KeyType, ValueType) {
        get {
            precondition(index < self.array.count, "Index out-of-bounds")
            let key = self.array[index]
            let value = self.dictionary[key]!
            // return type is Tuple key and value stored at index in OrderedDictionary
            return (key, value)
        }
        set {
            precondition(index < self.array.count, "Index out-of-bounds")
            let (key, value) = newValue
            let originalKey = self.array[index]
            self.dictionary[originalKey] = nil
            self.array[index] = key
            self.dictionary[key] = value
        }
    }
}

var dict = OrderedDictionary<Int, String>()
dict.insert("dog", forKey: 1, atIndex: 0)
dict.insert("cat", forKey: 2, atIndex: 1)
dict.insert("cow", forKey: 3, atIndex: 2)

print(dict.array.description
        + " : "
        + dict.dictionary.description)

var byIndex: (Int, String) = dict[0]
print(byIndex)

var byKey: String? = dict[2]
print(byKey)
