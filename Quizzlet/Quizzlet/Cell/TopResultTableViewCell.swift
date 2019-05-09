//
//  TopResultTableViewCell.swift
//  Quizzlet
//
//  Created by Zeljko halle on 09/05/2019.
//  Copyright © 2019 Zeljko halle. All rights reserved.
//

import UIKit

class TopResultTableViewCell: UITableViewCell {
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.configureForAutoLayout()
        label.text = "Username: "
        label.backgroundColor = .orange
        return label
    }()
    
    lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.configureForAutoLayout()
        label.text = "Score: "
        label.backgroundColor = .green
        return label
    }()
    
    lazy var rankLabel: UILabel = {
        let label = UILabel()
        label.configureForAutoLayout()
        label.backgroundColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(rankLabel)
        rankLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 15)
        rankLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 15)
        
        contentView.addSubview(usernameLabel)
        usernameLabel.autoPinEdge(.left, to: .right, of: rankLabel, withOffset: 10)
        usernameLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 15)

        contentView.addSubview(scoreLabel)
        scoreLabel.autoPinEdge(.left, to: .right, of: rankLabel, withOffset: 10)
        scoreLabel.autoPinEdge(.top, to: .bottom, of: usernameLabel, withOffset: 10)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
