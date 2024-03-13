import Foundation
import Quick
import Nimble
@testable import Slingshot

class Array_TraversableTest: QuickSpec {
    override func spec() {
        describe("Array Traversable") {
            context("sequenced ([T?])") {
                it("returns some empty array when the array is empty") {
                    expect(Array<Int?>.zero.sequenced).to(equal([]))
                }
                
                it("returns none when the array contains a none value") {
                    expect([0, nil].sequenced).to(beNil())
                    expect([Optional<Int>.none].sequenced).to(beNil())
                    expect([nil, 0].sequenced).to(beNil())
                }
                
                it("returns some array when the array contains a no none values") {
                    expect([Optional.some(0), 1].sequenced).to(equal([0, 1]))
                    expect([Optional.some(0)].sequenced).to(equal([0]))
                    expect([Optional.some(Optional.some(0))].sequenced).to(equal([Optional.some(0)]))
                }
            }
        }
    }
}
