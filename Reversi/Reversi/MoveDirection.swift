//
//  MoveDirection.swift
//  Reversi
//
//  Created by LS on 11/10/2015.
//  Copyright © 2015 LS. All rights reserved.
//

import Foundation

/* Generic concept of a move direction that defines directions for eight adjacent squares from a board location.
*/
enum MoveDirection {
    case North, South, East, West,
    NorthEast, NorthWest, SouthEast, SouthWest

    // Calculate new BoardLocation from existing location and current direction
    func move(loc: BoardLocation) -> BoardLocation {
        switch self {
        case .North:
            return BoardLocation(row: loc.row-1, column: loc.column)
        case .South:
            return BoardLocation(row: loc.row+1, column: loc.column)
        case .East:
            return BoardLocation(row: loc.row, column: loc.column-1)
        case .West:
            return BoardLocation(row: loc.row, column: loc.column+1)
        case .NorthEast:
            return BoardLocation(row: loc.row-1, column: loc.column-1)
        case .NorthWest:
            return BoardLocation(row: loc.row-1, column: loc.column+1)
        case .SouthEast:
            return BoardLocation(row: loc.row+1, column: loc.column-1)
        case .SouthWest:
            return BoardLocation(row: loc.row+1, column: loc.column+1)
        }
    }

    /* Directions constant contains all directions to allow Swift to iterate over the values of the Enumeration
    */
    static let directions: [MoveDirection] = [
        .North, .South, .East, .West,
        .NorthEast, .NorthWest, .SouthWest, .SouthEast
    ]
}