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

//    /* Determine if player can move to a particular location on board (i.e. an Empty cell)
//    */
//    func isValidMove(location: BoardLocation) -> Bool {
//        return self[location] == BoardCellState.Empty
//    }

    /* Check condition that cell at given location is empty. Check additionally using the MoveDirections.directions array to iterate over all possible directions (until find one and return true) whereby this move could surround one or more opponent pieces
    */
    func isValidMove(location: BoardLocation) -> Bool {
        return isValidMove(location, toState: nextMove)
    }

    private func isValidMove(location: BoardLocation, toState: BoardCellState) -> Bool {
        // Check if the cell is empty
        if self[location] != BoardCellState.Empty {
            return false
        }

        // Check if the move surrounds one or more of the opponents pieces
        for direction in MoveDirection.directions {
            if moveSurroundsCounters(location, direction: direction, toState: toState) {
                return true
            }
        }
        return false
    }

    /* Set the cell at given location to current player's color and uses invert() to switch to the other player's turn
    */
    func makeMove(location: BoardLocation) {
        self[location] = nextMove

        // Flip any pieces that are surrounded in any of the eight directions
        for direction in MoveDirection.directions {
            flipOpponentsCounters(location, direction: direction, toState: nextMove)
        }

        nextMove = nextMove.invert()
    }

    /* Check if a move to a specific location on the board will surround one or more of the opponent pieces (i.e. valid move)
    */
    private func moveSurroundsCounters(location: BoardLocation, direction: MoveDirection, toState: BoardCellState) -> Bool {
        var index = 1

        // Advance to next cell
        var currentLocation = direction.move(location)

        while isWithinBounds(currentLocation) {

            let currentState = self[currentLocation]

            if index == 1 {
                // Cell neighbouring must be occupied by piece of opposing colour
                if currentState != toState.invert() {
                    return false
                }
            } else {
                // Valid move if we have reached a cell of the same colour
                if currentState == toState {
                    return true
                }

                // Fail if we have reached an empty cell
                if currentState == BoardCellState.Empty {
                    return false
                }
            }

            index++

            // Advance to next cell
            currentLocation = direction.move(currentLocation)
        }

        return false
    }

    // Flip pieces surrounded by pieces of the opposite colour
    private func flipOpponentsCounters(location: BoardLocation, direction: MoveDirection, toState: BoardCellState) {

        // Check whether valid move
        if !moveSurroundsCounters(location, direction: direction, toState: toState) {
            return
        }

        let opponentsState = toState.invert()
        var currentState = BoardCellState.Empty
        var currentLocation = location

        /* Flip opponent pieces until edge of board reached or until a piece with the current state is reached
        */
        repeat {
            currentLocation = direction.move(currentLocation)
            currentState = self[currentLocation]
            self[currentLocation] = toState
        } while (isWithinBounds(currentLocation) && currentState == opponentsState)
    }

}
