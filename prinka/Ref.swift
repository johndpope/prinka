//
//  Ref.swift
//  Pinder3
//
//  Created by LIPING on 5/8/21.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage

let REF_USER = "users"
let REF_MESSAGE = "messages"

let URL_STORAGE_ROOT = "gs://prinka-fc6f2.appspot.com"
let STORAGE_PROFILE = "profile"
let PROFILE_IMAGE_URL = "profileImageUrl"
let UID = "uid"
let EMAIL = "email"
let USERNAME = "username"
let STATUS = "status"

let ERROR_EMPTY_PHOTO = "Please choose your profile image!"
let ERROR_EMPTY_EMAIL = "Please enter an email address"
let ERROR_EMPTY_USERNAME = "Please enter an username"
let ERROR_EMPTY_PASSWORD = "Please enter a password"

let ERROR_EMPTY_EMAIL_RESET = "Please enter an email address for password reset"
let SUCCESS_MAIL_RESET = "We have just sent you a password reset email. Please check your inbox and follow the instructions to reset your password."

let IDENTIFIER_TABBAR = "TabBarVC"
let IDENTIFIER_WELCOME = "WelcomeVC"
let IDENTIFIER_CHAT = "ChatVC"

let IDENTIFIER_CELL_USERS = "UserTableViewCell"




class Ref{
    let databaseRoot: DatabaseReference = Database.database().reference()
    
    var databaseUsers: DatabaseReference{
        return databaseRoot.child(REF_USER)
    }
    func databaseSpecificUser(uid: String) -> DatabaseReference{
        return databaseUsers.child(uid)
    }
    
    var databaseMessage: DatabaseReference{
        return databaseRoot.child(REF_MESSAGE)
    }
    func databaseMessageSendTo(from: String, to: String) -> DatabaseReference{
        return databaseMessage.child(from).child(to)
    }
    // Storage Ref
    
    let storageRoot = Storage.storage().reference(forURL: URL_STORAGE_ROOT)
    
    var storageProfile: StorageReference{
        return storageRoot.child(STORAGE_PROFILE)
    }
    var storageMessage: StorageReference{
        return storageRoot.child(REF_MESSAGE)
    }
    func storageSpecificProfile(uid: String) -> StorageReference{
        return storageProfile.child(uid)
    }
    
    func storageSpecificImageMessage(id: String) -> StorageReference{
        return storageMessage.child("photo").child(id)
    }
}
