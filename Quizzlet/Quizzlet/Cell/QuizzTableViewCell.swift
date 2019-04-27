//
//  QuizzTableViewCell.swift
//  Quizzlet
//
//  Created by Zeljko halle on 27/04/2019.
//  Copyright © 2019 Zeljko halle. All rights reserved.
//

import UIKit

class QuizzTableViewCell: UITableViewCell {
    
    let cntntView = UIView()
    
    let imgView: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 20, y: 20, width: 0, height: 0))
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: 100).isActive = true
        image.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        return image
    }()
    
    let titleLabel: UILabel = {
        let title = UILabel(frame: CGRect(x: 90, y: 20, width: 100, height: 30))
        title.adjustsFontSizeToFitWidth = true
        title.numberOfLines = 0
        title.font = UIFont.boldSystemFont(ofSize: 16)
        return title
    }()
    
    let descriptionLabel: UILabel = {
        let description = UILabel(frame: CGRect(x: 90, y: 40, width: 100, height: 30))
        description.adjustsFontSizeToFitWidth = true
        description.numberOfLines = 0
        description.font = UIFont.systemFont(ofSize: 12)
        return description
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(imgView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
