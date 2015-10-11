//
//  BoardLocation.swift
//  Reversi
//
//  Created by LS on 2/10/2015.
//  Copyright © 2015 LS. All rights reserved.
//

import Foundation

/* Model representing the location of a cell on the board is defined using a Struct that combines a pair of integers for the row and column into a single type called BoardLocation. Use of a Struct provides benefits of descriptiveness and ability to implement protocols and contain methods
*/
struct BoardLocation {
    let row: Int, column: Int

    init(row: Int, column: Int) {
        self.row = row
        self.column = column
    }
}

/* Public method (in global scope) to provide an Equality Operator and adopt the Equatable Protocol that defines a single function (equals operator ==). It considers two BoardLocation instances equal when having same row and column. Avoids error "Binary operation '==' cannot be applied to two BoardLocation operands"
*/
func == (lhs: BoardLocation, rhs: BoardLocation) -> Bool {
    return lhs.row == rhs.row && lhs.column == rhs.column
}