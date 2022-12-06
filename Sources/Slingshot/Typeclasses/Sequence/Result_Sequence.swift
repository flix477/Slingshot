//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-03.
//

import Foundation

extension Result: Sequence {
    public struct SuccessIterator: IteratorProtocol {
        var value: Result<Success, Failure>?
        
        public mutating func next() -> Success? {
            switch value {
            case .success(let value):
                self.value = nil
                return value
            default:
                return nil
            }
        }
    }
    
    public func makeIterator() -> SuccessIterator {
        SuccessIterator(value: self)
    }
}
