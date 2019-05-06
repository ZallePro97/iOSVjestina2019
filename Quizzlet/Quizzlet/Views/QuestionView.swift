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
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "QuestionView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        questionText.adjustsFontSizeToFitWidth = true
        questionText.font = questionText.font.withSize(16)
        questionText.lineBreakMode = .byWordWrapping
        questionText.numberOfLines = 0
        
        btnA.titleLabel?.adjustsFontSizeToFitWidth = true
        btnA.titleLabel?.font = questionText.font.withSize(16)
        btnA.titleLabel?.lineBreakMode = .byWordWrapping
        btnA.titleLabel?.numberOfLines = 0
        
        btnB.titleLabel?.adjustsFontSizeToFitWidth = true
        btnB.titleLabel?.font = questionText.font.withSize(16)
        btnB.titleLabel?.lineBreakMode = .byWordWrapping
        btnB.titleLabel?.numberOfLines = 0
        
        btnC.titleLabel?.adjustsFontSizeToFitWidth = true
        btnC.titleLabel?.font = questionText.font.withSize(16)
        btnC.titleLabel?.lineBreakMode = .byWordWrapping
        btnC.titleLabel?.numberOfLines = 0
        
        btnD.titleLabel?.adjustsFontSizeToFitWidth = true
        btnD.titleLabel?.font = questionText.font.withSize(14)
        btnD.titleLabel?.lineBreakMode = .byWordWrapping
        btnD.titleLabel?.numberOfLines = 0
        
        addSubview(view)
    }
    

}
