//
//  SignUpViewController.swift
//  Pinder3
//
//  Created by LIPING on 5/7/21.
//

import UIKit
import ProgressHUD
class ForgotPasswordViewController: UIViewController {
    

    @IBOutlet weak var navigationBar: UINavigationBar!
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailContainerView: UIView!
    
    @IBOutlet weak var requestButton: UIButton!
    @IBOutlet weak var buttomView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    
    func setupUI(){
        setupRequestButton()
        setupEmailTextField()
    }
    // the X button action
    @IBAction func dismissAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resetPasswordDidTapped(_ sender: Any) {
        //validate the email
        guard let email = emailTextField.text, email != "" else{
            ProgressHUD.showError(ERROR_EMPTY_EMAIL_RESET)
            return
        }
        
        Api.User.resetPassword(email: email, onSuccess: {
            self.view.endEditing(true)  //dismiss keyboard
            ProgressHUD.showSuccess(SUCCESS_MAIL_RESET)
            // navigate back to the sign in vc
            self.navigationController?.popViewController(animated: true)
            
        }) {errorMessage in
            ProgressHUD.showError(errorMessage)
            
        }
        
    }
    
}
