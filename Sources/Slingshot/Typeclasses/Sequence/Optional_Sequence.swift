//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-02.
//

import Foundation

extension Optional: Sequence {
    public struct OptionalIterator: IteratorProtocol {
        var value: Wrapped?
        
        public mutating func next() -> Wrapped? {
            switch value {
            case .some(let value):
                self.value = nil
                return value
            default:
                return nil
            }
        }
    }
    
    public func makeIterator() -> OptionalIterator {
        OptionalIterator(value: self)
    }
}
