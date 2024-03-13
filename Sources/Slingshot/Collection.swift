public extension Collection {
    subscript(optional i: Index) -> Iterator.Element? {
        indices.contains(i) ? self[i] : nil
    }
}
