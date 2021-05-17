//
//  LeftSideMenuController.swift
//  prinka
//
//  Created by LIPING on 5/14/21.
//

import UIKit


// container controller
class LeftSideMenuController: UIViewController{
    // MARK: - Properties
    
    // MARK: - Init
    
    override func viewDidLoad(){
        super.viewDidLoad()
        print("left side")
        configureHomeController()
    }
    
    func configureHomeController(){
        let homeController = ProfileTableViewController()
        let controller = UINavigationController(rootViewController: homeController)
        
        view.addSubview(controller.view)
        addChild(controller)
        controller.didMove(toParent: self)
        
    }
    
    // MARK: - Handlers
}
