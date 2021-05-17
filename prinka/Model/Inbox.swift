//
//  Inbox.swift
//  prinka
//
//  Created by LIPING on 5/10/21.
//

import Foundation

class Inbox{
    var date: Double
    var text: String
    var user: User
    var read = false
    var channel: String
    
    // initializer
    init(date: Double, text: String, user: User, read: Bool, channel: String) {
        self.date = date
        self.text = text
        self.user = user
        self.read = read
        self.channel = channel
    }
    
    static func transformInbox(dict: [String: Any], channel: String, user: User) -> Inbox?{
        guard let date = dict["date"] as? Double,
              let text = dict["text"] as? String,
//              let user = dict["user"] as? User,
              let read = dict["read"] as? Bool else{
            return nil
        }
       
        let inbox = Inbox(date: date, text: text, user: user, read: read, channel: channel)
        return inbox
    }
    
    func updateData(key: String, value: Any){
        switch key {
        case "text":
            self.text = value as! String
        case "date":
            self.date = value as! Double
        default:
            break
        }
    }
}
