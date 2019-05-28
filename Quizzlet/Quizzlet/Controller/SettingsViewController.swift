//
//  SettingsViewController.swift
//  Quizzlet
//
//  Created by Zeljko halle on 28/05/2019.
//  Copyright © 2019 Zeljko halle. All rights reserved.
//

import UIKit
import PureLayout

class SettingsViewController: UIViewController {
    
    var usernameLabel: UILabel!
    var myUsernameLabel: UILabel!
    var logoutBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        setUI()
    }
    
    func setUI() {
        usernameLabel = UILabel(frame: CGRect.zero)
        usernameLabel.text = "Username:"
        usernameLabel.textAlignment = .left
        usernameLabel.layer.cornerRadius = 10
        usernameLabel.layer.borderWidth = 1
        usernameLabel.layer.backgroundColor = UIColor.gray.cgColor
        usernameLabel.sizeToFit()
        usernameLabel.font = usernameLabel.font.withSize(18)
        
        myUsernameLabel = UILabel(frame: CGRect.zero)
        myUsernameLabel.backgroundColor = .white
        myUsernameLabel.font = myUsernameLabel.font.withSize(18)
        myUsernameLabel.text = UserDefaults.standard.string(forKey: "username")
        
        logoutBtn = UIButton(frame: CGRect.zero)
        logoutBtn.setTitle("Logout", for: .normal)
        logoutBtn.backgroundColor = .purple
        logoutBtn.layer.cornerRadius = 15
        logoutBtn.layer.borderWidth = 1
        logoutBtn.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        
        usernameLabel.autoSetDimensions(to: CGSize(width: 90, height: 35))
        myUsernameLabel.autoSetDimensions(to: CGSize(width: 100, height: 35))
        logoutBtn.autoSetDimensions(to: CGSize(width: 150, height: 35))
        
        view.addSubview(usernameLabel)
        view.addSubview(myUsernameLabel)
        view.addSubview(logoutBtn)
        
        setConstraints()
    }
    
    func setConstraints() {
        usernameLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 160)
        usernameLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 50)
        
        myUsernameLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 160)
        myUsernameLabel.autoPinEdge(.left, to: .right, of: usernameLabel, withOffset: 10)
        
        logoutBtn.autoCenterInSuperview()
    }
    
    @objc func logoutTapped(sender: UIButton!) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        UserDefaults.standard.removeObject(forKey: "token")
        UserDefaults.standard.removeObject(forKey: "user_id")
        
        UIView.transition(with: appDelegate.window!, duration: 0.3, options: .transitionCrossDissolve, animations: {
            appDelegate.window?.rootViewController = LoginViewController()
        }, completion: { completed in
            // maybe do something here
        })
    }

}
