//
//  BoardSquare.swift
//  Reversi
//
//  Created by LS on 7/10/2015.
//  Copyright © 2015 LS. All rights reserved.
//

import Foundation
import UIKit

// Subclass of UIView for rendering an individual single board cell. Conformance to Custom BoardDelegate Protocol
class BoardSquare: UIView, BoardDelegate {
    private let board: ReversiBoard
    private let location: BoardLocation
    private let blackImageView: UIImageView // Image View Container
    private let whiteImageView: UIImageView
    let boardCellSize: CGFloat
    let boardHeightCenter: CGFloat

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Create required UI elements using various arguments
    init(frame: CGRect, board: ReversiBoard, location: BoardLocation) {

        self.board = board
        self.location = location

        self.boardCellSize = CGFloat(UIScreen.mainScreen().bounds.size.width / 8)
        self.boardHeightCenter = CGFloat((UIScreen.mainScreen().bounds.size.height / 8) * 2)

        print("height of screen bounds \(boardHeightCenter)")

        self.blackImageView = UIImageView(frame: CGRectMake(0, self.boardHeightCenter - boardCellSize, boardCellSize, boardCellSize));
        let blackImage = UIImage(named: "ReversiBlackPiece.png")
        blackImageView.image = blackImage
        blackImageView.alpha = 0

        print("height of blackImageView \(blackImageView.bounds.size.height)")

        self.whiteImageView = UIImageView(frame: CGRectMake(0, self.boardHeightCenter - boardCellSize, boardCellSize, boardCellSize));
        let whiteImage = UIImage(named: "ReversiWhitePiece.png")
        whiteImageView.image = whiteImage
        whiteImageView.alpha = 0

        // Initialise and return view object with specified frame
        super.init(frame: frame)

        backgroundColor = UIColor.clearColor()

        addSubview(blackImageView)
        addSubview(whiteImageView)

        update()

        /* Add the BoardSquare class instance as a multicast delegate (since it conforms to BoardDelegate Protocol) so it will be notified when a cell state changes
        */
        board.addDelegate(self)
    }

    /* Update alpha (visibility) of white and black counter images based on state of cell associated with the instance
    */
    private func update() {
        let state = board[location]
        whiteImageView.alpha = state == BoardCellState.White ? 1.0 : 0.0
        blackImageView.alpha = state == BoardCellState.Black ? 1.0 : 0.0
    }

    /* Delegate method implementation to comply with BoardDelegate Protocol to ensure the view is only updated when associated cell state changes
    */
    func cellStateChanged(location: BoardLocation) {
        if self.location == location {
            update()
        }
    }
}
