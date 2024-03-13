public extension Validation {
    func map<C>(_ transform: (Value) throws -> C) rethrows -> Validation<Failure, C> {
        switch self {
        case .success(let x):
            return .success(try transform(x))
        case .failure(let failures):
            return .failure(failures)
        }
    }
    
    static func map<U>(_ transform: @escaping (Value) -> U) -> (Validation<Failure, Value>) -> Validation<Failure, U> {
        { x in x.map(transform) }
    }
    
    static func map<U>(_ transform: @escaping (Value) throws -> U) -> (Validation<Failure, Value>) throws -> Validation<Failure, U> {
        flip(Validation<Failure, Value>.map)(transform)
    }

    func replace<C>(with x: C) -> Validation<Failure, C> {
        map(constant(x))
    }
    
    static func replace<C>(with x: C) -> (Validation<Failure, Value>) -> Validation<Failure, C> {
        flip(Validation<Failure, Value>.replace(with:))(x)
    }
}
