//
//  MessageTableViewCell.swift
//  prinka
//
//  Created by LIPING on 5/11/21.
//

import UIKit
import AVFoundation

class MessageTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var bubbleView: UIView!
    
    @IBOutlet weak var headerTimeLabel: UILabel!
    
    @IBOutlet weak var textMessageLabel: UILabel!
    @IBOutlet weak var photoMessage: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var bubbleWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var bubbleLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var bubbleRightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bubbleTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var bubbleBottomConstraint: NSLayoutConstraint!

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    

    var playerLayer: AVPlayerLayer?
    var player: AVPlayer?
    var message: Message!
    var prevMessage: Message!
    
    @IBAction func playButtonDidTapped(_ sender: Any) {
        handlePlay()
    }
    var observation: Any? = nil
    
    func handlePlay(){
        let videoUrl = message.videoUrl
        if videoUrl.isEmpty{
            return
        }
        if let url = URL(string: videoUrl){
            activityIndicatorView.isHidden = false
            activityIndicatorView.startAnimating()
            
            player = AVPlayer(url: url)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            playerLayer?.frame = photoMessage.frame
            
            observation = player?.addObserver(self, forKeyPath: "status", options: NSKeyValueObservingOptions.new, context: nil)
            bubbleView.layer.addSublayer(playerLayer!)
            
            player?.play()
            playButton.isHidden = true
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status"{
            let status: AVPlayer.Status = player!.status
            switch (status){
            case AVPlayer.Status.readyToPlay:
                activityIndicatorView.isHidden = true
                activityIndicatorView.stopAnimating()
                break
            case AVPlayer.Status.unknown, AVPlayer.Status.failed:
                break
            @unknown default:
                break
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textMessageLabel.numberOfLines = 0
        
        bubbleView.layer.cornerRadius = 15
        bubbleView.clipsToBounds = true
        bubbleView.layer.borderWidth = 0.4
        
        photoMessage.layer.cornerRadius = 15
        photoMessage.clipsToBounds = true
        
        profileImage.layer.cornerRadius = 16
        profileImage.clipsToBounds = true
        
        photoMessage.isHidden = true
        profileImage.isHidden = true
        textMessageLabel.isHidden = true
        
        activityIndicatorView.isHidden = true
        activityIndicatorView.stopAnimating()
        activityIndicatorView.style = UIActivityIndicatorView.Style.large
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        photoMessage.isHidden = true
        profileImage.isHidden = true
        textMessageLabel.isHidden = true
        
        if observation != nil{
            stopObservers()
        }
        playerLayer?.removeFromSuperlayer()
        player?.pause()
        playButton.isHidden = false
        
        
        activityIndicatorView.isHidden = true
        activityIndicatorView.stopAnimating()
    }
    
    func stopObservers(){
        player?.removeObserver(self, forKeyPath: "status")
        observation = nil
    }
    
    func configureCell(uid: String, message: Message, image: UIImage){
        self.message = message
        
        
        let text = message.text
        
        if !text.isEmpty{
            textMessageLabel.isHidden = false
            textMessageLabel.text = message.text
            
            let widthValue = text.estimateFrameForText(text).width + 60
            
            // about 75 if just text, 115 bc of time stamp
            bubbleWidthConstraint.constant = (widthValue < 100) ? 100 : widthValue
            dateLabel.textColor = .lightGray
            
//        if it contains a photo
        } else{
            photoMessage.isHidden = false
            photoMessage.loadImage(message.imageUrl)
            bubbleView.layer.borderColor = UIColor.clear.cgColor
            bubbleWidthConstraint.constant = 250
            dateLabel.textColor = .white
        }
        
        // message sent by current user
        if uid == message.from{
            bubbleView.backgroundColor = UIColor.systemGroupedBackground
            bubbleView.layer.borderColor = UIColor.clear.cgColor
            bubbleRightConstraint.constant = -5
            bubbleLeftConstraint.constant = UIScreen.main.bounds.width - bubbleWidthConstraint.constant - bubbleRightConstraint.constant + 10
        
        }
        // message sent by partner
        else{
            profileImage.isHidden = false
            profileImage.image = image
            
            bubbleView.backgroundColor = UIColor.white
            bubbleView.layer.borderColor = UIColor.lightGray.cgColor
            bubbleLeftConstraint.constant = 32+10+10
            bubbleRightConstraint.constant = UIScreen.main.bounds.width - bubbleWidthConstraint.constant - bubbleLeftConstraint.constant + 10
        }
        
        if prevMessage != nil{
//            bubbleBottomConstraint.constant = (message.id != prevMessage.id) ? (5) : bubbleBottomConstraint.constant
        }
        // date label timestamp set up
        let date = Date(timeIntervalSince1970: message.date)
        let dateString = timeAgoSinceDate(date, currentDate: Date(), numericDates: true)
        dateLabel.text = dateString
        
        // update header time label
        self.formatHeaderTimeLabel(time: date) { (text) in
            self.headerTimeLabel.text = text
        }
        
        prevMessage = message
    }
    
    func formatHeaderTimeLabel(time: Date, completion: @escaping (String) -> ()){
        var text = ""
        let currentDate = Date()
        let currentDateString = currentDate.toString(dateFormat: "yyyyMMdd")
        let pastDateString = time.toString(dateFormat: "yyyyMMdd")
        print(currentDate)
        print(pastDateString)
        if pastDateString.elementsEqual(currentDateString)  == true {
            text = time.toString(dateFormat: "HH:mm a") + ", Today"
        }
        else{
            text = time.toString(dateFormat: "dd/MM/yyyy")
        }
        completion(text)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}

