//
//  TopQuizzResultTableViewController.swift
//  Quizzlet
//
//  Created by Zeljko halle on 09/05/2019.
//  Copyright © 2019 Zeljko halle. All rights reserved.
//

import UIKit

class TopQuizzResultTableViewController: UITableViewController {
    
    var userResults: [UserResult]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationItem.title = "Top 20 Results"
        navigationItem.setHidesBackButton(true, animated: true)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        
        let dismissButton = UIBarButtonItem(title: "Dismiss", style: UIBarButtonItem.Style.plain, target: self, action: #selector(dismissTapped))
        
        self.navigationItem.rightBarButtonItem = dismissButton
        
        tableView.register(TopResultTableViewCell.self, forCellReuseIdentifier: "TopResultTableViewCell")
        
    }
    
    @objc func dismissTapped() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let userResults = userResults {
            return userResults.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopResultTableViewCell", for: indexPath) as! TopResultTableViewCell
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.layer.shadowOpacity = 0.2
        
        if let userResults = userResults {
            cell.rankLabel.text = "\(indexPath.row + 1)."
            cell.usernameLabel.text = "Username: \(userResults[indexPath.row].username)"
            cell.scoreLabel.text = "Score: \(userResults[indexPath.row].score)"
        }
        
        return cell
    }
    
}
