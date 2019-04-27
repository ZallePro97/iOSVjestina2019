//
//  AlertException.swift
//  Quizzlet
//
//  Created by Zeljko halle on 26/04/2019.
//  Copyright © 2019 Zeljko halle. All rights reserved.
//

import Foundation
import UIKit

class AlertException {
    
    static func raiseAlert(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle:UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        
        return alert
    }
    
}
