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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)

        sceneSetup()
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

        // Add point lighting
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

        let boxGeometry = SCNBox(width: 10.0,
            height: 10.0,
            length: 10.0,
            chamferRadius: 1.0)
        
        let boxNode = SCNNode(geometry: boxGeometry)

        scene.rootNode.addChildNode(boxNode)
        
        scnView.scene = scene

        // Enable default lighting (not required when ambient and point lighting already setup)
//        scnView.autoenablesDefaultLighting = true

        // Enable camera controls
        scnView.allowsCameraControl = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

