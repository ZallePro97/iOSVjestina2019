//
//  QuizzTableViewCell.swift
//  Quizzlet
//
//  Created by Zeljko halle on 27/04/2019.
//  Copyright © 2019 Zeljko halle. All rights reserved.
//

import UIKit

class QuizzTableViewCell: UITableViewCell {
    
    var quizzImage: UIImage?
    var quizzTitle: String?
    var quizzDescription: String?
    
    var quizz: Quizz? {
        
        didSet {
            
            if let quizzImageStringUrl = quizz?.imageStringUrl {
                
                let imageURL = URL(string: quizzImageStringUrl)
                
                if let imageURL = imageURL {
                    if let data = try? Data(contentsOf: imageURL) {
                        if let image = UIImage(data: data) {
                            self.quizzImage? = image
                        }
                    }
                }
                
            }
            
            if let title = quizz?.title {
                self.quizzTitle = title
            }
            
            if let description = quizz?.description {
                self.quizzDescription = description
            }
            
        }
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let imageView = UIImageView(image: self.quizzImage)
        print("postavljam sliku...")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        addSubview(imageView)
        
        let quizzTitleLabel = UILabel()
        quizzTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        quizzTitleLabel.textAlignment = .left
        quizzTitleLabel.text = self.quizzTitle
        print("postavljam naslov...")
        quizzTitleLabel.textColor = .black
        addSubview(quizzTitleLabel)
        
        let quizzDescriptionLabel = UILabel()
        quizzDescriptionLabel.textColor = .black
        quizzDescriptionLabel.text = self.quizzDescription
        print("postavljam opis...")
        quizzDescriptionLabel.font = UIFont.systemFont(ofSize: 16)
        quizzDescriptionLabel.textAlignment = .left
        quizzDescriptionLabel.numberOfLines = 0
        addSubview(quizzDescriptionLabel)
        
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
