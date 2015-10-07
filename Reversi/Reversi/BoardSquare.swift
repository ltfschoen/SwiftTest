//
//  BoardSquare.swift
//  Reversi
//
//  Created by LS on 7/10/2015.
//  Copyright © 2015 LS. All rights reserved.
//

import Foundation
import UIKit

// Subclass of UIView for rendering an individual single board cell
class BoardSquare: UIView {
    private let board: ReversiBoard
    private let location: BoardLocation
    private let blackView: UIImageView // Image View Container
    private let whiteView: UIImageView

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Create required UI elements using various arguments
    init(frame: CGRect, board: ReversiBoard, location: BoardLocation) {
        self.board = board
        self.location = location

        let blackImage = UIImage(named: "ReversiBlackPiece.png")
        blackView = UIImageView(image: blackImage)
        blackView.alpha = 0

        let whiteImage = UIImage(named: "ReversiWhitePiece.png")
        whiteView = UIImageView(image: whiteImage)
        whiteView.alpha = 0

        // Initialise and return view object with specified frame
        super.init(frame: frame)

        backgroundColor = UIColor.clearColor()

        addSubview(blackView)
        addSubview(whiteView)

        update()
    }

    /* Update alpha (visibility) of white and black counter images based on state of cell associated with the instance
    */
    private func update() {
        let state = board[location]
        whiteView.alpha = state == BoardCellState.White ? 1.0 : 0.0
        blackView.alpha = state == BoardCellState.Black ? 1.0 : 0.0
    }
}
