//
//  File.swift
//  
//
//  Created by Felix Leveille on 2021-08-02.
//

import Foundation

struct NonEmptyCons<Value> {
    let head: Value
    let tail: Cons<Value>
}

extension NonEmptyCons {
    public static func from(_ cons: Cons<Value>) -> NonEmptyCons<Value>? {
        return from(cons.array)
    }

    public static func from(_ array: [Value]) -> NonEmptyCons<Value>? {
        return from(array[...])
    }

    public static func from(_ slice: ArraySlice<Value>) -> NonEmptyCons<Value>? {
        switch slice.first {
        case .some(let x):
            return NonEmptyCons(head: x, tail: Cons.from(slice[1...]))
        case .none:
            return .zero
        }
    }

    public var array: [Value] {
        return [head] + tail.array
    }

    public var cons: Cons<Value> {
        return .pure(head) <> tail
    }
}

extension NonEmptyCons: Applicative {
    typealias ApplicativeA = Value

    static func pure(_ x: Value) -> NonEmptyCons<Value> {
        return NonEmptyCons(head: x, tail: .zero)
    }
}

extension NonEmptyCons: Functor {
    typealias FunctorValue = Value

    func map<C>(_ transform: @escaping (Value) -> C) -> NonEmptyCons<C> {
        return NonEmptyCons<C>(head: transform(head), tail: tail.map(transform))
    }

    static func !> <C>(lhs: Self, transform: @escaping (Value) -> C) -> NonEmptyCons<C> {
        lhs.map(transform)
    }
}

extension NonEmptyCons: Foldable {
    typealias FoldableA = Value

    func fold<T>(initial: T, folder: @escaping (T, Value) -> T) -> T {
        let x = folder(initial, head)
        return tail.fold(initial: x, folder: folder)
    }
}

extension NonEmptyCons: Semigroup {
    static func <> (lhs: NonEmptyCons<Value>, rhs: NonEmptyCons<Value>) -> NonEmptyCons<Value> {
        return NonEmptyCons<Value>(head: lhs.head, tail: lhs.tail <> rhs.cons)
    }
}
