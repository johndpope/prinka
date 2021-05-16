//
//  ViewController.swift
//  Pinder3
//
//  Created by LIPING on 5/7/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var signInFacebookButton: UIButton!  // apple button
    @IBOutlet weak var signInGoogleButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!   // email button
    
    @IBOutlet weak var termsOfServiceLabel: UILabel!
    
    
    @IBOutlet weak var backgroundView: UIImageView!
    @IBInspectable var cornerRadiusValue: CGFloat = 25.0

    // these will be applied to the UI elements when running
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
       
    }
    
    // change icon colors (time, wifi, battery, etc)
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setupUI(){
        // change this to a local
        setupHeaderTitle()
        setupLogInButton()
        // find better images for the buttons and adjust background color
        setupAppleButton()
        setupGoogleButton()
        setupEmailButton()
        
        setupTOSLabel()
        
        backgroundView.loadGif(name: "SBGB")
        
        
        
    }
    

}

