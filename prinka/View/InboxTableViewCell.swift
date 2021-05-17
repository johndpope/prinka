//
//  InboxTableViewCell.swift
//  prinka
//
//  Created by LIPING on 5/12/21.
//
//This is in the "Messages" Scene

import UIKit
import Firebase

class InboxTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var onlineView: UIView!
    
    var user: User!
    
    var inboxChangeOnlineHandle: DatabaseHandle!
    var inboxChangeProfileHandle: DatabaseHandle!
    var inboxChangedMessageHandle: DatabaseHandle!
    
    var inbox: Inbox!
    var controller: MessagesTableViewController!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        onlineView.backgroundColor = UIColor.red
        onlineView.layer.borderWidth = 2
        onlineView.layer.borderColor = UIColor.white.cgColor
        onlineView.layer.cornerRadius = 15/2
        onlineView.clipsToBounds = true
    }
    
    func configureCell(uid: String, inbox: Inbox){
        self.user = inbox.user
        self.inbox = inbox
        
        avatar.loadImage(inbox.user.profileImageUrl)
        avatar.layer.cornerRadius = 30
        avatar.clipsToBounds = true
        
        usernameLabel.text = inbox.user.username
        let date = Date(timeIntervalSince1970: inbox.date)
        let dateString = timeAgoSinceDate(date, currentDate: Date(), numericDates: true)
        dateLabel.text = dateString
        
        if !inbox.text.isEmpty{
            messageLabel.text = inbox.text
        }
        else{
            messageLabel.text = "[MEDIA]"
        }

        // why is inbox.read true when the message has not been opened?
        if inbox.read == false{
            print("=====not read=====")
            print(inbox.text)
            inbox.read = true
        }
        else {
//            print("=====read=====")
//            print(inbox.text)
        }
        
        
        
        // observe inbox message
        let channelId = Message.hash(forMembers: [Api.User.currentUserId, inbox.user.uid])
        let refInbox = Database.database().reference().child(REF_INBOX).child(Api.User.currentUserId).child(channelId)
        if inboxChangedMessageHandle != nil{
            refInbox.removeObserver(withHandle: inboxChangedMessageHandle)
        }
        inboxChangedMessageHandle = refInbox.observe(.childChanged, with: { (snapshot) in
            if let snap = snapshot.value{
                self.inbox.updateData(key: snapshot.key, value: snap)
                if snapshot.key == "read" && (snapshot.value != nil) == false{
                    print("==========THIS MESSAGE HAS NOT BEEN READ==========")
                }
                self.controller.sortedInbox()
            }
        })
        
        // observe online status
        let refOnline = Ref().databaseIsOnline(uid: inbox.user.uid)
        refOnline.observeSingleEvent(of: .value) { (snapshot) in
            if let snap = snapshot.value as? Dictionary<String, Any>{
                if let active = snap["online"] as? Bool{
                    self.onlineView.backgroundColor = active == true ? .green : .red
                }
            }
        }
        if inboxChangeOnlineHandle != nil{
            refOnline.removeObserver(withHandle: inboxChangeOnlineHandle)
        }
        inboxChangeOnlineHandle = refOnline.observe(.childChanged) { (snapshot) in
            if let snap = snapshot.value{
                if snapshot.key == "online"{
                    self.onlineView.backgroundColor = (snap as! Bool) == true ? .green : .red
                }
            }
        }
        
        // observe username
        let refUser = Ref().databaseSpecificUser(uid: inbox.user.uid)
        if inboxChangeProfileHandle != nil{
            refUser.removeObserver(withHandle: inboxChangeProfileHandle)
        }
        inboxChangeProfileHandle = refUser.observe(.childChanged, with: { (snapshot) in
            if let snap = snapshot.value as? String{
                self.user.updateData(key: snapshot.key, value: snap)
                
                // reload/update the data
                self.controller.sortedInbox()
            }
        })
    }
    
    override func prepareForReuse(){
        super.prepareForReuse()
        let refOnline = Ref().databaseIsOnline(uid: self.inbox.user.uid)
        if inboxChangeOnlineHandle != nil{
            refOnline.removeObserver(withHandle: inboxChangeOnlineHandle)
        }
        
        let refUser = Ref().databaseSpecificUser(uid: inbox.user.uid)
        if inboxChangeProfileHandle != nil{
            refUser.removeObserver(withHandle: inboxChangeProfileHandle)
        }
        
        let channelId = Message.hash(forMembers: [Api.User.currentUserId, inbox.user.uid])
        let refInbox = Database.database().reference().child(REF_INBOX).child(Api.User.currentUserId).child(channelId)
        if inboxChangedMessageHandle != nil{
            refInbox.removeObserver(withHandle: inboxChangedMessageHandle)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
