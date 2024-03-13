public protocol Alternative {
    func alt(_ x: Self) -> Self
}

public extension Alternative where Self: BoolCoercible {
    func alt(_ x: Self) -> Self {
        return bool ? self : x
    }
}

extension Dictionary: Alternative {}
extension String: Alternative {}
extension Int: Alternative {}
extension Double: Alternative {}
extension Array: Alternative {}
extension Optional: Alternative {}
