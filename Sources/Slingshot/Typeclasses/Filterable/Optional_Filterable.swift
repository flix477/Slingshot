public extension Optional {
    func filter(_ shouldKeep: @escaping Predicate<Wrapped>) -> Wrapped? {
        switch self {
        case .some(let x) where shouldKeep(x):
            return .pure(x)
        default:
            return .zero
        }
    }
}
