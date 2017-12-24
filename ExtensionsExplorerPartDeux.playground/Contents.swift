import Foundation

// Now, as of Swift 2, you can add "default vars and funcs" to protocol extensions:
protocol EmojiString {
    var poopEmoji: String { get }
}

extension EmojiString {
    var poopEmoji: String { return "\u{1F4A9}" }
}

class WTFEmoji: EmojiString {
    
}

let someEmoji = WTFEmoji()
let poop = someEmoji.poopEmoji

// Hey! That's pretty cool! But...can't you implement multiple protocols?
// Yup:
protocol SomeOtherEmoji {
    var fireEmoji: String { get }
}

extension SomeOtherEmoji {
    var fireEmoji: String { return "\u{1F525}" }
}

class WTFEmoji2: EmojiString, SomeOtherEmoji {
    
}

let fireAndPoo = WTFEmoji2()

// Notice that neither of the classes above actually implemented any of the protocol methods. They simply used the defaults.
let fire = fireAndPoo.fireEmoji
let poop2 = fireAndPoo.poopEmoji

// Hey! That looks just like the evil multiple inheritance!
// Yup.
protocol FlamingPoo: EmojiString, SomeOtherEmoji {
    var makeMyDay: String { get }
}

extension FlamingPoo {
    var makeMyDay: String { return self.fireEmoji + self.poopEmoji + self.fireEmoji }
}

class NotAGoodDay: FlamingPoo {
    
}

let wtf = NotAGoodDay()

let thisCantEndWell = wtf.makeMyDay

// Can we get "the Diamond of Death" with protocols?
// Let's see:
protocol YetAnotherEmoji {
    var waterEmoji: String { get }
}

extension YetAnotherEmoji {
    var waterEmoji: String { return "\u{1F30A}" }
}

protocol SoggyPoo: YetAnotherEmoji, EmojiString {
    var makeMyDay: String { get }
}

extension SoggyPoo {
    var makeMyDay: String { return self.waterEmoji + self.poopEmoji + self.waterEmoji }
}

//class DiamondsOfPoo: FlamingPoo, SoggyPoo {
//
//}
//
//let diamondsAreAGirlsBestFriend = DiamondsOfPoo()
//
//let thisCantEndWell2 = diamondsAreAGirlsBestFriend.makeMyDay

