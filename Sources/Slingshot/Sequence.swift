public protocol OptionalProtocol {
    associatedtype Wrapped
    var value: Wrapped? { get }
}

extension Optional: OptionalProtocol {
    public var value: Wrapped? { self }
}

public extension Sequence {
    func compactCast<T>(as type: T.Type) -> [T] {
        compactMap { $0 as? T }
    }
    
    func max<T>(by keyPath: KeyPath<Element, T>) -> Element? where T: Comparable {
        self.max(by: { $0[keyPath: keyPath] < $1[keyPath: keyPath] })
    }
    
    func min<T>(by keyPath: KeyPath<Element, T>) -> Element? where T: Comparable {
        self.min(by: { $0[keyPath: keyPath] < $1[keyPath: keyPath] })
    }
}

public extension Sequence where Element: OptionalProtocol {
    var compacted: [Element.Wrapped] {
        compactMap(\.value)
    }
}

public struct PrefixedSequence<Prefix, Tail>: Sequence
where Prefix: Sequence, Tail: Sequence, Prefix.Element == Tail.Element {
    let prefix: Prefix
    let tail: Tail
    
    public struct PrefixIterator: IteratorProtocol {
        private var prefix: Prefix.Iterator
        private var tail: Tail.Iterator
        
        init(prefix: Prefix, tail: Tail) {
            self.prefix = prefix.makeIterator()
            self.tail = tail.makeIterator()
        }
        
        public mutating func next() -> Tail.Element? {
            prefix.next() ?? tail.next()
        }
    }
    
    public func makeIterator() -> PrefixIterator {
        .init(prefix: prefix, tail: tail)
    }
}

public extension Sequence {
    func prefixed<Head>(by head: Head) -> PrefixedSequence<Head, Self>
    where Head: Sequence, Head.Element == Element {
        .init(prefix: head, tail: self)
    }
}
