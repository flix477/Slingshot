//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-03.
//

import Foundation

extension NonEmptyArray: Sequence {
    public struct NonEmptyArrayIterator: IteratorProtocol {
        private var count = 0
        let source: NonEmptyArray<Element>

        init(source: NonEmptyArray<Element>) {
            self.source = source
        }

        public mutating func next() -> Element? {
            defer { count += 1 }

            return count == 0
                ? source.first
                : source.rest[optional: count - 1]
        }
    }
    
    public func makeIterator() -> NonEmptyArrayIterator {
        NonEmptyArrayIterator(source: self)
    }
}
