//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-03.
//

import Foundation

extension Either: Sequence {
    public struct RightIterator: IteratorProtocol {
        var value: Either<L, R>?
        
        public mutating func next() -> R? {
            switch value {
            case .right(let value):
                self.value = nil
                return value
            default:
                return nil
            }
        }
    }
    
    public func makeIterator() -> RightIterator {
        RightIterator(value: self)
    }
}
