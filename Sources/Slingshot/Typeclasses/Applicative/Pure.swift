public protocol Pure {
    associatedtype PureA
    
    static func pure(_ x: PureA) -> Self
}
