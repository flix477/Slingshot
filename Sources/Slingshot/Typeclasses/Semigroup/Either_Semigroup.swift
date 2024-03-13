extension Either: Semigroup where L: Semigroup, R: Semigroup {
    public static func <> (lhs: Either<L, R>, rhs: Either<L, R>) -> Either<L, R> {
        switch (lhs, rhs) {
        case (.left(let a), .left(let b)): return .left(a <> b)
        case (.right(let a), .right(let b)): return .right(a <> b)
        case (.left, _): return lhs
        default: return rhs
        }
    }
}
