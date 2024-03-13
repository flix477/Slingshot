extension Bool: Semigroup {
    public static func <> (lhs: Bool, rhs: Bool) -> Bool {
        lhs || rhs
    }
}
