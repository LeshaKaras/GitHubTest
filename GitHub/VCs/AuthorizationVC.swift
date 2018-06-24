//
//  AuthorizationVC.swift
//  GitHub
//
//  Created by Alexei Karas on 21.06.2018.
//  Copyright © 2018 TestOrg. All rights reserved.
//

import UIKit

class AuthorizationVC: UIViewController {

    let textFieldNick       = UITextField()
    let textFieldPassword   = UITextField()
    
    let activityIndicator   : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.stopAnimating()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.tintColor = UIColor.black
        return activityIndicator
    }()
    
    let buttonAuthorization : UIButton = {
        let button = UIButton()
        button.setTitle("Sign in", for: UIControlState.normal)
        button.setTitle("...",     for: UIControlState.highlighted)
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()

    override func loadView() {
        super.loadView()
        
        addViews()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Add Views
    func addViews() {

        //exampel use frames
        
        let heightAndWeightButton   : CGFloat = 100.0
        let xPositionTextFields     : CGFloat = 30.0
        let heightTextFields        : CGFloat = 30.0
        let indentTextFields        : CGFloat = 50.0

        buttonAuthorization.frame = CGRect.init(x: (self.view.bounds.size.width / 2) - (heightAndWeightButton / 2),
                                                y: (self.view.bounds.size.height / 2) - (heightAndWeightButton / 2),
                                                width: heightAndWeightButton,
                                                height: heightAndWeightButton)
        
        buttonAuthorization.backgroundColor = UIColor.gray
        buttonAuthorization.layer.cornerRadius = 5;
        buttonAuthorization.layer.borderWidth = 1;
        buttonAuthorization.layer.borderColor = UIColor.black.cgColor
        self.view.addSubview(buttonAuthorization)
        
        textFieldPassword.placeholder = "Пароль"
        textFieldPassword.frame = CGRect.init(x: xPositionTextFields,
                                              y: buttonAuthorization.frame.minY - indentTextFields,
                                              width: self.view.bounds.size.width - xPositionTextFields * 2,
                                              height: heightTextFields)
        
        textFieldPassword.clipsToBounds = true;
        textFieldPassword.layer.cornerRadius = 5;
        textFieldPassword.layer.borderWidth = 1;
        textFieldPassword.layer.borderColor = UIColor.black.cgColor
        textFieldPassword.isSecureTextEntry = true
        self.view.addSubview(textFieldPassword)
        
        textFieldNick.placeholder = "Ник"
        textFieldNick.frame = CGRect.init(x: xPositionTextFields,
                                          y: textFieldPassword.frame.minY - indentTextFields,
                                          width: self.view.bounds.size.width - xPositionTextFields * 2,
                                          height: heightTextFields)
        
        textFieldNick.clipsToBounds = true;
        textFieldNick.layer.cornerRadius = 5;
        textFieldNick.layer.borderWidth = 1;
        textFieldNick.layer.borderColor = UIColor.black.cgColor
        self.view.addSubview(textFieldNick)
        
        self.view.addSubview(activityIndicator)
        activityIndicator.center = self.view.center

    }
    
    // MARK: Selectors
    @objc func handleRegister(sender: UIButton) {
        
        if textFieldNick.isFirstResponder || textFieldPassword.isFirstResponder {
            self.view.endEditing(true)
        }
        if (textFieldNick.text?.count == 0 || textFieldPassword.text?.count == 0){
            showAlertWithMessage(message:"Заполните все поля")
        } else {
           sendRequestAuthorization()
        }
    }
    
    // MARK: Alert
    func showAlertWithMessage(message:String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: SendRequest
    func sendRequestAuthorization(){
        buttonAuthorization.isEnabled = false
        activityIndicator.startAnimating()
        
        RequestManager.accessManager.authorizationUser(nick: textFieldNick.text!, password: textFieldPassword.text!){ success in
            
            self.buttonAuthorization.isEnabled = true
            self.activityIndicator.stopAnimating()
            
            if success == false{
                self.showAlertWithMessage(message:"Не валидные данные")
            } else {
                self.textFieldNick.text = ""
                self.textFieldPassword.text = ""
                
                let tabBarMain = TabBarMainVC()
                self.present(tabBarMain, animated: true, completion: nil)
            }
        }
   }
    
    
    
    
    
    
    
    
    
    
    
    
}
