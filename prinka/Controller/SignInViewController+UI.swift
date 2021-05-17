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
    
    // MARK: - object set up
    
    func setupBackButton(){
        let origImage = UIImage(systemName: "xmark")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        
        backButton.setImage(tintedImage, for: UIControl.State.normal)
        backButton.tintColor = .gray
    }
    
    
    func setupTitleLabel(){
//        titleLabel.textAlignment = .center
        
    }
    
    
    
    func setupSubLabel(){
        let normalAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                   NSAttributedString.Key.foregroundColor: UIColor.gray]
        
        let  boldAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
                              NSAttributedString.Key.foregroundColor: UIColor(red: 92/255, green: 136/255, blue: 174/255, alpha: 0.9)]
        
        var text = [String]()
        text.append("By continuing, you agree to our\n")
        text.append("User Agreement")
        text.append(" and ")
        text.append("Privacy Policy")
        text.append(".")
        
        
        let attText = NSMutableAttributedString()
        for i in  0...text.count-1{
            let attribute = i % 2 == 0 ? normalAttribute : boldAttribute
            attText.append(NSMutableAttributedString(string: text[i] ,attributes: attribute))
        }
        
        subLabel.textColor = .gray
        subLabel.attributedText = attText
    }
    func setupOrLabel(){
        orLabel.font = UIFont.boldSystemFont(ofSize: 12)
    }
    func setupAppleButton(){
        signInAppleButton.layer.borderWidth = 2
        signInAppleButton.layer.borderColor = UIColor(red: 25/255, green: 35/255, blue: 145/255, alpha: 1).cgColor
        // apple BUTTON
        // change background color
        // convert image to white apple
        signInAppleButton.layer.cornerRadius = 25
        signInAppleButton.clipsToBounds = true
        
        signInAppleButton.setTitle("Continue with Apple", for: UIControl.State.normal)
        signInAppleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
//        signInFacebookButton.backgroundColor = UIColor(red: 58/255, green: 85/255, blue: 159/255, alpha: 1)
        signInAppleButton.setImage(UIImage(named: "icon-apple1"), for: UIControl.State.normal)
        signInAppleButton.imageView?.contentMode = .scaleAspectFit
//        signInAppleButton.tintColor = .white
        signInAppleButton.imageEdgeInsets = UIEdgeInsets(top: 12, left: -280, bottom: 12, right: 0)
        signInAppleButton.titleEdgeInsets = UIEdgeInsets(top:0, left:-630.0, bottom:0.0, right:0.0)
    }
    
    func setupGoogleButton(){
        signInGoogleButton.layer.borderWidth = 2
        signInGoogleButton.layer.borderColor = UIColor(red: 25/255, green: 35/255, blue: 145/255, alpha: 1).cgColor
        // GOOGLE BUTTON
        // change background color
        // image changes color when button is clicked
        signInGoogleButton.layer.cornerRadius = 25
        signInGoogleButton.clipsToBounds = true
        
        signInGoogleButton.setTitle("Continue with Google", for: UIControl.State.normal)
        signInGoogleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
//        signInGoogleButton.backgroundColor = UIColor(red: 219/255, green: 68/255, blue: 55/255, alpha: 1)
        
        signInGoogleButton.setImage(UIImage(named: "icon-google"), for: UIControl.State.normal)
        signInGoogleButton.imageView?.contentMode = .scaleAspectFit
//        signInGoogleButton.tintColor = .white
        
        signInGoogleButton.imageEdgeInsets = UIEdgeInsets(top: 12, left: -280, bottom: 12, right: 0)
        signInGoogleButton.titleEdgeInsets = UIEdgeInsets(top:0, left:-622.0, bottom:0.0, right:0.0)
    }
    
    func setupEmailTextField(){
        emailContainerView.layer.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1).cgColor
        emailContainerView.layer.cornerRadius = 25

        emailTextField.borderStyle = .none

        let placeholderAttr = NSAttributedString(string: "Email Address", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)])

        emailTextField.attributedPlaceholder = placeholderAttr
    }
    func setupPasswordTextField(){
        passwordContainerView.layer.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1).cgColor
        passwordContainerView.layer.cornerRadius = 25

        passwordTextField.borderStyle = .none

        let placeholderAttr = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)])

        passwordTextField.attributedPlaceholder = placeholderAttr
    }
    
    // try adding gradient
    func setupSignInButton(){
        signInButton.layer.cornerRadius = 25
        signInButton.clipsToBounds = true

        signInButton.setTitle("Continue", for: UIControl.State.normal)
        signInButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        applyGradient(button: signInButton)


//        signInButton.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
//        let buttonGradient = Gradient(colors: [Color.black.opacity(0), Color.black.opacity(0.3)])
        
//        LinearGradient(gradient: buttonGradient, startPoint: .top, endPoint: .bottom)
        
//        signInButton.titleEdgeInsets = UIEdgeInsets(top:0, left:-550.0, bottom:0.0, right:0.0)       // 450
    }
    func setupSignUpButton(){
        signUpButton.setTitle("Sign Up", for: UIControl.State.normal)
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        signUpButton.setTitleColor(UIColor(red: 25/255, green: 35/255, blue: 145/255, alpha: 1), for: .normal)
    }
    
    
    
    // MARK: other functions
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
    
    func applyGradient(button: UIButton){
        let topGradientColor = UIColor.systemTeal
        let bottomGradientColor = UIColor.systemPink

        let gradientLayer = CAGradientLayer()

        gradientLayer.frame = button.bounds

        gradientLayer.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]

        //Vertical
        //gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        //gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)

        //Horizontal
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)

        gradientLayer.locations = [0.0, 1.0]
        button.layer.insertSublayer(gradientLayer, at: 0)
    
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
