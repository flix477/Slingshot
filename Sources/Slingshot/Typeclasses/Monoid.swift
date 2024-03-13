public protocol Monoid: Semigroup, Zero {}

public extension Monoid {
    static func concat(values: [Self]) -> Self {
        values.reduce { a, b in a <> b }
    }
}

extension Array: Monoid {}
extension Bool: Monoid {}
extension Double: Monoid {}
extension Float: Monoid {}
extension String: Monoid {}
extension Set: Monoid {}
extension Int: Monoid {}

extension Optional: Monoid where Wrapped: Semigroup {}
