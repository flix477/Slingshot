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
