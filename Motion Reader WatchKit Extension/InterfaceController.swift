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
import WatchConnectivity


class InterfaceController: WKInterfaceController {

    @IBAction func transmitButtonPressed() {
        let message = ["Hello": "World"]
        self.wcSession!.sendMessage(message, replyHandler: nil, errorHandler: nil)
    }
    
    var wcSession: WCSession?
    
    // MARK: CoreMotion
    
    
    // Accelerometer labels
    @IBOutlet var accelerometerXLabel: WKInterfaceLabel!
    @IBOutlet var accelerometerYLabel: WKInterfaceLabel!
    @IBOutlet var accelerometerZLabel: WKInterfaceLabel!
    
    // Gyroscope labels
    @IBOutlet var gyroscopeYawLabel: WKInterfaceLabel!
    @IBOutlet var gyroscopePitchLabel: WKInterfaceLabel!
    @IBOutlet var gyroscopeRollLabel: WKInterfaceLabel!
    
    // CoreMotion motion manager
    let motionManger = CMMotionManager()
    
    /**
        Sets the given WKInterfaceLabel to the given numerical value. If `datum` is less than `0`, then the label will show up with in a gray color. Otherwise, the label will be white. Positive values of `datum` will be prefixed with `+`.
     
        - parameter label: The WKInterfaceLabel in the Apple Watch interface to set the value for.
     
        - parameter datum: The value to set the `label` to.

    */
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
    
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        // This the interval in which we are provided motion updates
        motionManger.deviceMotionUpdateInterval = 1.0
        motionManger.startDeviceMotionUpdates(to: OperationQueue.main) { (motionUpdate: CMDeviceMotion?, error: Error?) in
            
            // Set the accelerometer labels
            let gravityData: CMAcceleration = motionUpdate!.gravity
            self.setLabel(label: self.accelerometerXLabel, datum: gravityData.x)
            self.setLabel(label: self.accelerometerYLabel, datum: gravityData.y)
            self.setLabel(label: self.accelerometerZLabel, datum: gravityData.z)
            
            // Send acceleration to iOS device
            let accelerationInstance = AccelerometerInstant(gravityData)
            let instanceJson: Data = JSON.encode(accelerationInstance)!
            self.wcSession!.sendMessageData(instanceJson, replyHandler: nil, errorHandler: nil)
            
            // Set the gyroscope labels
            let gyroscopeData: CMAttitude = motionUpdate!.attitude
            self.setLabel(label: self.gyroscopeYawLabel, datum: gyroscopeData.yaw)
            self.setLabel(label: self.gyroscopePitchLabel, datum: gyroscopeData.pitch)
            self.setLabel(label: self.gyroscopeRollLabel, datum: gyroscopeData.roll)
        }
        
        wcSession = WCSession.default()
        wcSession!.delegate = self
        wcSession?.activate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        
        // Be sure to stop updates after the view is gone
        motionManger.stopDeviceMotionUpdates()
        wcSession = nil
    }

}

extension InterfaceController: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
}
