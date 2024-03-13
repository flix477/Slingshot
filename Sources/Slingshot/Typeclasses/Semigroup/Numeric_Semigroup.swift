public extension Semigroup where Self: Numeric {
    static func <> (lhs: Self, rhs: Self) -> Self {
        lhs + rhs
    }
}

extension Int: Semigroup {}
extension UInt: Semigroup {}
extension Float: Semigroup {}
extension Double: Semigroup {}
