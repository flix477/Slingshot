extension Dictionary: Semigroup {
    public static func <> (lhs: Dictionary<Key, Value>, rhs: Dictionary<Key, Value>) -> Dictionary<Key, Value> {
        lhs.merging(rhs) { a, b in b }
    }
}
