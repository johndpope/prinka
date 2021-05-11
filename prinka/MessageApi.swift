//
//  MessageApi.swift
//  prinka
//
//  Created by LIPING on 5/10/21.
//

import Foundation
import Firebase

class MessageApi{
    func sendMessage(from: String, to: String, value: Dictionary<String, Any>){
        let ref = Ref().databaseMessageSendTo(from: from, to: to)
        ref.childByAutoId().updateChildValues(value)
    }
}
