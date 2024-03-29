public protocol Zero {
    static var zero: Self { get }
}

extension Array: Zero {
    public static var zero: Array { [] }
}

extension Optional: Zero {
    public static var zero: Optional { .none }
}

extension Bool: Zero {
    public static var zero: Bool { false }
}

extension Float: Zero {
    public static var zero: Float { 0 }
}

extension Dictionary: Zero {
    public static var zero: Dictionary { [:] }
}

extension Double: Zero {
    public static var zero: Double { 0.0 }
}

extension String: Zero {
    public static var zero: String { "" }
}

extension Set: Zero {
    public static var zero: Set<Element> { [] }
}

extension Int: Zero {
    public static var zero: Int { 0 }
}

public extension Optional where Wrapped: Zero {
    var valueOrZero: Wrapped {
        self ?? Wrapped.zero
    }
}

extension Tuple: Zero where First: Zero, Second: Zero {
    public static var zero: Tuple<First, Second> {
        .init(.zero, .zero)
    }
}
