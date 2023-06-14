//
//  File.swift
//  
//
//  Created by Felix Leveille on 2023-05-31.
//

import Foundation
import Quick
import Nimble
@testable import Slingshot

class UnsignedInteger_SequenceTest: QuickSpec {
    override func spec() {
        describe("UnsignedInteger Sequence") {
            context("sequence") {
                it("acts as a range from 0 to the specified number") {
                    expect(UInt(3).map(identity)).to(equal([0, 1, 2]))
                }

                it("returns an empty array when the number is 0") {
                    expect(UInt(0).map(identity)).to(equal([]))
                }
            }
        }
    }
}
