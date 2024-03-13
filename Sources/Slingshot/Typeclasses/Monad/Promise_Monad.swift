public extension Promise {
    func flatMap<C>(_ transform: @escaping (Value) -> Promise<C>) -> Promise<C> {
        Promise<C> { handler in
            self.onCompletion { data in
                let t = transform(data)
                t.onCompletion(handler)
            }
        }
    }
}
