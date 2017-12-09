//
//  ViewController.swift
//  Reversi
//
//  Created by LS on 2/10/2015.
//  Copyright © 2015 LS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Create ReversiBoard Instance. Set game starting position
    private let board: ReversiBoard

    let boardCellSize = UIScreen.mainScreen().bounds.size.width / 8

    required init?(coder aDecoder: NSCoder) {
        board = ReversiBoard()
        board.setInitialState()

        super.init(coder: aDecoder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.view.addBackground()

        /* Create ReversiBoardView Instance associated with the ReversiBoard Instance that is added to view hierarchy
        */
        let boardWidth = boardCellSize * 8
        let boardHeight = boardCellSize * 8
        let boardFrame = CGRect(x: 0, y: 0, width: boardWidth, height: boardHeight)
        let boardView = ReversiBoardView(frame: boardFrame, board: board)

        view.addSubview(boardView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension UIView {

    func addBackground() {
        // screen width and height:
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, width, height))
        imageViewBackground.image = UIImage(named: "Reversi.png")

        // you can change the content mode:
        imageViewBackground.contentMode = UIViewContentMode.ScaleAspectFit

        print("height of reversi board \(imageViewBackground.bounds.height)")
        
        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground)
    }

}

