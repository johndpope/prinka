//
//  SignUpViewController.swift
//  Pinder3
//
//  Created by LIPING on 5/7/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import ProgressHUD

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var xButton: UIButton!
    @IBOutlet weak var SignInButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    
    
    @IBOutlet weak var signInGoogleButton: UIButton!
    @IBOutlet weak var signInAppleButton: UIButton!
    
    //bar
    @IBOutlet weak var orLabel: UILabel!
    //bar
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var addImageLabel: UILabel!
    
    @IBOutlet weak var fullnameContainerView: UIView!
    @IBOutlet weak var fullnameTextField: UITextField!

    @IBOutlet weak var emailContainerView: UIView!
    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var passwordContainerView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var passwordButton: UIButton!
    
    // the photo selected for avatar
    var image: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Do any additional setup after loading the view.
    }

    func setupUI(){
        setupTitleLabel()
        setupSubLabel()
        setupGoogleButton()
        setupAppleButton()
        setupOrLabel()
        setupAvatar()
        setupFullNameTextField()
        setupEmailTextField()
        setupPasswordTextField()
        setupSignUpButton()
        setupSignInButton()
        setupXButton()
    }


    
    // Sign up button is tapped
    @IBAction func signUpButtonDidTapped(_ sender: Any) {
        self.view.endEditing(true)
        if self.validateFields(){
            self.signUp(
                onSuccess: {
                    //change online status
                    Api.User.isOnline(bool: true)
                    // switch view
                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let initViewController: UIViewController = storyboard.instantiateViewController(withIdentifier: IDENTIFIER_TABBAR) as UIViewController
                    initViewController.modalPresentationStyle = .fullScreen
                    self.present(initViewController, animated: true, completion: nil)
                }) {
                (errorMessage) in
                ProgressHUD.showError(errorMessage)
            }
        }
        


    }
    
    // X -> exit the controller
    @IBAction func dismissAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    var iconClick = false
    @IBAction func passwordButtonAction(_ sender: UIButton) {
        iconClick = !iconClick
        
        if(iconClick) {
            passwordTextField.isSecureTextEntry = false
            if let image = UIImage(systemName: "lock.open"){
                sender.setImage(image, for: UIControl.State.normal)
            }
//            sender.setImage(UIImage(named: "lock.open"), for: UIControl.State.normal)
        } else {
            passwordTextField.isSecureTextEntry = true
            if let image = UIImage(systemName: "lock"){
                sender.setImage(image, for: UIControl.State.normal)
            }
//            sender.setImage(UIImage(named: "lock"), for: UIControl.State.normal)
        }
    }
    
}
