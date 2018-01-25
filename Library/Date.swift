//
//  String.swift
//  Motion Reader
//
//  Created by Pramod Kotipalli on 1/24/18.
//  Copyright © 2018 Pramod Kotipalli. All rights reserved.
//

import Foundation

extension Date {
    func formatted(as format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
}
