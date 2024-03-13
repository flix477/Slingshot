public protocol OptionalProtocol {
    associatedtype Wrapped
    var value: Wrapped? { get }
}

extension Optional: OptionalProtocol {
    public var value: Wrapped? { self }
}

public extension Sequence {
    func compactCast<T>(as type: T.Type) -> [T] {
        compactMap { $0 as? T }
    }
}

public extension Sequence where Element: OptionalProtocol {
    var compacted: [Element.Wrapped] {
        compactMap(\.value)
    }
}
