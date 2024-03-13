public extension Result {
    static func map<U>(_ transform: @escaping (Success) -> U) -> (Result<Success, Failure>) -> Result<U, Failure> {
        flip(Result<Success, Failure>.map)(transform)
    }
    
    func replace<C>(with x: C) -> Result<C, Failure> {
        map(constant(x))
    }
    
    static func replace<C>(with x: C) -> (Result<Success, Failure>) -> Result<C, Failure> {
        flip(Result<Success, Failure>.replace(with:))(x)
    }
}
