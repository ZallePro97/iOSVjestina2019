//
//  SearchViewController.swift
//  Quizzlet
//
//  Created by Zeljko halle on 29/05/2019.
//  Copyright © 2019 Zeljko halle. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var allQuizzes: [Quizz]?
    var searchedQuizz: [Quizz]?
    
    var textField: UITextField!
    var searchBtn: UIButton!
    
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Search"
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 126/255, green: 127/255, blue: 227/255, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        
        self.view.backgroundColor = .white
        
        setUI()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        tableView.separatorStyle = .none
        
        tableView.register(QuizzTableViewCell.self, forCellReuseIdentifier: "QuizzTableViewCell")
        
    }
    
    func setUI() {
        
        textField = UITextField(frame: CGRect.zero)
        textField.backgroundColor = .gray
        
        searchBtn = UIButton(frame: CGRect.zero)
        searchBtn.setTitle("Search", for: .normal)
        searchBtn.backgroundColor = .purple
        searchBtn.layer.cornerRadius = 15
        searchBtn.layer.borderWidth = 1
        searchBtn.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
        
        
        tableView = UITableView(frame: CGRect.zero)
        
        
        let screen = UIScreen.main.bounds
        
        textField.autoSetDimensions(to: CGSize(width: screen.width, height: 40))
        
        view.addSubview(textField)
        view.addSubview(searchBtn)
        view.addSubview(tableView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        textField.autoPinEdge(toSuperviewEdge: .top, withInset: 63)
        
        searchBtn.autoPinEdge(toSuperviewEdge: .left, withInset: 55)
        searchBtn.autoPinEdge(toSuperviewEdge: .right, withInset: 55)
        searchBtn.autoPinEdge(.top, to: .bottom, of: textField, withOffset: 10)
        
        tableView.autoPinEdge(.top, to: .bottom, of: searchBtn, withOffset: 10)
        tableView.autoPinEdge(toSuperviewEdge: .bottom, withInset: self.tabBarController?.tabBar.frame.size.height ?? 49)
        tableView.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
        tableView.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
        
    }
    
    
    @objc func searchTapped(sender: UIButton) {
        
        self.searchedQuizz = []
        
        if let searchedQuizzText = textField.text {
            
            if let quizzes = self.allQuizzes {
                
                for quizz in quizzes {
                    
                    if let title = quizz.title, let description = quizz.description {
                        
                        if title.contains(searchedQuizzText) || description.contains(searchedQuizzText) {
                            print("dodajem")
                            self.searchedQuizz?.append(quizz)
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
        let range = NSMakeRange(0, self.tableView.numberOfSections)
        let sections = NSIndexSet(indexesIn: range)
        self.tableView.reloadSections(sections as IndexSet, with: .automatic) 
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchedQuizz?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = QuizzViewController()
        vc.quizz = self.searchedQuizz?[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizzTableViewCell", for: indexPath) as! QuizzTableViewCell
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.layer.shadowOpacity = 0.2
        
        cell.imgView.image = searchedQuizz?[indexPath.row].image
        cell.titleLabel.text = searchedQuizz?[indexPath.row].title
        cell.descriptionLabel.text = searchedQuizz?[indexPath.row].description
        
        let difficultyLevel = searchedQuizz?[indexPath.row].level
        
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

}
