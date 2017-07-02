//
//  Bar.swift
//  PaperAR
//
//  Created by Jovin Cronin-Wilesmith on 7/1/17.
//  Copyright © 2017 Jovin Cronin-Wilesmith. All rights reserved.
//

import UIKit
import SceneKit


class Bar: SCNNode {
    init(height: CGFloat) {
        super.init()
        
        let box = SCNBox(width: 0.1, height: height, length: 0.1, chamferRadius: 0)
        
        self.geometry = box
        let shape = SCNPhysicsShape(geometry: box, options: nil)
        
        self.physicsBody = SCNPhysicsBody(type: .static, shape: shape)
        self.physicsBody?.isAffectedByGravity = false
        
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "light_blue")
        self.geometry?.materials  = [material, material, material, material, material, material]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
