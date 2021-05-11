//
//  SignUpViewController+UI.swift
//  Pinder3
//
//  Created by LIPING on 5/7/21.
//

import UIKit
import SwiftUI
import ProgressHUD

extension SignInViewController{
    func setupTitleLabel(){
//        titleLabel.textAlignment = .center
        
    }
    
    func setupEmailTextField(){
        emailContainerView.layer.borderWidth = 1
        emailContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        emailContainerView.layer.cornerRadius = 25

        emailTextField.borderStyle = .none

        let placeholderAttr = NSAttributedString(string: "E-mail Address", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])

        emailTextField.attributedPlaceholder = placeholderAttr
    }
    func setupPasswordTextField(){
        passwordContainerView.layer.borderWidth = 1
        passwordContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        passwordContainerView.layer.cornerRadius = 25

        passwordTextField.borderStyle = .none

        let placeholderAttr = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])

        passwordTextField.attributedPlaceholder = placeholderAttr
    }
    
    // try adding gradient
    func setupSignUpButton(){
        signInButton.layer.cornerRadius = 25
        signInButton.clipsToBounds = true

        signInButton.setTitle("Continue", for: UIControl.State.normal)
        signInButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)

//        signInButton.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
//        let buttonGradient = Gradient(colors: [Color.black.opacity(0), Color.black.opacity(0.3)])
        
//        LinearGradient(gradient: buttonGradient, startPoint: .top, endPoint: .bottom)
        
//        signInButton.titleEdgeInsets = UIEdgeInsets(top:0, left:-550.0, bottom:0.0, right:0.0)       // 450
    }
    func setupSignInButton(){
        
    }
    
    func validateFields(){
        guard let email = self.emailTextField.text, !email.isEmpty else{
            ProgressHUD.showError(ERROR_EMPTY_EMAIL)
            return
        }
        guard let password = self.passwordTextField.text, !password.isEmpty else{
            ProgressHUD.showError(ERROR_EMPTY_PASSWORD)
            return
        }
    }
    
    func signIn(onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void){
        ProgressHUD.show("Loading...")  // show an when user taps sign up button
        //call sign in from api
        Api.User.signIn(email: self.emailTextField.text!, password: passwordTextField.text!, onSuccess:{
            ProgressHUD.dismiss()
            onSuccess()
        }) { (errorMessage) in
            onError(errorMessage)
        }
    }
}
