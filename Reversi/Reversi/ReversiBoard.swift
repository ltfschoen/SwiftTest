//
//  ReversiBoard.swift
//  Reversi
//
//  Created by LS on 7/10/2015.
//  Copyright © 2015 LS. All rights reserved.
//

import Foundation

// Subclass of Board
class ReversiBoard: Board {

    // Initialise ReversiBoard with starting position and score
    private (set) var blackScore = 0, whiteScore = 0

    // Track whose turn it is (default is White piece move first)
    private (set) var nextMove = BoardCellState.White

    func setInitialState() {

        // Clear the board
        clearBoard()

        // Add pieces for starting position
        super[3,3] = .White
        super[4,4] = .White
        super[3,4] = .Black
        super[4,3] = .Black

        // Initialise score
        blackScore = 2
        whiteScore = 2
    }

    // MARK: Game Logic

    /* Determine if player can move to a particular location on board (i.e. an Empty cell)
    */
    func isValidMove(location: BoardLocation) -> Bool {
        return self[location] == BoardCellState.Empty
    }

    /* Set the cell at given location to current player's color and uses invert() to switch to the other player's turn
    */
    func makeMove(location: BoardLocation) {
        self[location] = nextMove
        nextMove = nextMove.invert()
    }
}
