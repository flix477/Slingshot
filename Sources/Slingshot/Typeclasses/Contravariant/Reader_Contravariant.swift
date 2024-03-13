public extension Reader {
    func contramap<U>(_ transform: @escaping (U) -> Dependency) -> Reader<U, Result> {
        Reader<U, Result> { dep in
            f(transform(dep))
        }
    }
}
