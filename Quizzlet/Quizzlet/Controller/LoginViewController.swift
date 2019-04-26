//
//  LoginViewController.swift
//  Quizzlet
//
//  Created by Zeljko halle on 26/04/2019.
//  Copyright © 2019 Zeljko halle. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var navView: UIView!
    var navLabel: UILabel!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var loginBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupHideKeyboardOnTap()

        setUI()
    }
    

    func setUI() {
        
        let screenSize = UIScreen.main.bounds
        
        navView = UIView()
        navView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: 64)
        navView.backgroundColor = UIColor.init(red: 126/255, green: 127/255, blue: 227/255, alpha: 1)
        self.view.addSubview(navView)
        
        navLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 35))
        navLabel.textAlignment = .center
        navLabel.center.x = navView.center.x
        navLabel.frame.origin.y = navView.frame.height - navLabel.frame.height
        navView.addSubview(navLabel)
        navLabel.text = "Login"
        navLabel.textColor = .white
        
        emailTextField = UITextField(frame: CGRect(x: 16, y: navView.frame.height + 150, width: screenSize.width - 50, height: 30))
        emailTextField.center.x = self.view.center.x
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.keyboardType = .emailAddress
        self.view.addSubview(emailTextField)
        
        passwordTextField = UITextField(frame: CGRect(x: 16, y: emailTextField.frame.maxY + 30, width: screenSize.width - 50, height: 30))
        passwordTextField.center.x = self.view.center.x
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        self.view.addSubview(passwordTextField)
        
        loginBtn = UIButton(frame: CGRect(x: 0, y: passwordTextField.frame.maxY + 50, width: screenSize.width - 100, height: 50))
        loginBtn.setTitle("Login", for: .normal)
        loginBtn.center.x = self.view.center.x
        loginBtn.backgroundColor = .purple
        loginBtn.layer.cornerRadius = 20
        loginBtn.layer.borderWidth = 1
        loginBtn.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        self.view.addSubview(loginBtn)
        
    }
    
    @objc func loginButtonTapped(sender: UIButton!) {
        sender.backgroundColor = .black
        
        let loginService = LoginService()
        loginService.getToken(username: emailTextField.text!, password: passwordTextField.text!) { (json) in
            print(json)
        }
        
    }

}


extension UIViewController {
    /// Call this once to dismiss open keyboards by tapping anywhere in the view controller
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }
    
    /// Dismisses the keyboard from self.view
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
}
