//
//  UserApi.swift
//  Pinder3
//
//  Created by LIPING on 5/8/21.
//

import Foundation
import FirebaseAuth
import Firebase
import ProgressHUD
import FirebaseStorage
import FirebaseDatabase

class UserApi{
    var currentUserId: String{
        return Auth.auth().currentUser != nil ? Auth.auth().currentUser!.uid : ""
    }
    
    func signIn(email: String, password: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void){
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password){ (authData, error) in
            if error != nil{
                onError(error!.localizedDescription)
                return
            }
            onSuccess()
        }
    }
    
    func signUp(withUsername username: String, email: String, password: String, image: UIImage?, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void){
        guard let imageSelected = image else{
            ProgressHUD.showError(ERROR_EMPTY_PHOTO)
            return
        }
        
        // this returns an instance of auth class
        Auth.auth().createUser(withEmail: email, password: password){
            (authDataResult, error) in
            // error exists
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            
            // no error
            if let authData = authDataResult{
                
                // create a dictionary to store user data
                // will be stored as .json in the database
                let dict: Dictionary<String, Any> = [
                    UID: authData.user.uid,
                    EMAIL: authData.user.email ?? "",
                    USERNAME: username,
                    PROFILE_IMAGE_URL: "",
                    STATUS: "Welcome to Prinka"
                ]
                // sending the selected image to fire base
                // access the image

        
                guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else{
                    return
                }
                
                let storageProfile = Ref().storageSpecificProfile(uid: authData.user.uid)
                
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpg"
                
                StorageService.savePhoto(username: username, uid: authData.user.uid, data: imageData, metadata: metadata, storageProfileRef: storageProfile, dict: dict,
                                         onSuccess: {
                                            onSuccess()
                                         },
                                         onError: {
                                            (errorMessage) in
                                            onError(errorMessage)
                                         })
            }
        }
    }
    
    
    func saveUserProfile(dict: Dictionary<String, Any>, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void){
        Ref().databaseSpecificUser(uid: Api.User.currentUserId).updateChildValues(dict){ (error, dataRef) in
            if error != nil{
                onError(error!.localizedDescription)
                return
            }
            onSuccess()
        }
        
    }
    
    
    func resetPassword(email: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void){
        Auth.auth().sendPasswordReset(withEmail: email){ (error) in
            if error == nil{
                onSuccess()
            } else{
                onError(error!.localizedDescription)
            }
        }
    }
    
    func logOut() -> Bool{
        do{
            // change online status
            Api.User.isOnline(bool: false)
            
            try Auth.auth().signOut()
//            Messaging.messaging().unsubscribe(fromTopic: uid)
        }
        catch{
            ProgressHUD.showError(error.localizedDescription)
            return false
        }
        return true
        // return to welcome vc
//        (UIApplication.shared.delegate as! AppDelegate).configureInitialViewController()

    }

    
    func observeUsers(onSuccess: @escaping(UserCompletion)){
        Ref().databaseUsers.observe(.childAdded) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String, Any>{
                if let user = User.transformUser(dict: dict){
                    if user.uid != Api.User.currentUserId{  // to hide current user from the list
                        onSuccess(user)
                        
                    }
                }
                
                
            }
        }
    }
    
    func getUserInforSingleEvent(uid: String, onSuccess: @escaping(UserCompletion)){
        let ref = Ref().databaseSpecificUser(uid: uid)
        ref.observeSingleEvent(of: .value) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String, Any>{
                if let user = User.transformUser(dict: dict){
                    onSuccess(user)
                }
            }
        }
    }
    
    func getUserInfor(uid: String, onSuccess: @escaping(UserCompletion)){
        let ref = Ref().databaseSpecificUser(uid: uid)
        ref.observe(.value) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String, Any>{
                if let user = User.transformUser(dict: dict){
                    onSuccess(user)
                }
            }
        }
    }
    
    func isOnline(bool: Bool){
        print("entering")
        if !Api.User.currentUserId.isEmpty{
            let ref = Ref().databaseIsOnline(uid: Api.User.currentUserId)
            let dict: Dictionary<String, Any> = [
                "online": bool as Any,
                "latest": Date().timeIntervalSince1970 as Any
            ]
            ref.updateChildValues(dict)
            print("updated")
        }
        else{
            print("id is empty")
            
        }
    }
    
    func typing(from: String, to: String){
        let ref = Ref().databaseIsOnline(uid: from)
        let dict: Dictionary<String, Any> = [
            "typing": to
        ]
        ref.updateChildValues(dict)
    }
}

    typealias UserCompletion = (User) -> Void
