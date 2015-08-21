// Progress: Page 113
//
// Questions:
//
// - Why won't countElements work? Why isn't this provided in the text on page 113?

import Foundation

//func countElements<T: SequenceType>(word: T) -> Int {
func countElements(word: String) -> Int {
    var wordCount: Int
    for char in word {
        if char != nil {
            wordCount++
        } else {
            return wordCount
        }
    }
}

/* Variadic Parameter 'words' becomes Constant Array inside fn body allowing use of For-In to iterate its contents
*/
func longestWord(words: String...) -> String? {
    var currentLongest: String?
    print(currentLongest)
    // Implementation algorithm iterates each word compares w current longest
    for word in words {
        if currentLongest != nil {
            if countElements(word) > countElements(currentLongest!) {
                currentLongest = word
            }
        } else {
            currentLongest = word
        }
    }
    return currentLongest
}

let long = longestWord("dog", "moose", "cheetah")
print(long)
