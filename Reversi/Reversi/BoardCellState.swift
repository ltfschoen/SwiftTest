//
//  BoardCellState.swift
//  Reversi
//
//  Created by LS on 2/10/2015.
//  Copyright © 2015 LS. All rights reserved.
//

import Foundation

/* Model representing current State of a cell on the board is defined using an Enumeration. Board has 64 cells coloured either None, Black, or White
*/
enum BoardCellState {
    case Empty, Black, White

    // MARK: Game Logic
    
    // Switch from black to white and vice versa
    func invert() -> BoardCellState {
        if self == Black {
            return White
        } else if self == White {
            return Black
        }
        
        assert(self != Empty, "cannot invert empty state")
        
        return Empty
    }

    // TODO: Convenience Method to swap between player turn
}