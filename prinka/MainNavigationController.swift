//
//  MainNavigationController.swift
//  prinka
//
//  Created by LIPING on 5/13/21.
//
//
//import UIKit
//import Firebase
//import FirebaseAuth
//
//class MainNavigationController: UINavigationController{
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//        let isLoggedIn = Auth.auth().currentUser != nil
//
//        if isLoggedIn{
//            // ...
//        }
//        else{
//            perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
//        }
//
//    }
//    @objc func showLoginController(){
//        let loginController = ViewController()
//        present(loginController, animated: true, completion: {
//            // ...
//        })
//    }
//}
