public struct UnsignedIntegerRangeIterator<T>: IteratorProtocol
where T: UnsignedInteger {
    public let maxValue: T
    private var value: T = 0
    
    public init(maxValue: T) {
        self.maxValue = maxValue
    }
    
    public mutating func next() -> T? {
        guard value < maxValue else { return nil }
        defer { value += 1 }
        return value
    }
}

extension Sequence where Self: UnsignedInteger {
    public func makeIterator() -> UnsignedIntegerRangeIterator<Self> {
        .init(maxValue: self)
    }
}

extension UInt: Sequence {}
extension UInt8: Sequence {}
extension UInt16: Sequence {}
extension UInt32: Sequence {}
extension UInt64: Sequence {}
