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

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var fullnameContainerView: UIView!
    @IBOutlet weak var fullnameTextField: UITextField!

    @IBOutlet weak var emailContainerView: UIView!
    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var passwordContainerView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var SignInButton: UIButton!
    
    // the photo selected for avatar
    var image: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }

    func setupUI(){
        setupTitleLabel()
        // add text "add an image"
        setupAvatar()
        setupFullNameTextField()
        setupEmailTextField()
        setupPasswordTextField()
        setupSignUpButton()
        setupSignInButton()
    }


    
    // Sign up button is tapped
    @IBAction func signUpButtonDidTapped(_ sender: Any) {
        self.view.endEditing(true)
        self.validateFields()
        self.signUp(
            onSuccess: {
            // switch view
                
            }) {
            (errorMessage) in
            ProgressHUD.showError(errorMessage)
        }

    }
    
    // X -> exit the controller
    @IBAction func dismissAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    

}
