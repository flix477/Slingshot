extension Set: Semigroup {
    public static func <> (lhs: Set<Element>, rhs: Set<Element>) -> Set<Element> {
        lhs.union(rhs)
    }
}
