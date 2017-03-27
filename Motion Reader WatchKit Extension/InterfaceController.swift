//
//  InterfaceController.swift
//  Motion Reader WatchKit Extension
//
//  Created by Pramod Kotipalli on 3/26/17.
//  Copyright © 2017 Pramod Kotipalli. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    // Accelerometer labels
    @IBOutlet var accelerometerXLabel: WKInterfaceLabel!
    @IBOutlet var accelerometerYLabel: WKInterfaceLabel!
    @IBOutlet var accelerometerZLabel: WKInterfaceLabel!
    
    // Gyroscope labels
    @IBOutlet var gyroscopeXLabel: WKInterfaceLabel!
    @IBOutlet var gyroscopeYLabel: WKInterfaceLabel!
    @IBOutlet var gyroscopeZLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
