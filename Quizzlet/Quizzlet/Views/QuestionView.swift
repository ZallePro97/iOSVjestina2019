//
//  QuestionView.swift
//  Quizzlet
//
//  Created by Zeljko halle on 07/04/2019.
//  Copyright © 2019 Zeljko halle. All rights reserved.
//

import UIKit

@IBDesignable class QuestionView: UIView {
    
    var view: UIView!
    
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var btnA: UIButton!
    @IBOutlet weak var btnB: UIButton!
    @IBOutlet weak var btnC: UIButton!
    @IBOutlet weak var btnD: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("calling programatically")
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("calling from nib")
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "QuestionView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        btnA.isEnabled = true
        btnB.isEnabled = true
        btnC.isEnabled = true
        btnD.isEnabled = true
        
        questionText.adjustsFontSizeToFitWidth = true
        questionText.font = questionText.font.withSize(16)
        questionText.lineBreakMode = .byWordWrapping
        questionText.numberOfLines = 0
        
        setButton(button: btnA)
        setButton(button: btnB)
        setButton(button: btnC)
        setButton(button: btnD)
        
        addSubview(view)
    }
    
    func setButton(button: UIButton) {
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.font = questionText.font.withSize(16)
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.numberOfLines = 0
    }
    
}
