//
//  LoginViewController.swift
//  SimpleRSSReader
//
//  Created by Gabriel on 20/09/2020.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    private var descriptionLabel: UILabel!
    private var usernameTextField: UITextField!
    private var passwordTextField: UITextField!
    private var loginButton: StyledButton!
    private var registerButton: StyledButton!
    private var activityIndicator: UIActivityIndicatorView!
    
    private var userViewModel = UserViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Log in"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .backgroundColor
        initViews()
        setUpConstraints()
        
        definesPresentationContext = true
    }
    
    func initViews() {
        
        descriptionLabel = {
            let descriptionLabel = UILabel()
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            descriptionLabel.text = "Please, enter your credentials in order to access"
            descriptionLabel.font = UIFont.descriptionFont
            descriptionLabel.lineBreakMode = .byWordWrapping
            descriptionLabel.numberOfLines = 0
            descriptionLabel.sizeToFit()
            descriptionLabel.textColor = UIColor.textColor
            
            return descriptionLabel
        }()
        
        usernameTextField = {
            let usernameTextField = UITextField()
            usernameTextField.translatesAutoresizingMaskIntoConstraints = false
            usernameTextField.placeholder = "Username"
            
            return usernameTextField
        }()
        
        passwordTextField = {
            let passwordTextField = UITextField()
            passwordTextField.translatesAutoresizingMaskIntoConstraints = false
            passwordTextField.placeholder = "Password"
            passwordTextField.isSecureTextEntry = true
            
            return passwordTextField
        }()
        
        loginButton = {
            let loginButton = StyledButton()
            loginButton.translatesAutoresizingMaskIntoConstraints = false
            loginButton.setTitle("Login", for: .normal)
            loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
            
            return loginButton
        }()
        
        registerButton = {
            let registerButton = StyledButton()
            registerButton.translatesAutoresizingMaskIntoConstraints = false
            registerButton.setTitle("Register", for: .normal)
            registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
            
            return registerButton
        }()
        
        activityIndicator = {
            let activityIndicator = UIActivityIndicatorView()
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            activityIndicator.isHidden = true
            let transfrom = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
            activityIndicator.transform = transfrom
            
            return activityIndicator
        }()
    }
    
    func setUpConstraints(){
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(usernameTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(loginButton)
        self.view.addSubview(registerButton)
        self.view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate(
            [
                descriptionLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: Dimens.m.value),
                descriptionLabel.bottomAnchor.constraint(equalTo: usernameTextField.topAnchor, constant: -Dimens.m.value),
                descriptionLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: Dimens.m.value),
                descriptionLabel.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -Dimens.m.value)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                usernameTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Dimens.m.value),
                usernameTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -Dimens.m.value),
                usernameTextField.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: Dimens.m.value),
                usernameTextField.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -Dimens.m.value)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: Dimens.m.value),
                passwordTextField.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -Dimens.l.value),
                passwordTextField.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: Dimens.m.value),
                passwordTextField.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -Dimens.m.value)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: Dimens.l.value),
                loginButton.bottomAnchor.constraint(equalTo: registerButton.topAnchor, constant: -Dimens.s.value),
                loginButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: Dimens.l.value),
                loginButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -Dimens.l.value)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: Dimens.s.value),
                registerButton.bottomAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -Dimens.m.value),
                registerButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: Dimens.l.value),
                registerButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -Dimens.l.value)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                activityIndicator.heightAnchor.constraint(equalToConstant: Dimens.l.value),
                activityIndicator.widthAnchor.constraint(equalToConstant: Dimens.l.value),
                activityIndicator.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: Dimens.m.value),
                activityIndicator.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            ]
        )
    }
    
    @objc func loginButtonPressed() {
        self.startLoading()
        userViewModel.loginUser(username: usernameTextField.text!, password: passwordTextField.text!) {[weak self] (errorMessage) in
            
            DispatchQueue.main.async {
                self?.stopLoading()
                
                guard let self = self else { return }
                if let errorMessage = errorMessage { self.showAlert(title: "Ups!", message: errorMessage); return}
                
                self.navigationController?.pushViewController(RSSFeedViewController(userViewModel: self.userViewModel), animated: true)
            }
        }
    }
    
    @objc func registerButtonPressed() {
        self.startLoading()
        userViewModel.registerUser(username: usernameTextField.text!, password: passwordTextField.text!) {[weak self] (errorMessage) in
            
            DispatchQueue.main.async {
                self?.stopLoading()
                
                guard let self = self else { return }
                if let errorMessage = errorMessage { self.showAlert(title: "Ups!", message: errorMessage); return}
                
                self.navigationController?.pushViewController(RSSFeedViewController(userViewModel: self.userViewModel), animated: true)
            }
        }
    }
    
    func startLoading() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
}
