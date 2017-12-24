import Foundation

// Now, as of Swift 2, you can add "default vars and funcs" to protocol extensions:
protocol EmojiString {
    var poopEmoji: String { get }
    var waterEmoji: String { get }
    var smileyEmoji: String { get }
}

extension EmojiString {
    var poopEmoji: String { return "\u{1F4A9}" }
    var waterEmoji: String { return "\u{1F30A}" }
    var smileyEmoji: String { return "\u{1F600}" }
}

class StandardEmojiClass: EmojiString {}

let someEmoji = StandardEmojiClass()
let poop = someEmoji.poopEmoji
let water = someEmoji.waterEmoji
let smiley = someEmoji.smileyEmoji

print("\(poop), \(water), \(smiley)")

// Let's specify another protocol, with a new emoji:
protocol EmojiString2 {
    var frownyEmoji: String { get }
}

extension EmojiString2 {
    var frownyEmoji: String { return "\u{2639}" }
}

class FrownyEmojiClass: EmojiString2 {}
let someEmoji2 = FrownyEmojiClass()
let frown = someEmoji2.frownyEmoji

print(frown)

// Now, we follow multiple protocols:
class HybridEmoji: EmojiString, EmojiString2 {}
let someEmoji3 = HybridEmoji()
let poop2 = someEmoji3.poopEmoji
let water2 = someEmoji3.waterEmoji
let smiley2 = someEmoji3.smileyEmoji
let frown2 = someEmoji3.frownyEmoji

print("\(poop2), \(water2), \(smiley2), \(frown2)")

extension HybridEmoji {
    var waterEmoji: String { return "\u{1F6BE}" }
}

// This won't work:
//extension EmojiString {
//    var smileyEmoji: String { return "\u{1F60E}" }
//}

// Let's see if we can create a "diamond of death":

protocol EmojiString3: EmojiString {
    var frownyEmoji: String { get }
}

extension EmojiString3 {
    var frownyEmoji: String { return "\u{1F92F}" }
}

class Emoji2: EmojiString3 {}
let someEmoji4 = Emoji2()
let poop3 = someEmoji4.poopEmoji
let water3 = someEmoji4.waterEmoji
let smiley3 = someEmoji4.smileyEmoji
let frown3 = someEmoji4.frownyEmoji

print("\(poop3), \(water3), \(smiley3), \(frown3)")

// This is a bug. It won't work.
//class DiamondsAreABugsBestFriend: EmojiString2, EmojiString3 {}
// This is also a bug.
//class Emoji3: Emoji2, EmojiString2 {}

