//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-11-29.
//

import Foundation

public protocol Pure {
    associatedtype PureA
    
    static func pure(_ x: PureA) -> Self
}
