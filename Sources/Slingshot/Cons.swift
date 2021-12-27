//
//  File.swift
//  
//
//  Created by Felix Leveille on 2021-06-23.
//

import Foundation

indirect enum Cons<Value> {
    case some(Value, Cons<Value>)
    case none
}

extension Cons {
    public static func from(_ array: [Value]) -> Cons<Value> {
        return from(array[...])
    }

    public static func from(_ slice: ArraySlice<Value>) -> Cons<Value> {
        switch slice.first {
        case .some(let x):
            return .some(x, from(slice[1...]))
        case .none:
            return .zero
        }
    }

    public var head: Value? {
        switch self {
        case .some(let head, _):
            return .pure(head)
        case .none:
            return .zero
        }
    }

    public var tail: Cons<Value> {
        switch self {
        case .some(_, let tail):
            return tail
        case .none:
            return .zero
        }
    }

    public func item(_ index: Int) -> Value? {
        switch self {
        case .some(let head, let tail):
            return index == 0 ? .pure(head) : tail.item(index - 1)
        case .none:
            return .zero
        }
    }

    public var array: [Value] {
        switch self {
        case .some(let head, let tail):
            return [head] + tail.array
        case .none:
            return []
        }
    }
}

extension Cons: Zero {
    static var zero: Cons { return .none }
}

extension Cons: Alternative {
    func alt(_ x: Cons<Value>) -> Cons<Value> {
        switch self {
        case .some: return self
        case .none: return x
        }
    }
}

extension Cons: Applicative {
    typealias ApplicativeA = Value

    static func pure(_ x: Value) -> Cons<Value> {
        return .some(x, .zero)
    }

    static func ap<O>(lhs: Cons<(Value) -> O>, rhs: Cons<Value>) -> Cons<O> {
        switch (lhs, rhs) {
        case (.some(let f, let fs), .some(let x, let xs)):
            return .pure(f(x)) <> ap(lhs: fs, rhs: xs)
        default:
            return .none
        }
    }
}

extension Cons: Functor {
    typealias FunctorValue = Value

    func map<C>(_ transform: @escaping (Value) -> C) -> Cons<C> {
        switch self {
        case .some(let head, let tail):
            return .some(transform(head), tail.map(transform))
        case .none:
            return .zero
        }
    }

    static func !> <C>(lhs: Self, transform: @escaping (Value) -> C) -> Cons<C> {
        lhs.map(transform)
    }
}

extension Cons: Monad {
    typealias MonadA = Value

    func flatMap<C>(_ transform: @escaping (Value) -> Cons<C>) -> Cons<C> {
        switch self {
        case .some(let head, let tail):
            let xs = transform(head)
            return xs <> tail.flatMap(transform)
        case .none:
            return .zero
        }
    }

    static func |>> <C>(lhs: Self, rhs: @escaping (Value) -> Cons<C>) -> Cons<C> {
        return lhs.flatMap(rhs)
    }
}

extension Cons: Foldable {
    typealias FoldableA = Value

    func fold<T>(initial: T, folder: @escaping (T, Value) -> T) -> T {
        switch self {
        case .some(let head, let tail):
            let x = folder(initial, head)
            return tail.fold(initial: x, folder: folder)
        case .none:
            return initial
        }
    }
}

extension Cons: Semigroup {
    static func <> (lhs: Cons<Value>, rhs: Cons<Value>) -> Cons<Value> {
        switch lhs {
        case .some(let head, let tail):
            return .some(head, tail <> rhs)
        case .none:
            return rhs
        }
    }
}

extension Cons: Filterable {}
