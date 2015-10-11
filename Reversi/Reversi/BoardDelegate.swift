//
//  BoardDelegate.swift
//  Reversi
//
//  Created by LS on 11/10/2015.
//  Copyright © 2015 LS. All rights reserved.
//

import Foundation

/* Delegation (Publisher/Subscriber) Pattern with exposed property of delegate type to allow Board's 64 associated BoardSquare instances to be able to notify individual views of state changes. Multicasting capabilities are required (to support more than just single Subscriber). Each BoardSquare instance that is associated with a specific location on the board only needs to update its state if the cellStateChanged delegate is invoked with the corresponding location
*/
protocol BoardDelegate {

    // Delegate method implementation
    func cellStateChanged(location: BoardLocation)
}