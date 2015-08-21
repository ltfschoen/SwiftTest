import Foundation

// countElements function here

func longestWord(words: String...) -> String? {
    return words.reduce(String?()) {
        (longest, word) in
        longest == nil || countElements(word) > countElements(longest!) ? word : longest
    }
}