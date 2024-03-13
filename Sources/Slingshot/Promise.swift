import Foundation

public protocol PromiseProtocol {
    associatedtype Value

    var promise: Promise<Value> { get }
}

public class Promise<Value> {
    public typealias PromiseFn = (@escaping (Value) -> ()) -> ()

    let _f: PromiseFn

    public init(_ f: @escaping PromiseFn) {
        self._f = f
    }

    public func onCompletion(_ handler: @escaping (Value) -> ()) {
        _f(handler)
    }

    public func inspect(_ fn: @escaping (Value) -> ()) -> Promise<Value> {
        Promise<Value> { handler in
            self.onCompletion { data in
                fn(data)
                handler(data)
            }
        }
    }
    
    @available(watchOS 6.0.0, *)
    @available(iOS 13.0.0, *)
    @available(macOS 10.15.0, *)
    var async: Value {
        get async {
            await withCheckedContinuation { continuation in
                onCompletion { x in continuation.resume(with: .success(x)) }
            }
        }
    }
}

extension Promise: PromiseProtocol {
    public var promise: Promise<Value> { self }
}

public extension DispatchQueue {
    func run<Value>(_ promise: Promise<Value>, completion: ((Value) -> Void)? = nil) {
        self.async {
            promise.onCompletion { x in completion?(x) }
        }
    }
}
