//
//  File.swift
//  
//
//  Created by Felix Leveille on 2021-09-09.
//

import XCTest
@testable import Slingshot

private struct Password {
    var value: String

    enum ValidationError {
        case tooSimple
        case invalidLength(Int)
    }
}

class ValidationTest: XCTestCase {
    func testApplicative() throws {
        XCTAssertEqual(Optional.pure(0), 0)
    }

    func testZero() throws {
        XCTAssertEqual(zero, .none)
    }

    func testAlternative() throws {
        XCTAssertEqual(zero <||> zero, zero)
        XCTAssertEqual(.pure(2) <||> zero, .pure(2))
        XCTAssertEqual(zero <||> .pure(2), .pure(2))
        XCTAssertEqual(Optional.pure(2) <||> .pure(3), .pure(2))
        XCTAssertEqual(zero <||> .pure(2) <||> .pure(3), .pure(2))
    }

    func testFunctor() throws {
        XCTAssertEqual(zero !> { $0 + 1 }, .zero)
        XCTAssertEqual(.pure(1) !> { $0 + 1 }, .pure(2))
    }

    func testMonad() throws {
        XCTAssertEqual(zero |>> { Optional.pure($0) }, zero)
        XCTAssertEqual(.pure(1) |>> { Optional.pure($0 + 1) }, .pure(2))
        XCTAssertEqual(zero |>> { _ in Optional.zero }, .zero)
    }
}
