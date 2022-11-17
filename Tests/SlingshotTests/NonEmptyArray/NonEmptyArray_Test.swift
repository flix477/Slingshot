//
//  File.swift
//  
//
//  Created by Felix Leveille on 2022-09-28.
//

import Foundation
import Quick
import Nimble
@testable import Slingshot

class NonEmptyArray_Test: QuickSpec {
    override func spec() {
        describe("NonEmptyArray") {
            context("init?(array:)") {
                it("returns none on empty array") {
                    expect(NonEmptyArray(array: [])).to(beNil())
                }
                
                it("returns some on array with one item") {
                    let array = NonEmptyArray<Int>(array: [1])
                    expect(array).toNot(beNil())
                    guard let arr = array else { return }
                    
                    expect(arr.first).to(be(1))
                    expect(arr.rest).to(beEmpty())
                }
                
                it("returns some on array with multiple items") {
                    let array = NonEmptyArray(array: [1, 2])
                    expect(array).toNot(beNil())
                    guard let arr = array else { return }
                    
                    expect(arr.first).to(be(1))
                    expect(arr[1]).to(be(2))
                }
            }
            
            context("subscript[index]") {
                it("returns the correct value when within bounds") {
                    let array = [1, 2, 3]
                    let nonEmpty = NonEmptyArray(array: array)
                    expect(nonEmpty).toNot(beNil())
                    guard let nonEmpty = nonEmpty else { return }
                    
                    for i in array.indices {
                        expect(array[i]).to(equal(nonEmpty[i]))
                    }
                }
            }
        }
    }
}
