public extension Either {
    func flatMap<C>(_ transform: @escaping (R) throws -> Either<L, C>) rethrows -> Either<L, C> {
        switch self {
        case .right(let x):
            return try transform(x)
        case .left(let x):
            return .left(x)
        }
    }
}
