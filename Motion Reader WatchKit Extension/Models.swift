//
//  Models.swift
//  Motion Reader
//
//  Created by Pramod Kotipalli on 1/24/18.
//  Copyright © 2018 Pramod Kotipalli. All rights reserved.
//

import Foundation
import CoreMotion

public class AccelerometerInstant : Codable {
    let timestamp: Date
    
    let x: Double
    let y: Double
    let z: Double
    
    convenience init(_ cmAcceleration: CMAcceleration) {
        self.init(x: cmAcceleration.x, y: cmAcceleration.y, z: cmAcceleration.z)
    }
    
    init(x: Double, y: Double, z: Double) {
        self.timestamp = Date()
        
        self.x = x
        self.y = y
        self.z = z
    }
}
