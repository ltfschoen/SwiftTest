//
//  ViewController.swift
//  PocoTips
//
//  Created by LS on 13/10/2015.
//  Copyright © 2015 LS. All rights reserved.
//

import UIKit
import SceneKit

class ViewController: UIViewController {

    @IBOutlet weak var scnView: SCNView!

    @IBOutlet weak var scnLabel: UILabel!

    // MARK: Custom Camera

    // Geometry (single node to manage multiple complex models)
    var geometryNode: SCNNode = SCNNode()

    // Gestures (modify y-axis rotation of geometryNode)
    var currentAngle: Float = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)

        sceneSetup()

        scnLabel.text = "Rooms\n"
        geometryNode = Rooms.allRooms()
        scnView.scene!.rootNode.addChildNode(geometryNode)
    }

    // MARK: Scene
    func sceneSetup() {
        let scene = SCNScene()

        // Add ambient lighting (constant intensity from all directions with 30% white colour
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLightTypeAmbient
        ambientLightNode.light!.color = UIColor(white: 0.3, alpha: 1.0)
        scene.rootNode.addChildNode(ambientLightNode)

        // Add point lighting (alternatives are Directional and Spot lighting types)
        let omniLightNode = SCNNode()
        omniLightNode.light = SCNLight()
        omniLightNode.light!.type = SCNLightTypeOmni
        omniLightNode.light!.color = UIColor(white: 0.75, alpha: 1.0)
        omniLightNode.position = SCNVector3Make(0, 50, 50) // Positioned above and infront
        scene.rootNode.addChildNode(omniLightNode)

        // Add default camera (non-Customisable)
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.camera?.usesOrthographicProjection = false // Default is Perspective projection
        cameraNode.camera?.orthographicScale = 0.8
        cameraNode.position = SCNVector3Make(1, 2, 15) // Positioned infront
        scene.rootNode.addChildNode(cameraNode)

//        // Initial Box Object
//        let boxGeometry = SCNBox(width: 10.0,
//            height: 10.0,
//            length: 10.0,
//            chamferRadius: 1.0)
//        let boxNode = SCNNode(geometry: boxGeometry)
//        scene.rootNode.addChildNode(boxNode)
//        geometryNode = boxNode

        let panRecognizer = UIPanGestureRecognizer(target: self, action: "panGesture:")

        scnView.addGestureRecognizer(panRecognizer)

        scnView.scene = scene

        // Enable default lighting (not required when ambient and point lighting already setup)
//        scnView.autoenablesDefaultLighting = true

        // Enable camera controls
//        scnView.allowsCameraControl = true
    }

    /* Pen Gesture detection in scnView calls this function to transform the gesture from its x-axis translation into a y-axis roatation of the geometry node (1 px = 1 degree)
    */

    func panGesture(sender: UIPanGestureRecognizer) {

        let translation = sender.translationInView(sender.view!)

        var newAngle = (Float)(translation.x)*(Float)(M_PI)/180.0
        
        newAngle += currentAngle

        /* Modify transform Property by creating a new rotation matrix (expandably to include translation and scale)
        */
        geometryNode.transform = SCNMatrix4MakeRotation(newAngle, 0, 1, 0)

        if(sender.state == UIGestureRecognizerState.Ended) {
            currentAngle = newAngle
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

