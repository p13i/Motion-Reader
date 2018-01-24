//
//  ViewController.swift
//  Motion Reader
//
//  Created by Pramod Kotipalli on 3/26/17.
//  Copyright © 2017 Pramod Kotipalli. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    
    var wcSession: WCSession?
    var receiveCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        wcSession = WCSession.default()
        wcSession!.delegate = self
        wcSession!.activate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


extension ViewController: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
    }
    
    func session(_ session: WCSession, didReceiveMessageData messageData: Data) {
        self.receiveCount += 1
        self.messageLabel.text = String(self.receiveCount)
    }
}
