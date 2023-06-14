//
//  SequenceBuilder.swift
//  
//
//  Created by Felix Leveille on 2022-11-25.
//

import Foundation


@resultBuilder
public struct SequenceBuilder<Container> where Container: Sequence & Monoid & Pure, Container.PureA == Container.Element {
    public static func buildPartialBlock<V>(first content: V) -> Container where V: Sequence, V.Element == Container.Element {
        Container.fromSequence(content)
    }
    
    public static func buildPartialBlock<V>(accumulated: Container, next: V) -> Container where V: Sequence, V.Element == Container.Element {
        accumulated <> Container.fromSequence(next)
    }
}
