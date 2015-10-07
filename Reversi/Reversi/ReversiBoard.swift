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
}
