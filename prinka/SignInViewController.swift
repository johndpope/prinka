//
//  SignUpViewController.swift
//  Pinder3
//
//  Created by LIPING on 5/7/21.
//

import UIKit
import ProgressHUD

class SignInViewController: UIViewController {


// Thread 1: "[<Pinder3.SignInViewController 0x7fac19105ac0> setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key signInLabel."
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var signInLabel: UILabel!
    
    @IBOutlet weak var middleLabel: UILabel!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    @IBOutlet weak var emailContainerView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordContainerView: UIView!
    
    @IBOutlet weak var signInButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    
    func setupUI(){
        setupTitleLabel()
        setupEmailTextField()
        setupPasswordTextField()
        setupSignUpButton()
        setupSignInButton()
    }

    // pop vc when X is clicked
    @IBAction func dismissAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // called when sign in button is clicked
    @IBAction func signInButton(_ sender: Any) {
        self.view.endEditing(true)
        
        self.validateFields()
        //call sign in from extension
        self.signIn(onSuccess: {
            // switch view
            (UIApplication.shared.delegate as! AppDelegate).configureInitialViewController()
            }) {
            (errorMessage) in
            ProgressHUD.showError(errorMessage)
        }
    }
    

}
