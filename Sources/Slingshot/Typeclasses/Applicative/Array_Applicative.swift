extension Array: Pure {
    public static func pure(_ x: Element) -> [Element] {
        [x]
    }
}

public extension Array {
    static func ap<O>(functions: [(Element) -> O]) -> (Self) -> [O] {
        { inputs in
            functions.flatMap { f in
                inputs.map(f)
            }
        }
    }

    func apLeft<O>(rhs: [O]) -> Self {
        flatMap { rhs.map(constant($0)) }
    }

    func apRight<O>(rhs: [O]) -> [O] {
        flatMap(constant(rhs))
    }
}
