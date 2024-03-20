public extension Set {
    func map<T>(_ transform: @escaping (Element) -> T) -> Set<T> {
        .init(MapSequence(sequence: self, transform: transform))
    }
}
