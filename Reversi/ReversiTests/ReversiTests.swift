//
//  ReversiTests.swift
//  ReversiTests
//
//  Created by LS on 2/10/2015.
//  Copyright © 2015 LS. All rights reserved.
//

import XCTest
@testable import Reversi

class ReversiTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

    func test_subscript_setWithValidCoords_cellStateIsChanged() {
        let board = Board()

        // Set the state of a cell on the board
        board[4,5] = BoardCellState.White

        // Get the state of the cell to Verify
        let retrievedState = board[4, 5]
        XCTAssertEqual(BoardCellState.White, retrievedState, "The cell should have been white!");
    }

    func test_clearBoard_cellStateIsChanged() {
        let board = Board()

        board[1,2] = BoardCellState.Black

        // Clear all board cells into the Empty state
        board.clearBoard()

        let retrievedState = board[1,2]
        XCTAssertEqual(BoardCellState.Empty, retrievedState, "The cell should have been cleared!")
    }
    
}
