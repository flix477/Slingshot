//
//  Result.swift
//  
//
//  Created by Felix Leveille on 2021-12-27.
//

import Foundation

public protocol ResultProtocol {
    associatedtype Failure: Error
    associatedtype Success

    var result: Result<Success, Failure> { get }
}

public extension ResultProtocol {
    var failure: Failure? {
        if case .failure(let error) = result { return error } else { return nil }
    }

    var success: Success? {
        if case .success(let success) = result { return success } else { return nil }
    }
}

public extension Result {
    var either: Either<Failure, Success> {
        switch self {
        case .success(let x): return .right(x)
        case .failure(let error): return .left(error)
        }
    }

    func consume(onSuccess: @escaping (Success) -> (), onFailure: @escaping (Failure) -> ()) {
        switch self {
        case .success(let x): onSuccess(x)
        case .failure(let x): onFailure(x)
        }
    }

    func consume(onSuccess: @escaping (Success) -> (), onFailure: @escaping (Failure) -> ()) -> (Result<Success, Failure>) -> () {
        { x in x.consume(onSuccess: onSuccess, onFailure: onFailure) }
    }
}

extension Result: ResultProtocol {
    public var result: Result<Success, Failure> { self }
}
