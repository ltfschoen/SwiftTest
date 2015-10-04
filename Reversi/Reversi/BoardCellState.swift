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
}