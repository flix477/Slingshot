public extension Reader {
    func flatMap<C>(_ transform: @escaping (Result) -> Reader<Dependency, C>) -> Reader<Dependency, C> {
        Reader<Dependency, C> { dep in
            transform(f(dep)).f(dep)
        }
    }
}
