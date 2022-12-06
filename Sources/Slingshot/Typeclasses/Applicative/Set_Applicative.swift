//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-11-29.
//

import Foundation

extension Set: Pure {
    public static func pure(_ x: Element) -> Set<Element> {
        [x]
    }
}
