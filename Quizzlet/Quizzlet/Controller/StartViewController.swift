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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        wantedColor = questionView.btnA.backgroundColor
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    @IBAction func getQuizzes(_ sender: UIButton) {
        
        let answerButtons = [self.questionView.btnA, self.questionView.btnB, self.questionView.btnC, self.questionView.btnD]
        
        let urlString = "https://iosquiz.herokuapp.com/api/quizzes"
        
        let quizzService = QuizzService()
        
            quizzService.fetchQuizzes(urlString: urlString, completion: { (quizzes) in
                
            DispatchQueue.main.async {
                if let quizzes = quizzes {
                    self.quizzes = quizzes
                    print("Kvizovi dohvaceni!")
                    
                    var counter = 0
                    
                    for quizz in quizzes {
                        
                        let nbaQuestions = quizz.questions.filter { (question) -> Bool in
                            return (question.question?.contains("NBA"))!
                        }
                        
                        counter += nbaQuestions.count
                    }
                    
                    print("'NBA' is mentioned \(counter) times")
                    
                    self.funFactLabel.text = "Ima \(counter) pitanja koja sadrze 'NBA'"
                }
                
                //  dohvacanje neuspjesno
                
                if self.quizzes.count == 0 {
                    let alert = UIAlertController(title: "Alert", message: "Cannot connect to server", preferredStyle:UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    
                    // dohvacanje uspjesno
                    
                    let randomQuizz = self.pickRandomQuizz()
                    
                    if let title = randomQuizz.title {
                        self.quizzTitle.text = title
                        self.quizzTitle.backgroundColor = randomQuizz.category?.value
                    }
                    
                    if let quizzImage = randomQuizz.image {
                        self.quizzImage.image = quizzImage
                        self.quizzImage.backgroundColor = randomQuizz.category?.value
                    }
                    
                    let question = randomQuizz.questions[Int.random(in: 0 ... randomQuizz.questions.count - 1)]
                    print(question.question!)
                    
                    self.question = question
                    self.correctAnswer = question.answers[question.correctAnswer!]
                    
                    if let questionText = question.question {
                        self.questionView.questionText.adjustsFontSizeToFitWidth = true
                        self.questionView.questionText.lineBreakMode = .byWordWrapping
                        self.questionView.questionText.numberOfLines = 0
                        
                        UIView.transition(with: self.questionView.questionText, duration: 0.5, options: .transitionCrossDissolve, animations: {
                            self.questionView.questionText.text = questionText
                        }, completion: nil)
                        //
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
                
                
                
            }

        })
  
    }
    
    
    func pickRandomQuizz() -> Quizz {
        let rand = Int.random(in: 0 ... self.quizzes.count - 1)
        
        return self.quizzes[rand]
    }
    
    @objc func buttonClicked(sender:UIButton)
    {
        switch sender.tag
        {
        case 1:
            print("1")     //when Button1 is clicked...
            
            checkCorrectness(sender: sender)
            
            break
        case 2:
            print("2")     //when Button2 is clicked...
            checkCorrectness(sender: sender)

            break
        case 3:
            print("3")     //when Button3 is clicked...
            checkCorrectness(sender: sender)

            break
        case 4:
            print("4")
            checkCorrectness(sender: sender)

            break
        default:
            print("Other...")
        }
    }
    
    func checkCorrectness(sender: UIButton) {
        if sender.titleLabel?.text == self.correctAnswer! {
            sender.backgroundColor = UIColor.green
        } else {
            sender.backgroundColor = UIColor.red
        }
    }
    

}

