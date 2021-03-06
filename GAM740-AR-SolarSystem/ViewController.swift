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

    //MARK:- OUTLETS
    @IBOutlet var sceneView: ARSCNView!
    
    let baseNode = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        
        //MARK:- THE SUN
        let sun = createPlanet(radius: 0.25, image: "2k_sun")
        sun.position = SCNVector3(x: 0, y: 0, z: 0)
        rotateObject(rotation: -0.3, planet: sun, duration: 1)
        
        //MARK:- THE PLANETS RINGS
        
        let mercuryRing = createRings(ringSize: 0.3)
        let venusRing = createRings(ringSize: 0.5)
        let earthRing = createRings(ringSize: 0.7)
        let marsRing = createRings(ringSize: 0.8)
        let jupiterRing = createRings(ringSize: 1)
        let saturnRing = createRings(ringSize: 1.25)
        let uranusRing = createRings(ringSize: 1.5)
        let neptuneRing = createRings(ringSize: 1.7)
        
        
        //MARK: - CREATE PLANETS
        
        let mercury = createPlanet(radius: 0.03, image: "2k_mercury")
        let venus = createPlanet(radius: 0.04, image: "2k_venus")
        let earth = createPlanet(radius: 0.05, image: "2k_earth")
        let mars = createPlanet(radius: 0.03, image: "2k_mars")
        let jupiter = createPlanet(radius: 0.12, image: "2k_jupiter")
        let saturn = createPlanet(radius: 0.09, image: "2k_saturn")
        let uranus = createPlanet(radius: 0.07, image: "2k_uranus")
        let neptune = createPlanet(radius: 0.08, image: "2k_neptune")
        
        //MARK: - VECTOR POSITIONS OF PLANETS
        
        mercury.position = SCNVector3(x: 0.3, y: 0, z: 0)
        venus.position = SCNVector3(x: 0.5, y: 0, z: 0)
        earth.position = SCNVector3(x: 0.7, y: 0, z: 0)
        mars.position = SCNVector3(x: 0.8, y: 0, z: 0)
        jupiter.position = SCNVector3(x: 1, y: 0, z: 0)
        saturn.position = SCNVector3(x: 1.25, y: 0, z: 0)
        uranus.position = SCNVector3(x: 1.5, y: 0, z: 0)
        neptune.position = SCNVector3(x: 1.7, y: 0, z: 0)
        
        
        //MARK:- ROTATION OF PLANETS AND RINGS

        rotateObject(rotation: 0.6, planet: mercury, duration: 0.4)
        rotateObject(rotation: 0.4, planet: venus, duration: 0.4)
        rotateObject(rotation: 0.25, planet: earth, duration: 0.4)
        rotateObject(rotation: 0.2, planet: mars, duration: 0.4)
        rotateObject(rotation: 0.45, planet: jupiter, duration: 0.4)
        rotateObject(rotation: 0.34, planet: saturn, duration: 0.4)
        rotateObject(rotation: 0.25, planet: uranus, duration: 0.4)
        rotateObject(rotation: 0.2, planet: neptune, duration: 0.4)
        
        rotateObject(rotation: 0.6, planet: mercuryRing, duration: 1)
        rotateObject(rotation: 0.4, planet: venusRing, duration: 1)
        rotateObject(rotation: 0.25, planet: earthRing, duration: 1)
        rotateObject(rotation: 0.2, planet: marsRing, duration: 1)
        rotateObject(rotation: 0.45, planet: jupiterRing, duration: 1)
        rotateObject(rotation: 0.34, planet: saturnRing, duration: 1)
        rotateObject(rotation: 0.25, planet: uranusRing, duration: 1)
        rotateObject(rotation: 0.2, planet: neptuneRing, duration: 1)
        
        //MARK:- MOON
        
        let moon = createPlanet(radius: 0.01, image: "2k_moon")
        let moonRing = SCNTorus(ringRadius: 0.08, pipeRadius: 0.000001)
        let moonRingNode = SCNNode(geometry: moonRing)
        moon.position = SCNVector3(x: 0.08, y: 0, z: 0)
        moonRingNode.position = SCNVector3(x: 0, y: 0.02, z: 0)
        moonRingNode.addChildNode(moon)
        
        earth.addChildNode(moonRingNode)
        
        //MARK:- SATURN RINGS(LOOPS)
    
        // NEED A TEXTURE!
//
//        let saturnLoop = SCNBox(width: 0.4, height: 0, length: 0.5, chamferRadius: 0)
//        let material = SCNMaterial()
//        material.diffuse.contents = UIImage(named: "")
//        saturnLoop.materials = [material]
//
//        let loopNode = SCNNode(geometry: saturnLoop)
//        loopNode.rotation = SCNVector4( -0.5, -0.5, 0, 5)
//        loopNode.position = SCNVector3(x: 0, y: 0, z: 0)
//
//        saturn.addChildNode(loopNode)
//
        //MARK:- ADDS THE NODES TO THE SCENE
        
        venusRing.addChildNode(venus)
        mercuryRing.addChildNode(mercury)
        earthRing.addChildNode(earth)
        marsRing.addChildNode(mars)
        jupiterRing.addChildNode(jupiter)
        saturnRing.addChildNode(saturn)
        uranusRing.addChildNode(uranus)
        neptuneRing.addChildNode(neptune)
        
        baseNode.addChildNode(sun)
        baseNode.addChildNode(mercuryRing)
        baseNode.addChildNode(venusRing)
        baseNode.addChildNode(earthRing)
        baseNode.addChildNode(marsRing)
        baseNode.addChildNode(jupiterRing)
        baseNode.addChildNode(saturnRing)
        baseNode.addChildNode(uranusRing)
        baseNode.addChildNode(neptuneRing)
        
        baseNode.position = SCNVector3(x: 0, y: -0.5, z: -1)
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        sceneView.scene.rootNode.addChildNode(baseNode)
        
    }
    
    //MARK:- CREATING THE PLANET
    
    
    func createPlanet(radius: Float, image: String) -> SCNNode{
        let planet = SCNSphere(radius: CGFloat(radius))
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "\(image).jpg")
        planet.materials = [material]
        
        let planetNode = SCNNode(geometry: planet)
        
        return planetNode
        
    }
    
    //MARK:- ROTATING THE PLANETS
    
    func rotateObject(rotation: Float, planet: SCNNode, duration: Float) {
        let rotation = SCNAction.rotateBy(x: 0, y: CGFloat(rotation), z: 0, duration: TimeInterval(duration))
        
        planet.runAction((SCNAction.repeatForever(rotation)))
    }
    
    //MARK:- CREATING THE RINGS AROUND THE SUN FOR THE PLANETS
    
    func createRings(ringSize: Float) -> SCNNode{
        
        let ring = SCNTorus(ringRadius: CGFloat(ringSize), pipeRadius: 0.002)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.darkGray
        ring.materials = [material]
        
        let ringNode = SCNNode(geometry: ring)
        
        return ringNode
        
    }
    
    // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
    
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

    // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
    
    
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
