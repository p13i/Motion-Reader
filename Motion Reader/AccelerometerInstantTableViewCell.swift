//
//  AccelerometerInstantTableViewCell.swift
//  Motion Reader
//
//  Created by Pramod Kotipalli on 1/24/18.
//  Copyright © 2018 Pramod Kotipalli. All rights reserved.
//

import Foundation
import UIKit

public class AccelerometerInstantTableViewCell : UITableViewCell
{
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var accelerometerXLabel: UILabel!
    @IBOutlet weak var accelerometerYLabel: UILabel!
    @IBOutlet weak var accelerometerZLabel: UILabel!
}
