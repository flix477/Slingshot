public extension Array {
    func map<T>(_ transform: @escaping (Element) -> T) -> Array<T> {
        .init(MapSequence(sequence: self, transform: transform))
    }
}
