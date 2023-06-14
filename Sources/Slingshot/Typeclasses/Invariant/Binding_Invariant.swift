//
//  Binding_Invariant.swift
//  
//
//  Created by Felix Leveille on 2022-11-16.
//

import Foundation
import SwiftUI

@available(watchOS 6.0, *)
@available(iOS 13.0, *)
@available(macOS 10.15, *)
public extension Binding {
    func invmap<T>(_ transform: @escaping (Value) -> T, _ transformBack: @escaping (T) -> Value) -> Binding<T> {
        .init(get: { transform(self.wrappedValue) },
              set: { value in self.wrappedValue = transformBack(value) })
    }
}
