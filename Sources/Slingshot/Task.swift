//
//  File.swift
//  
//
//  Created by Felix Leveille on 2021-06-22.
//

import Foundation

class TaskBase<Value> {
    typealias TaskFn = (@escaping (Value) -> ()) -> ()

    fileprivate let _f: TaskFn

    fileprivate init(_ f: @escaping TaskFn) {
        self._f = f
    }

    func onCompletion(_ handler: @escaping (Value) -> ()) {
        _f(handler)
    }

    fileprivate func _inspect(_ fn: @escaping (Value) -> ()) -> TaskBase<Value> {
        return TaskBase<Value> { handler in
            self.onCompletion { data in
                fn(data)
                handler(data)
            }
        }
    }

    fileprivate static func _pure(_ x: Value) -> TaskBase<Value> {
        return TaskBase { handler in handler(x) }
    }

    fileprivate func _map<C>(_ transform: @escaping (Value) -> C) -> TaskBase<C> {
        return TaskBase<C> { handler in
            self.onCompletion { data in
                handler(transform(data))
            }
        }
    }

    fileprivate func _flatMap<C>(_ transform: @escaping (Value) -> TaskBase<C>) -> TaskBase<C> {
        return TaskBase<C> { handler in
            self.onCompletion { data in
                let t = transform(data)
                t.onCompletion(handler)
            }
        }
    }
}


class Task<Value>: TaskBase<Value> {
    override init(_ f: @escaping TaskFn) {
        super.init(f)
    }

    func inspect(_ fn: @escaping (Value) -> ()) -> Task<Value> {
        return from(_inspect(fn))
    }
}

extension Task: Applicative {
    typealias ApplicativeA = Value

    static func pure(_ x: Value) -> Task<Value> {
        return from(._pure(x))
    }

    static func ap<O>(lhs: Task<(Value) -> O>, rhs: Task<Value>) -> Task<O> {
        return lhs.flatMap { f in rhs.map(f) }
    }

    func apLeft<O>(rhs: Task<O>) -> Task<Value> {
        return flatMap { x in
            rhs.map(constant(x))
        }
    }

    func apRight<O>(rhs: Task<O>) -> Task<O> {
        return flatMap(constant(rhs))
    }
}

extension Task: Functor {
    typealias FunctorValue = Value

    func map<C>(_ transform: @escaping (Value) -> C) -> Task<C> {
        return from(self._map(transform))
    }

    static func !> <C>(lhs: Task<Value>, transform: @escaping (Value) -> C) -> Task<C> {
        lhs.map(transform)
    }
}

extension Task: Monad {
    typealias MonadA = Value

    func flatMap<C>(_ transform: @escaping (Value) -> Task<C>) -> Task<C> {
        return from(self._flatMap(transform))
    }

    static func |>> <C>(lhs: Task<Value>, rhs: @escaping (Value) -> Task<C>) -> Task<C> {
        return lhs.flatMap(rhs)
    }
}

private func from<T>(_ t: TaskBase<T>) -> Task<T> {
    return Task(t._f)
}


class TaskEither<L, R>: TaskBase<Either<L, R>> {
    override init(_ f: @escaping TaskFn) {
        super.init(f)
    }

    static func left(_ x: L) -> TaskEither<L, R> {
        return TaskEither { handler in handler(.left(x)) }
    }

    static func right(_ x: R) -> TaskEither<L, R> {
        return TaskEither { handler in handler(.right(x)) }
    }

    func inspect(_ fn: @escaping (Either<L, R>) -> ()) -> TaskEither<L, R> {
        return from(_inspect(fn))
    }

    func onCompletion(onLeft: @escaping (L) -> (), onRight: @escaping (R) -> ()) {
        onCompletion { $0.consume(onLeft: onLeft, onRight: onRight) }
    }
}

extension TaskEither: Applicative {
    typealias ApplicativeA = R

    static func pure(_ x: R) -> TaskEither<L, R> {
        return .right(x)
    }
}

extension TaskEither: Functor {
    typealias FunctorValue = R

    func map<C>(_ transform: @escaping (R) -> C) -> TaskEither<L, C> {
        return from(self._map { x in x.map(transform) })
    }

    static func !> <C>(lhs: TaskEither, transform: @escaping (R) -> C) -> TaskEither<L, C> {
        lhs.map(transform)
    }
}

extension TaskEither: Monad {
    func flatMap<C>(_ binder: @escaping (R) -> TaskEither<L, C>) -> TaskEither<L, C> {
        return from(self._flatMap { either in
            switch either {
            case .right(let x):
                return binder(x)
            case .left(let x):
                return ._pure(.left(x))
            }
        })
    }

    static func |>> <C>(lhs: TaskEither, rhs: @escaping (R) -> TaskEither<L, C>) -> TaskEither<L, C> {
        return lhs.flatMap(rhs)
    }
}

extension TaskEither: Bifunctor {
    typealias BifunctorA = L

    func mapLeft<C>(_ transform: @escaping (L) -> C) -> TaskEither<C, R> {
        return from(self._map { x in x.mapLeft(transform) })
    }

    func bimap<C, D>(onLeft: @escaping (L) -> C, onRight: @escaping (R) -> D) -> TaskEither<C, D> {
        return from(self._map { x in x.bimap(onLeft: onLeft, onRight: onRight) })
    }
}

private func from<L, R>(_ task: TaskBase<Either<L, R>>) -> TaskEither<L, R> {
    return TaskEither<L, R>(task._f)
}

extension DispatchQueue {
    func run<Value>(_ task: Task<Value>, completion: ((Value) -> Void)? = nil) {
        self.async {
            task.onCompletion { x in completion?(x) }
        }
    }

    func run<L, R>(_ task: TaskEither<L, R>, completion: ((Either<L, R>) -> Void)? = nil) {
        self.async {
            task.onCompletion { x in completion?(x) }
        }
    }
    
    func run<L, R>(_ task: TaskEither<L, R>, onLeft: ((L) -> ())? = nil, onRight: ((R) -> ())? = nil) {
        self.async {
            task.onCompletion { x in
                switch x {
                case .left(let l):
                    onLeft?(l)
                case .right(let r):
                    onRight?(r)
                }
            }
        }
    }
}
