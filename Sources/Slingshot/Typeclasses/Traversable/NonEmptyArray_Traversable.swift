//public extension NonEmptyArray {
//    func traverse<T>(_ transform: @escaping (Element) -> T?) -> NonEmptyArray<T>? {
//        guard let initial = transform(first) else { return nil }
//
//        return rest.traverse(transform).map { .init(first: initial, rest: $0) }
//    }
//
//    func traverse<Failure, Value>(_ transform: @escaping (Element) -> Validation<Failure, Value>) -> Validation<Failure, NonEmptyArray<Value>> {
//        switch transform(first) {
//        case .success(let x):
//            return rest.traverse(transform).map { .init(first: x, rest: $0) }
//        case .failure(let xs):
//            return .failure(xs)
//        }
//    }
//
//    func traverse<T>(_ transform: @escaping (Element) -> Promise<T>) -> Promise<NonEmptyArray<T>> {
//        Promise<NonEmptyArray<T>> { handler in
//            asArray.traverse(transform).onCompletion { results in
//                if let results = NonEmptyArray<T>(array: results) {
//                    handler(results)
//                }
//            }
//        }
//    }
//
//    func traverse<Value, Failure>(_ transform: @escaping (Element) -> Result<Value, Failure>) -> Result<NonEmptyArray<Value>, Failure> {
//        switch transform(first) {
//        case .success(let x):
//            return rest.traverse(transform).map { .init(first: x, rest: $0) }
//        case .failure(let xs):
//            return .failure(xs)
//        }
//    }
//
//    func traverse<L, R>(_ transform: @escaping (Element) -> Either<L, R>) -> Either<L, NonEmptyArray<R>> {
//        switch transform(first) {
//        case .right(let x):
//            return rest.traverse(transform).map { .init(first: x, rest: $0) }
//        case .left(let xs):
//            return .left(xs)
//        }
//    }
//}
//
//extension NonEmptyArray where Element: OptionalProtocol {
//    public var sequenced: NonEmptyArray<Element.Wrapped>? {
//        traverse(\.value)
//    }
//}
//
//extension NonEmptyArray where Element: ValidationProtocol {
//    public var sequenced: Validation<Element.Failure, NonEmptyArray<Element.Value>> {
//        traverse(\.validation)
//    }
//}
//
//extension NonEmptyArray where Element: EitherProtocol {
//    public var sequenced: Either<Element.L, NonEmptyArray<Element.R>> {
//        traverse(\.either)
//    }
//}
//
//extension NonEmptyArray where Element: ResultProtocol {
//    public var sequenced: Result<NonEmptyArray<Element.Success>, Element.Failure> {
//        traverse(\.result)
//    }
//}
//
//extension NonEmptyArray where Element: PromiseProtocol {
//    public var sequenced: Promise<NonEmptyArray<Element.Value>> {
//        traverse(\.promise)
//    }
//}
