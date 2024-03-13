extension Validation: Sequence {
    public struct ValidationIterator: IteratorProtocol {
        var value: Validation<Failure, Value>?
        
        public mutating func next() -> Value? {
            switch value {
            case .success(let value):
                self.value = nil
                return value
            default:
                return nil
            }
        }
    }
    
    public func makeIterator() -> ValidationIterator {
        ValidationIterator(value: self)
    }
}
