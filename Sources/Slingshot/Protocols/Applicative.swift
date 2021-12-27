//
//  File.swift
//  
//
//  Created by Felix Leveille on 2021-06-22.
//

import Foundation

precedencegroup ApplicativePrecedence {
    associativity: left
    higherThan: FunctorPrecedence
}

infix operator <*>: ApplicativePrecedence

protocol Applicative {
    associatedtype ApplicativeA // content
    associatedtype ApplicativeB: Applicative = Self // Self with content

    static func pure<T>(_ x: T) -> ApplicativeB where ApplicativeB.ApplicativeA == T
}
