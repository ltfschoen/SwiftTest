// Progress: Page 157
//
// Questions:
//
// - Why error "'contains' is unavailable, call 'contains()' on the sequence when applying imperative approach on page 158?
// - When I try to compile the solution code to buildIndex challenge (based on page 164 of the book) that uses '.sorted(<)' give compiler error "'sorted' is unavailable: call the 'sort()' method on the array" (page 164 of the text suggests against using 'sort' since it mutates the array instead of returning a new sorted instance that may be achieved by using 'sorted')?  Also, why does it use a semi-colon '};' at the end of the chaining of '.sorted'/'.map' block?

/* Purpose: Functional programming to group a list of words into index based on first letter (case insensitive) of each
   - Imperative-Version - Use variables defined with 'var'
   - Functional-Version - Use constants defined with 'let' for Immutability (easier to Test, supports Concurrency)
*/
import Foundation

let words = ["Moose", "Cow", "Snake", "Fish", "Bear"]

// Define Tuple Type for each Index entry using Typealias to make code more readable
typealias Entry = (Character, [String])

//// Index-building code structure
//func buildIndex(words: [String]) -> [Entry] {
//    return [Entry]()
//}
//print(buildIndex(words))

//// Imperative-Version of buildIndex
//func buildIndex(words: [String]) -> [Entry] {
//    var result = [Entry]()
//
//    var letters = [Character]()
//
//    // Part 1: Iterate over each word to build array of letters (i.e. [letter1, letter2, ...])
//    for word in words {
//        let firstLetter = Character(word.substringFromIndex(advance(word.startIndex, 1)).uppercaseString)
//
//        if !contains(letters, firstLetter) {
//            letters.append(firstLetter)
//        }
//    }
//
//    // Part 2: Iterate over each letter to find words starting with the given letter to build a return array
//    for letter in letters {
//        var wordsForLetter = [String]()
//
//        for word in words {
//            let firstLetter = Character(word.substringToIndex(advance(word.startIndex, 1)).uppercaseString)
//
//            if firstLetter == letter {
//                wordsForLetter.append(word)
//            }
//        }
//
//        result.append((letter, wordsForLetter))
//    }
//
//    return result // return [Entry]
//}

// De-Duplication Method - Iterates over all items in array and builds new array with only unique items
func distinct<T: Equatable>(source: [T]) -> [T] {
    var unique = [T]()

    for item in source {
        if !contains(unique, item) {
            unique.append(item)
        }
    }

    return unique
}

/* Functional-Version of buildIndex - Uses 'map' Functional method of Array API to create new array with results of calls to supplied closure for each element of supplied array, where the new array may contain duplicates prior to use of de-duplication method
*/
func buildIndex(words: [String]) -> [Entry] {

    /* 'firstLetter' Function leverages Swift First-Class Functions to remove duplication caused by extraction and capitalisation of the first letter of a word multiple times.
        Alternative #1 (Objective-C) - Utility Method
        Alternative #2 (Objective-C) - Extend NSString with this method using Class Category
    */
    func firstLetter(str: String) -> Character { // Signature: String -> Character
        return Character(str.substringToIndex(advance(str.startIndex, 1)).uppercaseString)
    }

    // Use 'map' to construct Array of letters taking a Closure with Signature (String) -> Character
    let letters = words.map {
        (word) -> Character in // Signature: String -> Character
        Character(word.substringToIndex(advance(word.startIndex, 1)).uppercaseString)
    }

    // Implement 'distinct' De-Duplication Method
    let distinctLetters = distinct(letters)

    print(letters)

//    return [Entry]()

    // Simplification since Signature of firstLetter Function is the same as that of the first '.map' Block
    return distinct(words.map(firstLetter))
        .sorted(<)
        .map {
            (letter) -> Entry in
//    // Take Array of characters and output Array of Entry Instances
//    return distinctLetters.map {
//        (letter) -> Entry in

        // Nested 'filter' (inside 'map') to populate each Entry Instance with words beginnig with given letter
        return (letter, words.filter {
            (word) -> Bool in
            firstLetter(word) == letter
//            Character(word.substringToIndex(advance(word.startIndex, 1)).uppercaseString) == letter
        })
//        return (letter, [])
    }
}
