//
//  QuizzTableViewCell.swift
//  Quizzlet
//
//  Created by Zeljko halle on 27/04/2019.
//  Copyright © 2019 Zeljko halle. All rights reserved.
//

import UIKit
import PureLayout

class QuizzTableViewCell: UITableViewCell {
    
    let imgView: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 10, y: 10, width: 80, height: 80))
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .white
        image.layer.borderWidth = 1.0
        image.layer.borderColor = UIColor.lightGray.cgColor
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.autoSetDimensions(to: CGSize(width: 250, height: 40))
        title.adjustsFontSizeToFitWidth = true
        title.numberOfLines = 0
        title.font = UIFont.boldSystemFont(ofSize: 16)
        return title
    }()
    
    let descriptionLabel: UILabel = {
        let description = UILabel(frame: CGRect(x: 90, y: 40, width: 200, height: 40))
        description.adjustsFontSizeToFitWidth = true
        description.numberOfLines = 0
        description.font = UIFont.systemFont(ofSize: 14)
        return description
    }()
    
    let difficultyLevel: UILabel = {
        let difficulty = UILabel()
        difficulty.textColor = .blue
        difficulty.text = "***"
        difficulty.sizeToFit()
        
        return difficulty
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(imgView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(difficultyLevel)
        
        difficultyLevel.frame.origin.x = descriptionLabel.frame.maxX + 50
        difficultyLevel.frame.origin.y = descriptionLabel.frame.minY
        
        titleLabel.leftAnchor.constraint(equalTo: imgView.rightAnchor, constant: 8).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: 10).isActive = true
        descriptionLabel.frame.origin.x = imgView.frame.origin.x + imgView.frame.width + 8
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
