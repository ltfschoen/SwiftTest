// Progress: Page 157
//
// Questions:
//
// - Why error "'contains' is unavailable, call 'contains()' on the sequence when applying imperative approach on page 158?

/* Purpose: Functional programming to group a list of words into index based on first letter (case insensitive) of each
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

// Imperative-Version of buildIndex
func buildIndex(words: [String]) -> [Entry] {
    var result = [Entry]()

    var letters = [Character]()

    // Part 1: Iterate over each word to build array of letters (i.e. [letter1, letter2, ...])
    for word in words {
        let firstLetter = Character(word.substringFromIndex(advance(word.startIndex, 1)).uppercaseString)

        if !contains(letters, firstLetter) {
            letters.append(firstLetter)
        }
    }

    // Part 2: Iterate over each letter to find words starting with the given letter to build a return array
    for letter in letters {
        var wordsForLetter = [String]()

        for word in words {
            let firstLetter = Character(word.substringToIndex(advance(word.startIndex, 1)).uppercaseString)

            if firstLetter == letter {
                wordsForLetter.append(word)
            }
        }

        result.append((letter, wordsForLetter))
    }

    return result // return [Entry]
}