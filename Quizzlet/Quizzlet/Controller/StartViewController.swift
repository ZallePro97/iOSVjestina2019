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
    
    var question: Question?
    var correctAnswer: String?
    var wantedColor: UIColor?
    
    @IBOutlet weak var funFactLabel: UILabel!
    @IBOutlet weak var quizzTitle: UILabel!
    @IBOutlet weak var quizzImage: UIImageView!
    @IBOutlet weak var questionView: QuestionView!
    
    @IBOutlet weak var getQuestionsBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wantedColor = questionView.btnA.backgroundColor
        
        let getQuestionsButtonTitle = self.getQuestionsBtn.titleLabel
        getQuestionsButtonTitle?.adjustsFontSizeToFitWidth = true
        getQuestionsButtonTitle?.lineBreakMode = .byWordWrapping
        getQuestionsButtonTitle?.numberOfLines = 0
    }
    

    @IBAction func getQuizzes(_ sender: UIButton) {
        
        let quizzService = QuizzService()
        
            quizzService.fetchQuizzes(completion: { (quizzes) in
                
            DispatchQueue.main.async {
                if let quizzes = quizzes {
                    self.quizzes = quizzes
                    
                    var counter = 0
                    
                    for quizz in quizzes {
                        
                        let nbaQuestions = quizz.questions.filter { (question) -> Bool in
                            return (question.question?.contains("NBA"))!
                        }
                        
                        counter += nbaQuestions.count
                    }
                    
                    self.funFactLabel.text = "There are \(counter) questions containing 'NBA'"
                }
                
                //  dohvacanje neuspjesno
                
                if self.quizzes.count == 0 {
                    let alert = AlertException.raiseAlert(message: "Cannot connect to server")
                    self.present(alert, animated: true, completion: nil)
                } else {
                    // dohvacanje uspjesno
                    
                    let randomQuizz = self.pickRandomQuizz()
                    self.setUI(quizz: randomQuizz)
                }
                
            }

        })
  
    }
    
    func setUI(quizz: Quizz) {
        
        let answerButtons = [self.questionView.btnA, self.questionView.btnB, self.questionView.btnC, self.questionView.btnD]
        
        if let title = quizz.title {
            self.quizzTitle.text = title
            self.quizzTitle.backgroundColor = quizz.category?.value
        }
        
        if let quizzImageStringUrl = quizz.imageStringUrl {
            
            let imageURL = URL(string: quizzImageStringUrl)
            
            if let imageURL = imageURL {
                if let data = try? Data(contentsOf: imageURL) {
                    if let image = UIImage(data: data) {
                        print("Dohvacam sliku")
                        self.quizzImage.image = image
                    }
                }
            }
            
        }
        
        let question = quizz.questions[Int.random(in: 0 ... quizz.questions.count - 1)]
        
        self.question = question
        self.correctAnswer = question.answers[question.correctAnswer!]
        
        if let questionText = question.question {
            self.questionView.questionText.adjustsFontSizeToFitWidth = true
            self.questionView.questionText.lineBreakMode = .byWordWrapping
            self.questionView.questionText.numberOfLines = 0
            
            UIView.transition(with: self.questionView.questionText, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.questionView.questionText.text = questionText
            }, completion: nil)
            
        }
        
        for (index, element) in answerButtons.enumerated() {
            UIView.animate(withDuration: 0.5, animations: {
                element?.backgroundColor = self.wantedColor
            }, completion: nil)
            
            element?.backgroundColor = self.wantedColor
            element?.titleLabel?.adjustsFontSizeToFitWidth = true
            element?.setTitle(question.answers[index], for: .normal)
            element?.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        }
    }
    
    
    func pickRandomQuizz() -> Quizz {
        let rand = Int.random(in: 0 ... self.quizzes.count - 1)
        
        return self.quizzes[rand]
    }
    
    @objc func buttonClicked(sender:UIButton)
    {
        checkCorrectness(sender: sender)
    }
    
    func checkCorrectness(sender: UIButton) {
        if sender.titleLabel?.text == self.correctAnswer! {
            sender.backgroundColor = UIColor.green
        } else {
            sender.backgroundColor = UIColor.red
        }
    }
    

}

