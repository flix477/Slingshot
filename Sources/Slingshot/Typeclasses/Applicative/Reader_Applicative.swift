extension Reader: Pure {
    public static func pure(_ x: Result) -> Reader<Dependency, Result> {
        Reader<Dependency, Result> { dep in x }
    }
}

public extension Reader {
    static func ap<O>(_ function: Reader<Dependency, (Result) -> O>) -> (Reader<Dependency, Result>) -> Reader<Dependency, O> {
        { input in
            function.flatMap { f in input.map(f) }
        }
    }

    func apLeft<O>(rhs: Reader<Dependency, O>) -> Reader<Dependency, Result> {
        flatMap { x in
            rhs.map(constant(x))
        }
    }

    func apRight<O>(rhs: Reader<Dependency, O>) -> Reader<Dependency, O> {
        flatMap(constant(rhs))
    }
}
