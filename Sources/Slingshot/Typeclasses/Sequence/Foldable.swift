public extension Sequence {
    func reduce<Output: Zero>(_ nextPartialResult: (Output, Element) throws -> Output) rethrows -> Output {
        try reduce(Output.zero, nextPartialResult)
    }

    func reduceIntoZero<Output: Zero>(_ updateAccumulatingResult: (inout Output, Element) throws -> ()) rethrows -> Output {
        try reduce(into: Output.zero, updateAccumulatingResult)
    }

    var asArray: [Element] {
        reduceIntoZero { result, value in
            result.append(value)
        }
    }

    var count: Int {
        reduce { result, _ in result + 1 }
    }
}

public extension Sequence where Self: Monoid & Pure, Element == Self.PureA {
    static func fromSequence<T>(_ sequence: T) -> Self where T: Sequence, T.Element == Element {
        sequence.reduce(Self.zero) { acc, x in
            acc <> .pure(x)
        }
    }
}

public struct ScanSequence<OriginalSequence, Output>: Sequence where OriginalSequence: Sequence {
    private let sequence: OriginalSequence
    private let initialValue: Output
    private let transform: (Output, OriginalSequence.Element) -> Output
    
    init(sequence: OriginalSequence,
         initialValue: Output,
         transform: @escaping (Output, OriginalSequence.Element) -> Output) {
        self.sequence = sequence
        self.initialValue = initialValue
        self.transform = transform
    }
    
    public struct Iterator: IteratorProtocol {
        private var iterator: OriginalSequence.Iterator
        private var lastResult: Output?
        private let transform: (Output, OriginalSequence.Element) -> Output
        
        init(iterator: OriginalSequence.Iterator,
             initialValue: Output,
             transform: @escaping (Output, OriginalSequence.Element) -> Output) {
            self.iterator = iterator
            self.lastResult = initialValue
            self.transform = transform
        }
        
        public mutating func next() -> Output? {
            guard let lastResult else {
                return nil
            }
            
            self.lastResult = iterator.next().map { transform(lastResult, $0) }
            
            return lastResult
        }
    }
    
    public func makeIterator() -> Iterator {
        .init(iterator: sequence.makeIterator(), initialValue: initialValue, transform: transform)
    }
}

public extension Sequence {
    func scan<Output>(_ initialValue: Output,
                      transform: @escaping (Output, Element) -> Output) -> ScanSequence<Self, Output> {
        ScanSequence(sequence: self, initialValue: initialValue, transform: transform)
    }
    
    func scan<Output>(transform: @escaping (Output, Element) -> Output) -> ScanSequence<Self, Output>
    where Output: Zero {
        ScanSequence(sequence: self, initialValue: .zero, transform: transform)
    }
}
