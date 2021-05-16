//
//  ProfileTableViewController.swift
//  prinka
//
//  Created by LIPING on 5/12/21.
//

import UIKit
import ProgressHUD

class ProfileTableViewController: UITableViewController {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var statusLabel: UITextField!
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeDate()
        setupView()
    }
    func setupView(){
        setupAvatar()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func setupAvatar(){
        avatar.layer.cornerRadius = 40
        avatar.clipsToBounds = true
        avatar.contentMode = .scaleAspectFill
        
        
        avatar.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentPicker))
        avatar.addGestureRecognizer(tapGesture)
    }
    
    // @objc -> for #selector?
    @objc func presentPicker(){
        view.endEditing(true)
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    func observeDate(){
        Api.User.getUserInforSingleEvent(uid: Api.User.currentUserId) { (user) in
            self.usernameLabel.text = user.username
            self.emailLabel.text = user.email
            self.statusLabel.text = user.status
            self.avatar.loadImage(user.profileImageUrl)
        }
    }
    func switchView(){
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let initViewController: UIViewController = storyboard.instantiateViewController(withIdentifier: IDENTIFIER_WELCOME) as UIViewController
        initViewController.modalPresentationStyle = .fullScreen
//        self.navigationController?.popViewController(animated: true)
        self.present(initViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func logoutButtonDidTapped(_ sender: Any) {
        if Api.User.logOut(){
            switchView()
        }
        else{
            print("Error Login Out")
        }
        
    }
    
    @IBAction func saveButtonDidTapped(_ sender: Any) {
        ProgressHUD.show("Loading...")

        var dict = Dictionary<String, Any> ()
        if let username = usernameLabel.text, !username.isEmpty{
            dict["username"] = username
        }
        if let email = emailLabel.text, !email.isEmpty{
            dict["email"] = email
        }
        if let status = statusLabel.text, !status.isEmpty{
            dict["status"] = status
        }
        
        Api.User.saveUserProfile(dict: dict, onSuccess: {
            if let img = self.image {
                StorageService.savePhotoProfile(image: img, uid: Api.User.currentUserId, onSuccess: {
                    ProgressHUD.showSuccess()
                }){ (errorMessage) in
                    ProgressHUD.showError(errorMessage)
                }
            } else {
                ProgressHUD.showSuccess()
            }
            
        }) { (errorMessage) in
            ProgressHUD.showError(errorMessage)
        }
        
    }
}


// update the avatar when image is selcted
extension ProfileTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            image = imageSelected
            avatar.image = imageSelected
        }
        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            image = imageOriginal
            avatar.image = imageOriginal
        }
    
        picker.dismiss(animated: true, completion: nil)
    }
}
