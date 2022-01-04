//
//  File.swift
//  
//
//  Created by Felix Leveille on 2021-06-22.
//

import Foundation

protocol TaskProtocol {
    associatedtype Value

    var task: Task<Value> { get }
}

class Task<Value> {
    typealias TaskFn = (@escaping (Value) -> ()) -> ()

    fileprivate let _f: TaskFn

    init(_ f: @escaping TaskFn) {
        self._f = f
    }

    func onCompletion(_ handler: @escaping (Value) -> ()) {
        _f(handler)
    }

    func inspect(_ fn: @escaping (Value) -> ()) -> Task<Value> {
        Task<Value> { handler in
            self.onCompletion { data in
                fn(data)
                handler(data)
            }
        }
    }
}

extension Task: TaskProtocol {
    var task: Task<Value> { self }
}

extension DispatchQueue {
    func run<Value>(_ task: Task<Value>, completion: ((Value) -> Void)? = nil) {
        self.async {
            task.onCompletion { x in completion?(x) }
        }
    }
}
