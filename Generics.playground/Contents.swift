import Foundation

struct GenericPrefs<T: Hashable,U>: Sequence {
    typealias Element = T
    struct Iterator : IteratorProtocol {
        mutating func next() -> Element? {
            return nil
        }
    }
    
    func makeIterator() -> GenericPrefs.Iterator {
        return GenericPrefs.Iterator()
    }
}
