public struct MapSequence<Base, Output>: Sequence 
where Base: Sequence {
    let sequence: Base
    let transform: (Base.Element) -> Output
    
    public struct Iterator: IteratorProtocol {
        var iterator: Base.Iterator
        let transform: (Base.Element) -> Output
        
        public mutating func next() -> Output? {
            iterator.next().map(transform)
        }
    }
    
    public func makeIterator() -> Iterator {
        .init(iterator: sequence.makeIterator(), transform: transform)
    }
}

public protocol FromSequence: Sequence {
    init<S>(_ sequence: S) where S: Sequence, S.Element == Element
}

extension Array: FromSequence {}
extension Set: FromSequence {}
extension Dictionary: FromSequence {
    public init<S>(_ sequence: S) where S : Sequence, Element == S.Element {
        self.init(uniqueKeysWithValues: MapSequence(sequence: sequence) { ($0.key, $0.value) })
    }
}
