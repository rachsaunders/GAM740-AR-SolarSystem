//
//  ViewController.swift
//  GAM740-AR-SolarSystem
//
//  Created by Rachel Saunders on 10/11/2020.
//
// Images used from https://www.solarsystemscope.com/textures/ 

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        let sun = createPlanet(radius: 0.25, image: "2k_sun")
        sun.position = SCNVector3(x: 0, y: -0.5, z: -1)
        
        rotateObject(rotation: -0.3, planet: sun, duration: 1)
        
        // Planet Rings and planets
        let mercuryRing = createRings(ringSize: 0.3)
        let mercury = createPlanet(radius: 0.03, image: "mercury")
        mercury.position = SCNVector3(x: 0.3, y: 0, z: 0)
        
        mercuryRing.addChildNode(mercury)
        
        sun.addChildNode(mercuryRing)
        
        
        
        
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        sceneView.scene.rootNode.addChildNode(sun)
        
    }
    
    func createPlanet(radius: Float, image: String) -> SCNNode{
        let planet = SCNSphere(radius: CGFloat(radius))
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "\(image).jpg")
        planet.materials = [material]
        
        let planetNode = SCNNode(geometry: planet)
        
        return planetNode
        
    }
    
    func rotateObject(rotation: Float, planet: SCNNode, duration: Float) {
        let rotation = SCNAction.rotateBy(x: 0, y: CGFloat(rotation), z: 0, duration: TimeInterval(duration))
        
        planet.runAction((SCNAction.repeatForever(rotation)))
    }
    
    func createRings(ringSize: Float) -> SCNNode{
        
        let ring = SCNTorus(ringRadius: CGFloat(ringSize), pipeRadius: 0.002)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.darkGray
        ring.materials = [material]
        
        let ringNode = SCNNode(geometry: ring)
        
        return ringNode
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
