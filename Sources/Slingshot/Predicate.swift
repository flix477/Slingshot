public typealias Predicate<T> = (T) -> Bool

public func keypath<T>(_ keypath: KeyPath<T, Bool>) -> Predicate<T> {
    { $0[keyPath: keypath] }
}

public func not<T>(_ predicate: @escaping Predicate<T>) -> Predicate<T> {
    { !predicate($0) }
}

public func && <T>(lhs: @escaping Predicate<T>, rhs: @escaping Predicate<T>) -> Predicate<T> {
    { lhs($0) && rhs($0) }
}

public func || <T>(lhs: @escaping Predicate<T>, rhs: @escaping Predicate<T>) -> Predicate<T> {
    { lhs($0) || rhs($0) }
}
