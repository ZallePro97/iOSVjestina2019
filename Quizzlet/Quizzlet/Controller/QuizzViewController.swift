//
//  QuizzViewController.swift
//  Quizzlet
//
//  Created by Zeljko halle on 06/05/2019.
//  Copyright © 2019 Zeljko halle. All rights reserved.
//

import UIKit
import PureLayout

class QuizzViewController: UIViewController {
    
    var quizz: Quizz?
    var text: String?
    
    var label = UILabel.newAutoLayout()
    var image = UIImageView.newAutoLayout()
    var button = UIButton.newAutoLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUI()

        print(quizz?.questions ?? 1)
    }
    
    
    func setUI() {
        
        // Question title label
        
        label.autoSetDimensions(to: CGSize(width: 250, height: 40))
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.text = quizz?.title
        label.numberOfLines = 0
        view.addSubview(label)
        
        label.autoPinEdge(toSuperviewEdge: .top, withInset: (navigationController?.navigationBar.frame.height)! + 20.0)
        label.autoPinEdge(toSuperviewEdge: .trailing, withInset: 15)
        label.autoPinEdge(toSuperviewEdge: .leading, withInset: 15)
        
        // Question picture
        
        image.autoSetDimensions(to: CGSize(width: 120, height: 120))
        image.image = quizz?.image
        image.backgroundColor = .red
        view.addSubview(image)
        
        image.autoPinEdge(.top, to: .bottom, of: label, withOffset: 30)
        image.autoPinEdge(toSuperviewEdge: .trailing, withInset: 50)
        image.autoPinEdge(toSuperviewEdge: .leading, withInset: 50)
        
        // Start quizz button
        
        button.autoSetDimensions(to: CGSize(width: 70, height: 50))
        view.addSubview(button)
        button.backgroundColor = .purple
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.setTitle("Start quizz", for: .normal)
        
        button.autoPinEdge(.top, to: .bottom, of: image, withOffset: 30)
        button.autoPinEdge(toSuperviewEdge: .trailing, withInset: 15)
        button.autoPinEdge(toSuperviewEdge: .leading, withInset: 15)
        
    }

}
