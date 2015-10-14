//
//  ToiletBowl.swift
//  PocoTips
//
//  Created by LS on 14/10/2015.
//  Copyright © 2015 LS. All rights reserved.
//

import Foundation

import SceneKit

class Rooms {

    /* Class function (aka Type Function) is called directly on the Class rather than a Class Instance. The Objective-C equivalent is represented with a preceding + symbol
    */
    class func toiletBowlRoom() -> SCNGeometry {

        let toiletBowlRoom = SCNSphere(radius: 3.70)

        let imageflagPeru = UIImage(named:"flag_peru")

        toiletBowlRoom.firstMaterial!.diffuse.contents = UIImageJPEGRepresentation(imageflagPeru!, 0.9)

//        toiletBowlRoom.firstMaterial!.diffuse.contents = UIColor.redColor()

        toiletBowlRoom.firstMaterial!.specular.contents =
            UIColor.whiteColor()

        return toiletBowlRoom
    }

    class func allRooms() -> SCNNode {

        let roomsNode = SCNNode()

        let toiletBowlNode = SCNNode(geometry: toiletBowlRoom())
        toiletBowlNode.position = SCNVector3Make(-2, 0, 0)
        roomsNode.addChildNode(toiletBowlNode)

        return roomsNode
    }
}