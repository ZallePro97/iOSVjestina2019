//
//  TabBarControllerViewController.swift
//  Quizzlet
//
//  Created by Zeljko halle on 28/05/2019.
//  Copyright © 2019 Zeljko halle. All rights reserved.
//

import UIKit
import CoreData

class TabBarControllerViewController: UITabBarController {
    
    var quizzes: [Quizz] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
        let navController = UINavigationController()
        let quizzListVC = QuizzListTableViewController()
        quizzListVC.quizzes = self.quizzes
        navController.addChild(quizzListVC)
        
        quizzListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 0)
        quizzListVC.tabBarItem.title = "Quizzess"
        
        
        let navVC = UINavigationController()
        let searchVC = SearchViewController()
        searchVC.allQuizzes = self.quizzes
        navVC.addChild(searchVC)
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        searchVC.tabBarItem.title = "Search"
        
        let settingsVC = SettingsViewController()
        settingsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 2)
        settingsVC.tabBarItem.title = "Settings"
        
        tabBar.items?[0].title = "Quizzes"
        tabBar.items?[1].title = "Search"
        tabBar.items?[2].title = "Settings"
        
        let tabBarList = [navController, navVC, settingsVC]
        
        viewControllers = tabBarList
    }
    
    
    func loadData() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Quizzes")
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Quizzes")
        
        request.returnsObjectsAsFaults = false
        
        
        do {
            let results = try context.fetch(request)
            
            if results.count > 0 {
                print("IMAM NESTO")
                print(results.count)
                
                //                print(results)
                
                for r in results as! [NSManagedObject] {
                    let id = r.value(forKey: "id") as! Int
                    let title = r.value(forKey: "title") as! String
                    let description = r.value(forKey: "quizzDescription") as! String
                    let c = r.value(forKey: "category") as! String
                    let category = Category.init(rawValue: c)
                    let level = r.value(forKey: "level") as! Int
                    let img = r.value(forKey: "image") as! NSData
                    let image = UIImage(data: img as Data)
                    let imageStringUrl = r.value(forKey: "imageStringUrl") as! String
                    let qq = r.value(forKey: "questions") as! NSMutableSet
                    let questions = qq.allObjects as! [Questions]
                    
                    let quizz = Quizz()
                    
                    quizz.id = id
                    quizz.title = title
                    quizz.description = description
                    quizz.category = category
                    quizz.level = level
                    quizz.image = image
                    quizz.imageStringUrl = imageStringUrl
                    
                    for q in questions {
                        let answers = q.value(forKey: "answers") as! [String]
                        let correctAnswer = q.value(forKey: "correctAnswer") as! Int
                        let id = q.value(forKey: "id") as! Int
                        let quest = q.value(forKey: "question") as! String
                        
                        let question = Question(answers: answers, correctAnswer: correctAnswer, id: id, question: quest)
                        
                        quizz.questions.append(question)
                    }
                    
                    self.quizzes.append(quizz)
                }
                
            } else {
                print("Nema nista")
                let quizzService = QuizzService()
                
                quizzService.fetchQuizzes(completion: { (quizzes) in
                    
                    DispatchQueue.main.async {
                        if let quizzes = quizzes {
                            self.quizzes = quizzes
                            
                            for quizz in quizzes {
                                
                                let questions = quizz.questions
                                
                                let newQuizz = Quizzes(context: context)
                                
                                newQuizz.setValue(quizz.id, forKey: "id")
                                newQuizz.setValue(quizz.title, forKey: "title")
                                newQuizz.setValue(quizz.description, forKey: "quizzDescription")
                                let image = (quizz.image)?.pngData() as NSData?
                                newQuizz.setValue(image, forKey: "image")
                                newQuizz.setValue(quizz.level, forKey: "level")
                                newQuizz.setValue(quizz.imageStringUrl, forKey: "imageStringUrl")
                                newQuizz.setValue(quizz.category?.rawValue, forKey: "category")
                                
                                for question in questions {
                                    let newQuestion = Questions(context: context)
                                    
                                    //                            newQuestion.id = 1
                                    
                                    newQuestion.setValue(question.answers, forKey: "answers")
                                    newQuestion.setValue(question.correctAnswer, forKey: "correctAnswer")
                                    newQuestion.setValue(question.id, forKey: "id")
                                    newQuestion.setValue(question.question, forKey: "question")
                                    
                                    newQuizz.addToQuestions(newQuestion)
                                    
                                    //                            print("PITANJE: \(newQuestion)")
                                }
                                
                                
                                
                                //                        newQuizz.setValue(questionsForQuizz, forKey: "quizzQuestions")
                                
                                do {
                                    try context.save()
                                    print("SAVED!")
                                } catch {
                                    
                                }
                                
                                //                        print(newQuizz)
                            }
                            
                        }
                        
                        //  dohvacanje neuspjesno
                        
                        if self.quizzes.count == 0 {
                            let alert = AlertException.raiseAlert(message: "Cannot connect to server")
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                    
                    
                })
            }
            
        } catch {
            print("ERROR!")
        }
        
    }
    
    
}
