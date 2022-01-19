//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-01-19.
//

import Foundation

public struct Reader<Dependency, Result> {
    public let f: (Dependency) -> Result

    public init(_ f: @escaping (Dependency) -> Result) {
        self.f = f
    }

    public func execute(with dependency: Dependency) -> Result {
        f(dependency)
    }
}
