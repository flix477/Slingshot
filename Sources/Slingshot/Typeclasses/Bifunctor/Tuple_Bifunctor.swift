import Foundation

public extension Tuple {
    func bimap<C, D>(onLeft: @escaping (First) throws -> C, onRight: @escaping (Second) throws -> D) rethrows -> Tuple<C, D> {
        try .init(onLeft(first), onRight(second))
    }
    
    static func bimap<C, D>(onLeft: @escaping (First) throws -> C, onRight: @escaping (Second) throws -> D) -> (Tuple<First, Second>) throws -> Tuple<C, D> {
        { x in try x.bimap(onLeft: onLeft, onRight: onRight) }
    }
    
    static func bimap<C, D>(onLeft: @escaping (First) -> C, onRight: @escaping (Second) -> D) -> (Tuple<First, Second>) -> Tuple<C, D> {
        { x in x.bimap(onLeft: onLeft, onRight: onRight) }
    }
}
