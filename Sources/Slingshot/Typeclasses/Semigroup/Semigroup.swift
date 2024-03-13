precedencegroup SemigroupPrecedence {
    associativity: left
    higherThan: NilCoalescingPrecedence
}

infix operator <>: SemigroupPrecedence

public protocol Semigroup {
    static func <> (lhs: Self, rhs: Self) -> Self
}
