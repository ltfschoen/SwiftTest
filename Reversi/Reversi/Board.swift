//
//  Board.swift
//  Reversi
//
//  Created by LS on 2/10/2015.
//  Copyright © 2015 LS. All rights reserved.
//

import Foundation

/* Model representing the board is defined using a Class that contains a constant array of cells and board size.
*/

class Board {
    private var cells: [BoardCellState]
    let boardSize = 8

    init () {
        /* Create array of cells and populate each cell with the BoardCellState.Empty value
        */
        cells = Array(count: boardSize * boardSize,
                      repeatedValue: BoardCellState.Empty)
    }

    subscript(row: Int, column: Int) -> BoardCellState {
        get {
            return self[BoardLocation(row: row, column: column)]
        }
        set {
            self[BoardLocation(row: row, column: column)] = newValue
        }
    }

    /* Expose a Subscript Method as an API to Get and Set the value of each cell
    */
    subscript(location: BoardLocation) -> BoardCellState {
        get {
            // Terminate app if this condition fails
            assert(isWithinBounds(location), "row or column index out of bounds")

            return cells[location.row * boardSize + location.column]
        }
        set {
            // Terminate app if this condition fails
            assert(isWithinBounds(location), "row or column index out of bounds")

            /* Swift uses a 1D array to store cells (performance improvement over using a 2D array)
            */
            cells[location.row * boardSize + location.column] = newValue
        }
    }

    // Check validity of the row and column for a board location
    func isWithinBounds(location: BoardLocation) -> Bool {
        return location.row >= 0 && location.row < boardSize && location.column >= 0 && location.column < boardSize
    }
}