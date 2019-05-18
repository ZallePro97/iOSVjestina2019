//
//  QuestionViewLayout.swift
//  Quizzlet
//
//  Created by Zeljko halle on 17/05/2019.
//  Copyright © 2019 Zeljko halle. All rights reserved.
//

import UIKit
import PureLayout

class QuestionViewLayout: UIView {

    var shouldSetupConstraints = true
    
    var questionLabel: UILabel!
    
    var btnA: UIButton!
    var btnB: UIButton!
    var btnC: UIButton!
    var btnD: UIButton!
    
    override init(frame: CGRect) {
        if shouldSetupConstraints {
            shouldSetupConstraints = false
        }
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
