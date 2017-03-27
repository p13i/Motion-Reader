//
//  InterfaceController.swift
//  Motion Reader WatchKit Extension
//
//  Created by Pramod Kotipalli on 3/26/17.
//  Copyright © 2017 Pramod Kotipalli. All rights reserved.
//

import WatchKit
import Foundation
import CoreMotion


class InterfaceController: WKInterfaceController {

    
    // MARK: CoreMotion
    
    
    // Accelerometer labels
    @IBOutlet var accelerometerXLabel: WKInterfaceLabel!
    @IBOutlet var accelerometerYLabel: WKInterfaceLabel!
    @IBOutlet var accelerometerZLabel: WKInterfaceLabel!
    
    // Gyroscope labels
    @IBOutlet var gyroscopeXLabel: WKInterfaceLabel!
    @IBOutlet var gyroscopeYLabel: WKInterfaceLabel!
    @IBOutlet var gyroscopeZLabel: WKInterfaceLabel!
    
    // CoreMotion motion manager
    let motionManger = CMMotionManager()
    
    func setLabel(label: WKInterfaceLabel, datum: Double) -> Void {
        var datumToWriteToLabel: Double;
        var labelFormat: String;
        var labelTextColor: UIColor;
        
        if datum >= 0 {
            datumToWriteToLabel = datum;
            labelFormat = "+%.6f"
            labelTextColor = UIColor.white;
        } else {
            // Make it positive
            datumToWriteToLabel = -1 * datum;
            labelFormat = "-%.6f"
            labelTextColor = UIColor.gray;
        }
        
        label.setTextColor(labelTextColor)
        label.setText(String(format: labelFormat, datumToWriteToLabel))
    }
    
    
    // MARK: WKInterfaceController
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        motionManger.deviceMotionUpdateInterval = 0.1
        motionManger.startDeviceMotionUpdates(to: OperationQueue.main) { (motionUpdate: CMDeviceMotion?, error: Error?) in
            let gravityData: CMAcceleration = motionUpdate!.gravity
            self.setLabel(label: self.accelerometerXLabel, datum: gravityData.x)
            self.setLabel(label: self.accelerometerYLabel, datum: gravityData.y)
            self.setLabel(label: self.accelerometerZLabel, datum: gravityData.z)
            
            let gyroscopeData: CMAttitude = motionUpdate!.attitude
            self.setLabel(label: self.accelerometerXLabel, datum: gyroscopeData.yaw)
            self.setLabel(label: self.accelerometerYLabel, datum: gyroscopeData.pitch)
            self.setLabel(label: self.accelerometerZLabel, datum: gyroscopeData.roll)
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
