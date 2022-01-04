//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-02.
//

import Foundation

extension Array {
    func traverse<T>(_ transform: @escaping (Element) -> T?) -> [T]? {
        reduce(into: []) { result, value in
            if let value = transform(value) {
                result?.append(value)
            } else {
                result = nil
            }
        }
    }

    func traverse<Failure, Value>(_ transform: @escaping (Element) -> Validation<Failure, Value>) -> Validation<Failure, [Value]> {
        reduce(.success([])) { result, value in
            switch (result, transform(value)) {
            case (.success(let values), .success(let x)):
                return .success(values <> .pure(x))
            case (.success, .failure(let error)), (.failure(let error), .success):
                return .failure(error)
            case (.failure(let errorA), .failure(let errorB)):
                return .failure(errorA <> errorB)
            }
        }
    }

    func traverse<T>(_ transform: @escaping (Element) -> Task<T>) -> Task<[T]> {
        Task<[T]> { handler in
            var completedResults: [Int: T] = [:]

            for (i, input) in enumerated() {
                transform(input).onCompletion { result in
                    completedResults[i] = result

                    if completedResults.count == count {
                        handler(completedResults.sorted(by: { a, b in a.key < b.key }).map(\.value))
                    }
                }
            }
        }
    }

    func traverse<Value, Failure>(_ transform: @escaping (Element) -> Result<Value, Failure>) -> Result<[Value], Failure> {
        reduce(.success([])) { result, value in
            switch (result, transform(value)) {
            case (.failure(let error), _), (_, .failure(let error)):
                return .failure(error)
            case (.success(let values), .success(let x)):
                return .success(values + [x])
            }
        }
    }

    func traverse<L, R>(_ transform: @escaping (Element) -> Either<L, R>) -> Either<L, [R]> {
        reduce(.right([])) { result, value in
            switch (result, transform(value)) {
            case (.left(let error), _), (_, .left(let error)):
                return .left(error)
            case (.right(let values), .right(let x)):
                return .right(values + [x])
            }
        }
    }
}

extension Array where Element: OptionalProtocol {
    var sequenced: [Element.Wrapped]? {
        traverse(\.value)
    }
}

extension Array where Element: ValidationProtocol {
    var sequenced: Validation<Element.Failure, [Element.Value]> {
        traverse(\.validation)
    }
}

extension Array where Element: EitherProtocol {
    var sequenced: Either<Element.L, [Element.R]> {
        traverse(\.either)
    }
}

extension Array where Element: ResultProtocol {
    var sequenced: Result<[Element.Success], Element.Failure> {
        traverse(\.result)
    }
}

extension Array where Element: TaskProtocol {
    var sequenced: Task<[Element.Value]> {
        traverse(\.task)
    }
}