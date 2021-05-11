//
//  UserTableViewCell.swift
//  prinka
//
//  Created by LIPING on 5/9/21.
//

import UIKit


class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    var user: User!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avatar.layer.cornerRadius = 30
        avatar.clipsToBounds = true
    }
    
    func loadData(_ user: User){
        self.user = user
        self.usernameLabel.text = user.username
        self.statusLabel.text = user.status
//        self.avatar.image = UIImage(named: "taylor_swift")
        self.avatar.loadImage(user.profileImageUrl)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
