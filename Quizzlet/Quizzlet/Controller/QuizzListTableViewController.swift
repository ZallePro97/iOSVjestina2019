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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let quizzService = QuizzService()
        
        quizzService.fetchQuizzes(completion: { (quizzes) in
            
            DispatchQueue.main.async {
                if let quizzes = quizzes {
                    self.quizzes = quizzes
                    print("Dohvacanje kvizova uspjesno")
                    print("Kvizovi: \(quizzes)")
                    self.tableView.reloadData()
                }
                
                //  dohvacanje neuspjesno
                
                if self.quizzes.count == 0 {
                    let alert = AlertException.raiseAlert(message: "Cannot connect to server")
                    self.present(alert, animated: true, completion: nil)
                }
            }
        
            
        })

        tableView.register(QuizzTableViewCell.self, forCellReuseIdentifier: "QuizzTableViewCell")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        // For now
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizzTableViewCell", for: indexPath) as! QuizzTableViewCell
        
        cell.quizz = quizzes[indexPath.row]

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
