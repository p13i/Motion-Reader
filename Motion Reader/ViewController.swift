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
    
    @IBOutlet weak var accelerometerDataTableView: UITableView!
    
    @IBOutlet weak var accelerometerInstancesCountLabel: UILabel!
    
    var wcSession: WCSession?
    
    var accelerometerInstances: [AccelerometerInstant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        wcSession = WCSession.default()
        wcSession!.delegate = self
        wcSession!.activate()
        
        accelerometerDataTableView.delegate = self
        accelerometerDataTableView.dataSource = self
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
        let accelerometerInstance = JSON.decode(messageData, into: AccelerometerInstant.self)!
        self.accelerometerInstances.append(accelerometerInstance)
        
        let newIndexPath = IndexPath(row: self.accelerometerInstances.count - 1, section: 0)
        self.accelerometerDataTableView.insertRows(at: [newIndexPath], with: .fade)
        
        self.accelerometerInstancesCountLabel.text = String(self.accelerometerInstances.count)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.accelerometerInstances.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.accelerometerDataTableView.dequeueReusableCell(withIdentifier: "AccelerometerInstantTableViewCell") as! AccelerometerInstantTableViewCell
        
        let instance = accelerometerInstances[indexPath.row]
        cell.timestampLabel.text = instance.timestamp.formatted(as: "hh:mm:ss")
        cell.accelerometerXLabel.text = instance.x.formatted(as: "%.2f")
        cell.accelerometerYLabel.text = instance.y.formatted(as: "%.2f")
        cell.accelerometerZLabel.text = instance.z.formatted(as: "%.2f")
        
        return cell
    }
    
    
}
