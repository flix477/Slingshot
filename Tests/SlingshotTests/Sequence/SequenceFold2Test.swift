import Foundation
import Quick
import Nimble
@testable import Slingshot

class SequenceFold2Test: QuickSpec {
    override func spec() {
        describe("Sequence fold2") {
            context("when using consumeBoth") {
                it("consumes all elements of both arrays when both are the same length") {
                    let result: [Tuple<Double, String>] = fold2(initial: [],
                                                                left: [1, 2, 3],
                                                                right: ["a", "b", "c"]) { output, left, right in
                        output.append(.init(left, right))
                        return .consumeBoth
                    }
                    
                    expect(result).to(equal([.init(1, "a"), .init(2, "b"), .init(3, "c")]))
                }
                
                it("consumes all elements of the first array and the corresponding items from second array when the first array is shorter") {
                    let result: [Tuple<Double, String>] = fold2(initial: [],
                                                                left: [1, 2],
                                                                right: ["a", "b", "c"]) { output, left, right in
                        output.append(.init(left, right))
                        return .consumeBoth
                    }
                    
                    expect(result).to(equal([.init(1, "a"), .init(2, "b")]))
                }
                
                it("consumes all elements of the second array and the corresponding items from from array when the second array is shorter") {
                    let result: [Tuple<Double, String>] = fold2(initial: [],
                                                                left: [1, 2, 3],
                                                                right: ["a", "b"]) { output, left, right in
                        output.append(.init(left, right))
                        return .consumeBoth
                    }
                    
                    expect(result).to(equal([.init(1, "a"), .init(2, "b")]))
                }
                
                it("consumes nothing when the first array is empty") {
                    let result: [Tuple<Double, String>] = fold2(initial: [],
                                                                left: Array<Double>(),
                                                                right: ["a", "b"]) { output, left, right in
                        output.append(.init(left, right))
                        return .consumeBoth
                    }
                    
                    expect(result).to(beEmpty())
                }
                
                it("consumes nothing when the second array is empty") {
                    let result: [Tuple<Double, String>] = fold2(initial: [],
                                                                left: [1, 2],
                                                                right: Array<String>()) { output, left, right in
                        output.append(.init(left, right))
                        return .consumeBoth
                    }
                    
                    expect(result).to(beEmpty())
                }
                
                it("consumes nothing when both arrays are empty") {
                    let result: [Tuple<Double, String>] = fold2(initial: [],
                                                                left: Array<Double>(),
                                                                right: Array<String>()) { output, left, right in
                        output.append(.init(left, right))
                        return .consumeBoth
                    }
                    
                    expect(result).to(beEmpty())
                }
            }
            
            context("when using consumeLeft") {
                it("consumes all elements of the first array when both are the same length") {
                    let result: [Tuple<Double, String>] = fold2(initial: [],
                                                                left: [1, 2, 3],
                                                                right: ["a", "b", "c"]) { output, left, right in
                        output.append(.init(left, right))
                        return .consumeLeft
                    }
                    
                    expect(result).to(equal([.init(1, "a"), .init(2, "a"), .init(3, "a")]))
                }
                
                it("consumes all elements of the first array when it is longer than the second one") {
                    let result: [Tuple<Double, String>] = fold2(initial: [],
                                                                left: [1, 2, 3],
                                                                right: ["a", "b"]) { output, left, right in
                        output.append(.init(left, right))
                        return .consumeLeft
                    }
                    
                    expect(result).to(equal([.init(1, "a"), .init(2, "a"), .init(3, "a")]))
                }
                
                it("consumes nothing when the second array is empty") {
                    let result: [Tuple<Double, String>] = fold2(initial: [],
                                                                left: [1, 2, 3],
                                                                right: Array<String>()) { output, left, right in
                        output.append(.init(left, right))
                        return .consumeLeft
                    }
                    
                    expect(result).to(beEmpty())
                }
            }
            
            context("when using consumeRight") {
                it("consumes all elements of the second array when both are the same length") {
                    let result: [Tuple<Double, String>] = fold2(initial: [],
                                                                left: [1, 2, 3],
                                                                right: ["a", "b", "c"]) { output, left, right in
                        output.append(.init(left, right))
                        return .consumeRight
                    }
                    
                    expect(result).to(equal([.init(1, "a"), .init(1, "b"), .init(1, "c")]))
                }
                
                it("consumes all elements of the second array when it is longer than the first one") {
                    let result: [Tuple<Double, String>] = fold2(initial: [],
                                                                left: [1, 2],
                                                                right: ["a", "b", "c"]) { output, left, right in
                        output.append(.init(left, right))
                        return .consumeRight
                    }
                    
                    expect(result).to(equal([.init(1, "a"), .init(1, "b"), .init(1, "c")]))
                }
                
                it("consumes nothing when the first array is empty") {
                    let result: [Tuple<Double, String>] = fold2(initial: [],
                                                                left: Array<Double>(),
                                                                right: ["a"]) { output, left, right in
                        output.append(.init(left, right))
                        return .consumeRight
                    }
                    
                    expect(result).to(beEmpty())
                }
            }
        }
    }
}
