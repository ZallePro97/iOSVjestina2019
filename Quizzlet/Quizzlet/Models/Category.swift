//
//  Category.swift
//  Quizzlet
//
//  Created by Zeljko halle on 03/04/2019.
//  Copyright © 2019 Zeljko halle. All rights reserved.
//

import Foundation
import UIKit

enum Category: String {
    case SPORTS
    case SCIENCE
    
    var value: UIColor {
        get {
            switch self {
            case .SPORTS:
                return UIColor.red
            case .SCIENCE:
                return UIColor.blue
            }
        }
    }
    
}
