//
//  QuestionViewProgrammatically.swift
//  Quizzlet
//
//  Created by Zeljko halle on 08/05/2019.
//  Copyright © 2019 Zeljko halle. All rights reserved.
//

import UIKit
import PureLayout

class QuestionViewProgrammatically: UIView {
    
    var questionText = UILabel.newAutoLayout()
    
    var view = UIView.newAutoLayout()
    
    var btnA: UIButton!
    var btnB: UIButton!
    var btnC: UIButton!
    var btnD: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView() {
        self.backgroundColor = UIColor.blue
    
        questionText = UILabel(frame: CGRect(x: 37, y: 20, width: 269, height: 88))
        questionText.backgroundColor = .purple
        questionText.textColor = .white
        setLabel(label: questionText)
        addSubview(questionText)
        
        btnA = UIButton(frame: CGRect(x: 37, y: 126, width: 116, height: 30))
        btnA.backgroundColor = .purple
        setLabel(label: btnA.titleLabel!)
        addSubview(btnA)
        
        btnB = UIButton(frame: CGRect(x: 190, y: 126, width: 116, height: 30))
        btnB.backgroundColor = .purple
        setLabel(label: btnB.titleLabel!)
        addSubview(btnB)
        
        btnC = UIButton(frame: CGRect(x: 37, y: 200, width: 116, height: 30))
        btnC.backgroundColor = .purple
        setLabel(label: btnC.titleLabel!)
        addSubview(btnC)
        
        btnD = UIButton(frame: CGRect(x: 190, y: 200, width: 116, height: 30))
        btnD.backgroundColor = .purple
        setLabel(label: btnD.titleLabel!)
        addSubview(btnD)
    }
    
    private func setLabel(label: UILabel) {
        label.adjustsFontSizeToFitWidth = true
        label.font = questionText.font.withSize(16)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
    }

}
