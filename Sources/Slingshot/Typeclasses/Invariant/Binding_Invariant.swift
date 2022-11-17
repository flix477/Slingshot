//
//  Binding_Invariant.swift
//  
//
//  Created by Felix Leveille on 2022-11-16.
//

import Foundation
import SwiftUI

@available(macOS 10.15, *)
public extension Binding {
    func invmap<T>(_ transform: @escaping (Value) -> T, _ transformBack: @escaping (T) -> Value) -> Binding<T> {
        .init(get: { transform(self.wrappedValue) },
              set: { value in self.wrappedValue = transformBack(value) })
    }
}
