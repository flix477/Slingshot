extension Dictionary: Pure {
    public static func pure(_ x: Element) -> Dictionary<Key, Value> {
        [x.key: x.value]
    }
}
