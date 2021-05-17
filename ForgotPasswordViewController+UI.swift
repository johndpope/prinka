//
//  SignUpViewController+UI.swift
//  Pinder3
//
//  Created by LIPING on 5/7/21.
//

import UIKit

extension ForgotPasswordViewController{
    func setupRequestButton(){
        requestButton.layer.cornerRadius = 25
    }
    func setupEmailTextField(){        
        emailContainerView.layer.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1).cgColor
        emailContainerView.layer.cornerRadius = 10

        emailTextField.borderStyle = .none

        let placeholderAttr = NSAttributedString(string: "Email Address", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)])

        emailTextField.attributedPlaceholder = placeholderAttr

    }
}
