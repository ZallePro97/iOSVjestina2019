//
//  Question.swift
//  Quizzlet
//
//  Created by Zeljko halle on 03/04/2019.
//  Copyright © 2019 Zeljko halle. All rights reserved.
//

import Foundation

class Question {
    
    var answers: [String] = []
    var correctAnswer: Int?
    var id: Int?
    var question: String?
    
    init(answers: [String], correctAnswer: Int, id: Int, question: String) {
        self.answers = answers
        self.correctAnswer = correctAnswer
        self.id = id
        self.question = question
    }
    
    init?(json: Any) {
        
        if let dict = json as? [String: Any] {
            
            if let answers = dict["answers"] as? [String] {
                self.answers = answers
            }
            
            if let correctAnswer = dict["correct_answer"] as? Int {
                self.correctAnswer = correctAnswer
            }
            
            if let id = dict["id"] as? Int {
                self.id = id
            }
            
            if let question = dict["question"] as? String {
                self.question = question
            }
            
        }
        
    }
    
}
