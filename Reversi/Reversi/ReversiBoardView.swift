//
//  ReversiBoardView.swift
//  Reversi
//
//  Created by LS on 7/10/2015.
//  Copyright © 2015 LS. All rights reserved.
//

import Foundation
import UIKit

// Subclass of UIView to Build the Board
class ReversiBoardView: UIView {
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(frame: CGRect, board: ReversiBoard) {

        // Initialise and return view object with specified rectangle
        super.init(frame: frame)

        /* Compute width and height of each board cell square using size of board in relation to quantity of cells
        */
        let rowHeight = frame.size.height / CGFloat(board.boardSize)
        let columnWidth = frame.size.height / CGFloat(board.boardSize)

        /* Leverage cellVisitor Fuction to visit and create a BoardSquare instance for each cell location
        */
        board.cellVisitor { (location: BoardLocation) in
            let left = CGFloat(location.column) * columnWidth
            let top = CGFloat(location.row) * rowHeight
            let squareFrame = CGRect(x: left,
                                     y: top,
                                     width: columnWidth,
                                     height: rowHeight)
            let square = BoardSquare(frame: squareFrame, board: board, location: location) // UIView
            self.addSubview(square)
        }

    }
}