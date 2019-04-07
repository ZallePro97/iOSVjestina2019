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
    
    @IBOutlet weak var funFactLabel: UILabel!
    @IBOutlet weak var quizzTitle: UILabel!
    @IBOutlet weak var quizzImage: UIImageView!
    @IBOutlet weak var questionView: QuestionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    @IBAction func getQuizzes(_ sender: UIButton) {
        
        self.questionView.subviews.forEach { (subview) in
            
            // moram napravit refreshanje gumbi
            
            subview.backgroundColor = questionView.backgroundColor
        }
        
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
                    
                if self.quizzes.count == 0 {
                    let alert = UIAlertController(title: "Alert", message: "Cannot connect to server", preferredStyle:UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
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
                    self.questionView.questionText.text = questionText
                }
                
                self.questionView.btnA.titleLabel?.adjustsFontSizeToFitWidth = true
                self.questionView.btnA.setTitle(question.answers[0], for: .normal)
                self.questionView.btnA.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
                
                self.questionView.btnB.titleLabel?.adjustsFontSizeToFitWidth = true
                self.questionView.btnB.setTitle(question.answers[1], for: .normal)
                self.questionView.btnB.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
                
                self.questionView.btnC.titleLabel?.adjustsFontSizeToFitWidth = true
                self.questionView.btnC.setTitle(question.answers[2], for: .normal)
                self.questionView.btnC.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
                
                self.questionView.btnD.titleLabel?.adjustsFontSizeToFitWidth = true
                self.questionView.btnD.setTitle(question.answers[3], for: .normal)
                self.questionView.btnD.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
                
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

