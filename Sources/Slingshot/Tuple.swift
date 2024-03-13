import Foundation

public struct Tuple<First, Second> {
    public let first: First
    public let second: Second
    
    public init(_ first: First,_ second: Second) {
        self.first = first
        self.second = second
    }
}

extension Tuple: Equatable where First: Equatable, Second: Equatable {}
extension Tuple: Hashable where First: Hashable, Second: Hashable {}
extension Tuple: Decodable where First: Decodable, Second: Decodable {}
extension Tuple: Encodable where First: Encodable, Second: Encodable {}
