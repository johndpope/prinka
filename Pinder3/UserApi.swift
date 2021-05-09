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
    func signIn(email: String, password: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void){
        Auth.auth().signIn(withEmail: email, password: password){ (authData, error) in
            if error != nil{
                onError(error!.localizedDescription)
                return
            }
            print(authData?.user.uid)
            onSuccess()
        }
    }
    
    func signUp(withUsername username: String, email: String, password: String, image: UIImage?, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void){
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
                var dict: Dictionary<String, Any> = [
                    UID: authData.user.uid,
                    EMAIL: authData.user.email,
                    USERNAME: username,
                    PROFILE_IMAGE_URL: "",
                    STATUS: "Welcome to Prinka"
                ]
                // sending the selected image to fire base
                // access the image
                guard let imageSelected = image else{
                    ProgressHUD.showError(ERROR_EMPTY_PHOTO)
                    return
                }
        
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
    
    func resetPassword(email: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void){
        Auth.auth().sendPasswordReset(withEmail: email){ (error) in
            if error == nil{
                onSuccess()
            } else{
                onError(error!.localizedDescription)
            }
        }
        
        
    }
}
