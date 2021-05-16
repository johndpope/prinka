//
//  UserTableViewCell.swift
//  prinka
//
//  Created by LIPING on 5/9/21.
//
// This is the "People" Scene

import UIKit
import Firebase

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var onlineView: UIView!
    
    var user: User!
    var inboxChangeOnlineHandle: DatabaseHandle!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avatar.layer.cornerRadius = 30
        avatar.clipsToBounds = true
        
        onlineView.backgroundColor = UIColor.red
        onlineView.alpha = 0.75 
        onlineView.layer.borderWidth = 2
        onlineView.layer.borderColor = UIColor.white.cgColor
        onlineView.layer.cornerRadius = 15/2
        onlineView.clipsToBounds = true
    }
    
    func loadData(_ user: User){
        self.user = user
        self.usernameLabel.text = user.username
        self.statusLabel.text = user.status
//        self.avatar.image = UIImage(named: "taylor_swift")
        self.avatar.loadImage(user.profileImageUrl)
        
        
        // observe online status
        let refOnline = Ref().databaseIsOnline(uid: user.uid)
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
    }
    
    override func prepareForReuse(){
        super.prepareForReuse()
        let refOnline = Ref().databaseIsOnline(uid: self.user.uid)
        if inboxChangeOnlineHandle != nil{
            refOnline.removeObserver(withHandle: inboxChangeOnlineHandle)
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
