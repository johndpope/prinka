//
//  InboxApi.swift
//  prinka
//
//  Created by LIPING on 5/12/21.
//


import Foundation
import Firebase

typealias InboxCompletion = (Inbox) -> Void

class InboxApi {
    func lastMessages(uid: String, onSuccess: @escaping(InboxCompletion)) {
        let ref = Database.database().reference().child(REF_INBOX).child(uid)
        ref.observe(DataEventType.childAdded) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String, Any>{
                guard let partnerId = dict["to"] as? String else{
                    return
                }
                let uid = (partnerId == Api.User.currentUserId) ? (dict["from"] as! String) : partnerId
                Api.User.getUserInfor(uid: uid, onSuccess: { (user) in
                    if let inbox = Inbox.transformInbox(dict: dict, user: user){
                        onSuccess(inbox)
                    }
                })
            }
        }
    }
}
