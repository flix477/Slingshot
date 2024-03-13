extension Array: Semigroup {
    public static func <> (lhs: [Element], rhs: [Element]) -> [Element] {
        lhs + rhs
    }
}
