//
//  ViewController.swift
//  Quizzlet
//
//  Created by Zeljko halle on 03/04/2019.
//  Copyright © 2019 Zeljko halle. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    var quizzes: [Quizz] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    @IBAction func getQuizzes(_ sender: UIButton) {
        
        let urlString = "https://iosquiz.herokuapp.com/api/quizzes"
        
        let quizzService = QuizzService()
        
            quizzService.fetchQuizzes(urlString: urlString, completion: { (quizzes) in
                
            DispatchQueue.main.async {
                if let quizzes = quizzes {
                    self.quizzes = quizzes
                    print("Kvizovi dohvaceni!")
                }
                    
                if self.quizzes.count == 0 {
                    let alert = UIAlertController(title: "Alert", message: "Cannot connect to server", preferredStyle:UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }

        })
  
    }
    
    
    @IBAction func getFunFact(_ sender: UIButton) {
        
        var counter = 0
        
        for quizz in quizzes {
            
            let nbaQuestions = quizz.questions.filter { (question) -> Bool in
                return (question.question?.contains("NBA"))!
            }
            
            counter += nbaQuestions.count
        }
        
        print("'NBA' is mentioned \(counter) times")
    }
    

}

