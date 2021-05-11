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
        emailContainerView.layer.borderWidth = 1
        emailContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        emailContainerView.layer.cornerRadius = 5

        emailTextField.borderStyle = .none

        let placeholderAttr = NSAttributedString(string: "E-mail Address", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)])

        emailTextField.attributedPlaceholder = placeholderAttr
    }
}
