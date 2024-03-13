extension Optional: Semigroup where Wrapped: Semigroup {
    public static func <> (lhs: Wrapped?, rhs: Wrapped?) -> Wrapped? {
        switch (lhs, rhs) {
        case (.none, let b):
            return b
        case (.some(let a), .some(let b)):
            return a <> b
        case (let a, _):
            return a
        }
    }
}
