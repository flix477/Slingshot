extension Either: Pure {
    public static func pure(_ x: R) -> Either<L, R> {
        .right(x)
    }
}

public extension Either {
    static func ap<O>(_ function: Either<L, (R) -> O>) -> (Self) -> Either<L, O> {
        { input in
            switch (function, input) {
            case (.left(let e), _):
                return .left(e)
            case (.right(let f), let x):
                return x.map(f)
            }
        }
    }

    func apLeft<O>(rhs: Either<L, O>) -> Self {
        Either.ap(rhs.replace(with: identity))(self)
    }

    func apRight<O>(_ rhs: Either<L, O>) -> Either<L, O> {
        Either<L, O>.ap(replace(with: identity))(rhs)
    }
}
