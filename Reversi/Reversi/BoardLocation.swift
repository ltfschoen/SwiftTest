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