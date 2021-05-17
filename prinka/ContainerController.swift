//
//  ContainerController.swift
//  prinka
//
//  Created by LIPING on 5/15/21.
//

import UIKit

class ContainerController: UITableViewController{
    
    // MARK: Properties
    var menuController: UIViewController!
    
    // MARK: Init
    override func viewDidLoad(){
        print("i'm here viewDidLoad")
        super.viewDidLoad()
        configureHomeController()
         
    }
    
    // MARK: Handlers
    func configureHomeController(){
        print("i'm here configureHomeController")
        let homeController = PeopleTableViewController()
//        homeController.delegate = self
//        let controller = UINavigationController(rootViewController: homeController)
//        view.addSubview(controller.view)
//        addChild(controller)
//        controller.didMove(toParent: self)
    }
    
    func configureMenuController(){
        print("i'm here configureMenuController")
        if menuController == nil{
            // add menu controller
            menuController = LeftSideMenuController()
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
            print("Menu Controller added")
        }
    }
    
}


extension ContainerController: HomeControllerDelegate{
    func handleMenuToggle() {
        print("i'm here handleMenuToggle")
        configureMenuController()
    }
}
