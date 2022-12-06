//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-02.
//

import Foundation

extension Promise: Pure {
    public static func pure(_ x: Value) -> Self {
        Promise { handler in handler(x) } as! Self
    }
    
}

public extension Promise {
    static func ap<O>(_ function: Promise<(Value) -> O>) -> (Promise<Value>) -> Promise<O> {
        { input in
            function.flatMap { f in input.map(f) }
        }
    }

    func apLeft<O>(rhs: Promise<O>) -> Promise<Value> {
        flatMap { x in
            rhs.map(constant(x))
        }
    }

    func apRight<O>(rhs: Promise<O>) -> Promise<O> {
        flatMap(constant(rhs))
    }
}
