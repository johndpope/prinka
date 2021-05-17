//
//  SignUpViewController+UI.swift
//  Pinder3
//
//  Created by LIPING on 5/7/21.
//

import UIKit
import ProgressHUD

extension SignUpViewController{
    func setupTitleLabel(){
        
    }
    func setupXButton(){
        let origImage = UIImage(systemName: "xmark")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        
        xButton.setImage(tintedImage, for: UIControl.State.normal)
        xButton.tintColor = .gray
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
        
//        for i in range(0, len(text)):
//            attribute = i % 2 == 0 ? att : attBold
//            text.append(str(att))for
//
//        let attributedText = NSMutableAttributedString(string: "By continuing, you agree to our\n",attributes: att)
//        attributedText.append(NSMutableAttributedString(string: "User Agreement",attributes: attBold))
//        attributedText.append(NSMutableAttributedString(string: " and ",attributes: att))
//        attributedText.append(NSMutableAttributedString(string: "User Agreement",attributes: attBold))
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
    func setupOrLabel(){
        orLabel.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    func setupAvatar(){
        avatar.layer.cornerRadius = 40
        avatar.clipsToBounds = true
        
        avatar.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentPicker))
        avatar.addGestureRecognizer(tapGesture)
    }
    
    // @objc -> for #selector?
    @objc func presentPicker(){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    func setupFullNameTextField(){
        fullnameContainerView.layer.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1).cgColor
        fullnameContainerView.layer.cornerRadius = 25

        fullnameTextField.borderStyle = .none

        let placeholderAttr = NSAttributedString(string: "Full Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)])

        fullnameTextField.attributedPlaceholder = placeholderAttr
//        fullnameTextField.ignoreSafeArea(.keyboard, edges: .bottom)


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
    
    func setupSignUpButton(){
        
        
        signUpButton.layer.cornerRadius = 25
        signUpButton.clipsToBounds = true
        
        signUpButton.setTitle("Sign Up", for: UIControl.State.normal)
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        applyGradient(button: signUpButton)
    }
    
    func setupSignInButton(){
        SignInButton.setTitle("Sign In", for: UIControl.State.normal)
        SignInButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        SignInButton.setTitleColor(UIColor(red: 25/255, green: 35/255, blue: 145/255, alpha: 1), for: .normal)
    
    }
    
    
    func signUp(onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void){
        ProgressHUD.show("Loading...")  // show an when user taps sign up button
        Api.User.signUp(withUsername: self.fullnameTextField.text!, email: self.emailTextField.text! , password: self.passwordTextField.text!, image: self.image,
                        onSuccess: {
                            ProgressHUD.dismiss()
                            onSuccess()
                        })
                        {(errorMessage) in
                            onError(errorMessage)
                        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    func validateFields() -> Bool{
        guard let username = self.fullnameTextField.text, !username.isEmpty else{
            ProgressHUD.showError(ERROR_EMPTY_USERNAME)
            print(ERROR_EMPTY_USERNAME)
            return false
        }
        guard let email = self.emailTextField.text, !email.isEmpty else{
            ProgressHUD.showError(ERROR_EMPTY_EMAIL)
            print(ERROR_EMPTY_EMAIL)
            return false
        }
        guard let password = self.passwordTextField.text, !password.isEmpty else{
            ProgressHUD.showError(ERROR_EMPTY_PASSWORD)
            print(ERROR_EMPTY_PASSWORD)
            return false
        }
        return true
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
}

// update the avatar when image is selcted
extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            image = imageSelected
            avatar.image = imageSelected
        }
        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            image = imageOriginal
            avatar.image = imageOriginal
        }
        addImageLabel.isHidden = true
        picker.dismiss(animated: true, completion: nil)
    }
}
