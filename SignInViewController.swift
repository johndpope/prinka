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
    
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    
    @IBOutlet weak var signInAppleButton: UIButton!
    @IBOutlet weak var signInGoogleButton: UIButton!
    
    //bar
    @IBOutlet weak var orLabel: UILabel!
    //bar
    
    @IBOutlet weak var emailContainerView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordContainerView: UIView!
    
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var passwordButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        
        // automactically pop up a keyboard 
        emailTextField.becomeFirstResponder()
    }
    
    
    func setupUI(){
        setupBackButton()
        setupTitleLabel()
        setupSubLabel()
        setupEmailTextField()
        setupPasswordTextField()
        setupSignUpButton()
        setupSignInButton()
        setupGoogleButton()
        setupAppleButton()
        setupOrLabel()
    }

    // pop vc when X is clicked
    @IBAction func dismissAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    // called when sign in button (Continue) is clicked
    @IBAction func signInButton(_ sender: Any) {
        self.view.endEditing(true)
        
        self.validateFields()
        //call sign in from extension
        self.signIn(onSuccess: {
            // change online status
            Api.User.isOnline(bool: true)
            
            // switch view
//            (UIApplication.shared.delegate as! AppDelegate).configureInitialViewController()
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let initViewController: UIViewController = storyboard.instantiateViewController(withIdentifier: IDENTIFIER_TABBAR) as UIViewController
            initViewController.modalPresentationStyle = .fullScreen
            self.present(initViewController, animated: true, completion: nil)
            }) {
            (errorMessage) in
            ProgressHUD.showError(errorMessage)
        }
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
