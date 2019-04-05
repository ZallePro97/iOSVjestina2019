//
//  Quizz.swift
//  Quizzlet
//
//  Created by Zeljko halle on 03/04/2019.
//  Copyright © 2019 Zeljko halle. All rights reserved.
//

import Foundation
import UIKit

class Quizz {
    
    var category: Category?
    var title: String?
    var description: String?
    var id: Int?
    var image: UIImage?
    var level: Int?
    var questions: [Question] = []
    
    init?(json: Any) {
        
        if let dict = json as? [String: Any] {
            
            if let category = dict["category"] as? String {
                if let cat = Category(rawValue: category) {
                    self.category = cat
                }
            }
            
            if let title = dict["title"] as? String {
                self.title = title
            }
            
            if let description = dict["description"] as? String {
                self.description = description
            }
            
            if let id = dict["id"] as? Int {
                self.id = id
            }
            
            if let level = dict["level"] as? Int {
                self.level = level
            }
            
            if let image = dict["image"] as? UIImage {
                self.image = image
            }
            
            if let QUESTIONS = dict["questions"] as? NSArray {
                
                for question in QUESTIONS {
                    if let newQuestion = Question(json: question) {
                        self.questions.append(newQuestion)
                    }
                }
                
            }
            
            
        }
    }
    
    
}

