//
//  ViewController+UI.swift
//  Pinder3
//
//  Created by LIPING on 5/7/21.
//

import UIKit

extension ViewController{
    
    func setupHeaderTitle(){
        //         TITLE PORTION
//                let title = "Create a new account"
//                let attributedText = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.init(name: "Didot", size: 28)!, NSAttributedString.Key.foregroundColor: UIColor.black])
        
        //        let subTitle = "\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi gravida massa."
        //        let attributedSubtitle = NSMutableAttributedString(string: subTitle, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor(white:0, alpha: 0.45)])

        //        attributedText.append(attributedSubtitle)
//                let paragraphStyle = NSMutableParagraphStyle()
        //        paragraphStyle.lineSpacing = 5

//                attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
//                titleLabel.numberOfLines = 0    // infinite % of lines
                
        //         apply the above code to titleLabel
//                titleLabel.attributedText = attributedText
        
                titleLabel.textAlignment = .center
    }
    
    func setupAppleButton(){
        // apple BUTTON
        // change background color
        // convert image to white apple
        signInFacebookButton.layer.cornerRadius = cornerRadiusValue
        signInFacebookButton.clipsToBounds = true
        
        signInFacebookButton.setTitle("Continue with Apple", for: UIControl.State.normal)
        signInFacebookButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
//        signInFacebookButton.backgroundColor = UIColor(red: 58/255, green: 85/255, blue: 159/255, alpha: 1)
        signInFacebookButton.setImage(UIImage(named: "icon-apple1"), for: UIControl.State.normal)
        signInFacebookButton.imageView?.contentMode = .scaleAspectFit
        signInFacebookButton.tintColor = .white
        signInFacebookButton.imageEdgeInsets = UIEdgeInsets(top: 12, left: -225, bottom: 12, right: 0)
        signInFacebookButton.titleEdgeInsets = UIEdgeInsets(top:0, left:-500.0, bottom:0.0, right:0.0)
    }
    
    func setupGoogleButton(){
        // GOOGLE BUTTON
        // change background color
        // image changes color when button is clicked
        signInGoogleButton.layer.cornerRadius = cornerRadiusValue
        signInGoogleButton.clipsToBounds = true
        
        signInGoogleButton.setTitle("Continue with Google", for: UIControl.State.normal)
        signInGoogleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
//        signInGoogleButton.backgroundColor = UIColor(red: 219/255, green: 68/255, blue: 55/255, alpha: 1)
        
        signInGoogleButton.setImage(UIImage(named: "icon-google"), for: UIControl.State.normal)
        signInGoogleButton.imageView?.contentMode = .scaleAspectFit
//        signInGoogleButton.tintColor = .white
        
        signInGoogleButton.imageEdgeInsets = UIEdgeInsets(top: 12, left: -225, bottom: 12, right: 0)
        signInGoogleButton.titleEdgeInsets = UIEdgeInsets(top:0, left:-490.0, bottom:0.0, right:0.0)
    }
    
    func setupEmailButton(){
        // Email button
        // change background color
        // conver image to white envelope
        createAccountButton.layer.cornerRadius = cornerRadiusValue
        createAccountButton.clipsToBounds = true
        
        createAccountButton.setTitle("Continue with Email", for: UIControl.State.normal)
        createAccountButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
//        createAccountButton.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
        
        createAccountButton.setImage(UIImage(named: "icon-email"), for: UIControl.State.normal)
        createAccountButton.imageView?.contentMode = .scaleAspectFit
        
        createAccountButton.imageEdgeInsets = UIEdgeInsets(top: 12, left: -225, bottom: 12, right: 0)       // 200
        createAccountButton.titleEdgeInsets = UIEdgeInsets(top:0, left:-500.0, bottom:0.0, right:0.0)       // 450
    }
    
    func setupLogInButton(){
        // OR LABEL -> have an account -> log in
        let attributedText = NSMutableAttributedString(string: "Already have an account? ",
                                                       attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor(white:0, alpha:0.65)])
        let attributedSubText = NSMutableAttributedString(string: "Log in",
                                                          attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.black])
        attributedText.append(attributedSubText)
        signInButton.setAttributedTitle(attributedText, for: UIControl.State.normal)
    }
    

    
    func setupTOSLabel(){
        // TERMS OF SERVICE
//        let boldAttribute = [NSAttributedString.Key]
        let boldAttribute = [
           NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 18.0)!
        ]
        let finalString = NSMutableAttributedString()
        let text1 = "By continuing, you agree to our\n"
        let text2 = "User Agreement"
        let text3 = " and "
        let text4 = "Privacy Policy"
        let text5 = "."
        let regularText1 = NSAttributedString(string: text1)
        let regularText2 = NSAttributedString(string: text3)
        let regularText3 = NSAttributedString(string: text5)
        let boldText1 = NSAttributedString(string: text2, attributes: boldAttribute)
        let boldText2 = NSAttributedString(string: text4, attributes: boldAttribute)
        finalString.append(regularText1)
        finalString.append(boldText1)
        finalString.append(regularText2)
        finalString.append(boldText2)
        finalString.append(regularText3)
        termsOfServiceLabel.attributedText = finalString
    }
}
    
