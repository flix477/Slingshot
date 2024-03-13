public protocol ValidationProtocol {
    associatedtype Failure
    associatedtype Value

    var validation: Validation<Failure, Value> { get }
}

public enum Validation<Failure, Value> {
    case success(Value)
    case failure([Failure].NonEmpty)
}

public extension Validation {
    static func fail(_ error: Failure) -> Validation<Failure, Value> {
        .failure(.pure(error))
    }

    func fail(_ error: Failure) -> Validation<Failure, Value> {
        let error: [Failure].NonEmpty = .pure(error)
        switch self {
        case .success:
            return .failure(error)
        case .failure(let failures):
            return .failure(failures <> error)
        }
    }

    var either: Either<[Failure].NonEmpty, Value> {
        switch self {
        case .success(let x): return .right(x)
        case .failure(let failures): return .left(failures)
        }
    }

    var failures: [Failure] {
        switch self {
        case .success: return .zero
        case .failure(let xs): return xs.erased
        }
    }

    var value: Value? {
        either.right
    }
}

extension Validation: ValidationProtocol {
    public var validation: Validation<Failure, Value> { self }
}
