//
//  QuizzListTableViewController.swift
//  Quizzlet
//
//  Created by Zeljko halle on 27/04/2019.
//  Copyright © 2019 Zeljko halle. All rights reserved.
//

import UIKit

class QuizzListTableViewController: UITableViewController {
    
    var quizzes: [Quizz] = []
    
    struct CategoryQuizzes {
        
        var category: Category!
        var quizzes: [Quizz]!
    }
    
    var quizzesByCategory: [CategoryQuizzes] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Quizzes"
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 126/255, green: 127/255, blue: 227/255, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        
        self.tableView.separatorStyle = .none
        
        tableView.register(QuizzTableViewCell.self, forCellReuseIdentifier: "QuizzTableViewCell")
        
        let quizzService = QuizzService()
        
        quizzService.fetchQuizzes(completion: { (quizzes) in
            
            DispatchQueue.main.async {
                if let quizzes = quizzes {
                    self.quizzes = quizzes
                    self.fillQuizzesByCategories()
                    print("Dohvacanje kvizova uspjesno")
                    print("Kvizovi: \(quizzes)")
                    
                    self.tableView.delegate = self
                    self.tableView.dataSource = self
                    self.tableView.reloadData()
                }
                
                //  dohvacanje neuspjesno
                
                if self.quizzes.count == 0 {
                    let alert = AlertException.raiseAlert(message: "Cannot connect to server")
                    self.present(alert, animated: true, completion: nil)
                }
            }
        
            
        })
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        footerView.backgroundColor = UIColor.init(red: 126/255, green: 127/255, blue: 227/255, alpha: 1)
        
        let logoutBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 35))
        logoutBtn.setTitle("Logout", for: .normal)
        logoutBtn.center = footerView.center
        logoutBtn.backgroundColor = .purple
        logoutBtn.layer.cornerRadius = 15
        logoutBtn.layer.borderWidth = 1
        logoutBtn.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        footerView.addSubview(logoutBtn)
        
        tableView.tableFooterView = footerView
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
        vc.text = "hahaha"
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
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    @objc func logoutButtonTapped(sender: UIButton!) {
        print("TAPNUTO")
        UserDefaults.standard.removeObject(forKey: "token")
        
        self.present(LoginViewController(), animated: true, completion: nil)
    }
    
    // set height for footer
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }

}
