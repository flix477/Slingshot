public struct Reader<Dependency, Result> {
    public let f: (Dependency) -> Result

    public init(_ f: @escaping (Dependency) -> Result) {
        self.f = f
    }

    public func execute(with dependency: Dependency) -> Result {
        f(dependency)
    }
}
