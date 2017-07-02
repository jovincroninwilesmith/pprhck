//
//  ViewController.swift
//  ARKit
//
//  Created by Jovin Cronin-Wilesmith on 6/30/17.
//  Copyright © 2017 Jovin Cronin-Wilesmith. All rights reserved.
//

import UIKit
import ARKit
import Alamofire
import SwiftyJSON
import AlamofireSwiftyJSON

class ViewController: UIViewController, ARSCNViewDelegate, SCNPhysicsContactDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        sceneView.scene.physicsWorld.contactDelegate = self
        
        self.addNewBar()
        self.getCurrencyValues()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingSessionConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
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
    
    
    func getRemoteData(url: String, completion: @escaping ((_ json: DataResponse<JSON>) -> Void)) {
        Alamofire.request(url).responseSwiftyJSON {
            (response) in
            completion(response)
        }
    }
    
    
    func getCurrencyValues() {
        var values = [String]()
        
        let dGroup = DispatchGroup()
        
        dGroup.enter()
        getRemoteData(url: "https://api.coinmarketcap.com/v1/ticker/bitcoin/") { json in
            values.append(json.value?.array?[0]["price_usd"])
            dGroup.leave()
        }
        
        
        dGroup.enter()
        getRemoteData(url: "https://api.coinmarketcap.com/v1/ticker/ethereum/") { json in
            values.append(json.value?.array?[0]["price_usd"])
            dGroup.leave()
        }
        
        dGroup.enter()
        getRemoteData(url: "https://api.coinmarketcap.com/v1/ticker/ripple/") { json in
            values.append(json.value?.array?[0]["price_usd"])
            dGroup.leave()
        }
        
        dGroup.notify(queue: DispatchQueue.main) {
            print("we are done")
            print(values)
        }
    }
    
    
    
    
    func determineBarHeight(){
        
    }
    
    
    
    func addNewBar() {
        let barNode = Bar(height: 0.2)
        let posX = floatBetween(-0.5, and: 0.5)
        let posY = floatBetween(-0.5, and: 0.5  )
        barNode.position = SCNVector3(posX, posY, -1) // SceneKit/AR coordinates are in meters
        sceneView.scene.rootNode.addChildNode(barNode)
    }
    
    func floatBetween(_ first: Float,  and second: Float) -> Float { // random float between upper and lower bound (inclusive)
        return (Float(arc4random()) / Float(UInt32.max)) * (first - second) + second
    }
    
}




