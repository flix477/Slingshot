//
//  MaybeTest.swift
//  fio
//
//  Created by Felix Leveille on 2021-07-05.
//

import XCTest
@testable import Slingshot

let zero: Int? = .zero

class OptionalTest: XCTestCase {
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

    func testFilterable() throws {
        XCTAssertEqual(zero.filter { $0 == 1 }, zero)
        XCTAssertEqual(Optional.pure(1).filter { $0 == 1 }, Optional.pure(1))
    }
}
