//
//  QuizzListTableViewController.swift
//  Quizzlet
//
//  Created by Zeljko halle on 27/04/2019.
//  Copyright © 2019 Zeljko halle. All rights reserved.
//

import UIKit
import CoreData

class QuizzListTableViewController: UITableViewController {
    
    var quizzes: [Quizz] = []
    
    struct CategoryQuizzes {
        
        var category: Category!
        var quizzes: [Quizz]!
    }
    
    var quizzesByCategory: [CategoryQuizzes] = []
    
//    func deleteAllData(_ entity:String) {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
//        fetchRequest.returnsObjectsAsFaults = false
//        do {
//            let results = try context.fetch(fetchRequest)
//            for object in results {
//                guard let objectData = object as? NSManagedObject else {continue}
//                context.delete(objectData)
//            }
//        } catch let error {
//            print("Detele all data in \(entity) error :", error)
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        deleteAllData("Quizzes")
        
        navigationItem.title = "Quizzes"
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 126/255, green: 127/255, blue: 227/255, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.separatorStyle = .none
        
        tableView.register(QuizzTableViewCell.self, forCellReuseIdentifier: "QuizzTableViewCell")
        
        loadData()
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        footerView.backgroundColor = UIColor.init(red: 126/255, green: 127/255, blue: 227/255, alpha: 1)
        
        let logoutBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 35))
        logoutBtn.setTitle("Logout", for: .normal)
        logoutBtn.center = footerView.center
        logoutBtn.backgroundColor = .purple
        logoutBtn.layer.cornerRadius = 15
        logoutBtn.layer.borderWidth = 1
        logoutBtn.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
//        footerView.addSubview(logoutBtn)
        
        tableView.tableFooterView = footerView
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
                
                self.fillQuizzesByCategories()
                
            } else {
                print("Nema nista")
                let quizzService = QuizzService()
                
                quizzService.fetchQuizzes(completion: { (quizzes) in
                    
                    DispatchQueue.main.async {
                        if let quizzes = quizzes {
                            self.quizzes = quizzes
                            self.fillQuizzesByCategories()
                            
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
                            
                            
                            
                            self.tableView.reloadData()
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
    
    func fillQuizzesByCategories() {
        
        var dict = [Category: [Quizz]]()
        
        for quizz in quizzes {
            if let category = quizz.category {
                
                if !dict.keys.contains(category) {
                    dict[category] = []
                }
                
                dict[category]?.append(quizz)
                
            }
        }
        
        for (key, value) in dict {
            quizzesByCategory.append(CategoryQuizzes(category: key, quizzes: value))
        }
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return quizzesByCategory.count
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        let category = self.quizzesByCategory[section].category
        label.text = category?.rawValue
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.backgroundColor = category?.value
        
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.quizzesByCategory[section].quizzes.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = QuizzViewController()
        vc.quizz = self.quizzesByCategory[indexPath.section].quizzes[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizzTableViewCell", for: indexPath) as! QuizzTableViewCell
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.layer.shadowOpacity = 0.2
        
        cell.imgView.image = quizzesByCategory[indexPath.section].quizzes[indexPath.row].image
        cell.titleLabel.text = quizzesByCategory[indexPath.section].quizzes[indexPath.row].title
        cell.descriptionLabel.text = quizzesByCategory[indexPath.section].quizzes[indexPath.row].description
        
        let difficultyLevel = quizzesByCategory[indexPath.section].quizzes[indexPath.row].level
        
        switch difficultyLevel {
        case 1:
            cell.difficultyLevel.text = "*"
        case 2:
            cell.difficultyLevel.text = "**"
        case 3:
            cell.difficultyLevel.text = "***"
        default:
            cell.difficultyLevel.text = "*"
        }
        
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    @objc func logoutButtonTapped(sender: UIButton!) {
        UserDefaults.standard.removeObject(forKey: "token")
        
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
            self.present(LoginViewController(), animated: true, completion: nil)
        }
        
    }
    
    // set height for footer
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }

}
