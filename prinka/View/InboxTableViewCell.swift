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
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
