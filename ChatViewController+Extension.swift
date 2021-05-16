//
//  ChatViewController+Extension.swift
//  prinka
//
//  Created by LIPING on 5/12/21.
//

import Foundation
import UIKit

extension ChatViewController{
    func observeMessages(){
        Api.Message.receiveMessage(from: Api.User.currentUserId, to: partnerId) { (message) in
            self.messages.append(message)
            self.sortMessages()
        }
        Api.Message.receiveMessage(from: partnerId, to: Api.User.currentUserId) { (message) in
            self.messages.append(message)
            self.sortMessages()
        }
    }
    func sortMessages(){
        messages = messages.sorted(by: { $0.date < $1.date })
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
    func setupPicker(){
        picker.delegate = self
    }
    
    func setupTableView(){
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView() // remove default line separator?
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupInputContainer(){
        // rendering media button
        let mediaImg = UIImage(named: "attachment_icon")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        mediaButton.setImage(mediaImg, for: UIControl.State.normal)
        mediaButton.tintColor = .lightGray
        
        // rendering mic button
        let micImg = UIImage(named: "mic")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        audioButton.setImage(micImg, for: UIControl.State.normal)
        audioButton.tintColor = .lightGray
        
        setupInputTextView()
        

    }
    
    func setupInputTextView(){
        inputTextView.delegate = self
        
        
        placeholderLabel.isHidden = false
        let placeholderX: CGFloat = self.view.frame.size.width / 75
        let placeholderY: CGFloat = 0
        let placeholderWidth: CGFloat = inputTextView.bounds.width - placeholderX
        let placeholderHeight: CGFloat = inputTextView.bounds.height
//        let placeholderFontSize = self.view.frame.size.width / 25
        
        placeholderLabel.frame = CGRect(x: placeholderX, y: placeholderY, width: placeholderWidth, height: placeholderHeight)
        placeholderLabel.text = "Start a message"
//        placeholderLabel.font = UIFont(name: System, size: placeholderFontSize)
        placeholderLabel.textColor = .gray
        placeholderLabel.textAlignment = .left
        
        inputTextView.addSubview(placeholderLabel)
        
//        textContainerView.layer.borderWidth = 1
//        textContainerView.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
        textContainerView.layer.cornerRadius = 16
        textContainerView.clipsToBounds = true
        
    }
    
    func setupNavigationBar(){
        navigationItem.largeTitleDisplayMode = .never
        
        // right
        let containView = UIView(frame: CGRect(x: 0, y:0, width: 36, height: 36))
        avatarImageView.image = imagePartner
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = 18
        avatarImageView.clipsToBounds = true
        containView.addSubview(avatarImageView)
        
        let rightBarButton = UIBarButtonItem(customView: containView)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        
        // left button is back arrow
        
        
        // ??
        if imagePartner != nil{
            avatarImageView.image = imagePartner
            self.observeMessages()
            self.observeActivity()
        }
        else{
            avatarImageView.loadImage(partnerUser.profileImageUrl){ (image) in
                self.imagePartner = image
                self.observeMessages()
                self.observeActivity()
            }
        }
        
        // username + active label
        updateTopLabel(bool: false)
        
        self.navigationItem.titleView = topLabel
    }
    

    func updateTopLabel(bool: Bool){
        var status = ""
        var color = UIColor()
        if bool{
            status = "Active"
            color = UIColor.green
            if isTyping{
                color = UIColor.gray
                status = "Typing..."
            }
        }
        else{
            status = "Last Active " + self.lastTimeOnline
            color = UIColor.red
        }
        print("=============" + status + "=============")
        
        topLabel.textAlignment = .center
        topLabel.numberOfLines = 0
        let attributed = NSMutableAttributedString(string: partnerUsername + "\n", attributes: [.font: UIFont.systemFont(ofSize: 17), .foregroundColor: UIColor.black])
        attributed.append(NSAttributedString(string: status, attributes: [.font: UIFont.systemFont(ofSize: 13), .foregroundColor: color]))
        topLabel.attributedText = attributed
    }
    
    
    func observeActivity(){
        let ref = Ref().databaseIsOnline(uid: partnerUser.uid)
        ref.observeSingleEvent(of: .value) { (snapshot) in
            if let snap = snapshot.value as? Dictionary<String, Any>{
                if let active = snap["online"] as? Bool{
                    self.isActive = active
                }
                if let latest = snap["latest"] as? Double{
                    self.lastTimeOnline = latest.convertDate()
                }
            }
            self.updateTopLabel(bool: self.isActive)
        }
    
        ref.observe(.childChanged) { (snapshot) in
            if let snap = snapshot.value{
                if snapshot.key == "online"{
                    self.isActive = snap as! Bool
                }
                if snapshot.key == "latest"{
                    let latest = snap as! Double
                    self.lastTimeOnline = latest.convertDate()
                }
                if snapshot.key == "typing"{
                    let typing = snap as! String
                    self.isTyping = typing == Api.User.currentUserId ? true : false
                }
                self.updateTopLabel(bool: self.isActive)
            }
        }
    }
    
    
    func sendToFirebase(dict: Dictionary<String, Any>){
        let date: Double = Date().timeIntervalSince1970
        var value = dict
        value["from"] = Api.User.currentUserId
        value["to"] = partnerId
        value["date"] = date
        value["read"] = true
        
        Api.Message.sendMessage(from: Api.User.currentUserId, to: partnerId, value: value)
    }
}



extension ChatViewController: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView){
        let spacing = CharacterSet.whitespacesAndNewlines
        if !textView.text.trimmingCharacters(in: spacing).isEmpty{
//            let text = textView.text.trimmingCharacters(in: spacing)
            sendButton.isEnabled = true
            sendButton.setTitleColor(.black, for: UIControl.State.normal)
            placeholderLabel.isHidden = true
        }
        else{
            sendButton.isEnabled = false
            sendButton.setTitleColor(.lightGray, for: UIControl.State.normal)
            placeholderLabel.isHidden = false
        }
        if !isTyping{
            Api.User.typing(from: Api.User.currentUserId, to: partnerUser.uid)
            isTyping = true
        }
        else{
            timer.invalidate()
        }
        timerTyping()
    }
    
    func timerTyping(){
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { (t) in
            Api.User.typing(from: Api.User.currentUserId, to: "")
            self.isTyping = false
        })
    }
}


extension ChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? URL{
            handleVideoSelectedForUrl(videoUrl)
        }else{
                handleImageSelectedForUrl(info)
        }
    }
    
    func handleVideoSelectedForUrl(_ url: URL){
        print(url)
        // save video data
        let videoName = NSUUID().uuidString
        StorageService.saveVideoMessage(url: url, id: videoName , onSuccess: { (anyValue) in
            if let dict = anyValue as? [String: Any]{
                self.sendToFirebase(dict: dict)
            }
        }) {(errorMessage) in
            
        }
        self.picker.dismiss(animated: true, completion: nil)
    }
    
    func handleImageSelectedForUrl(_ info: [UIImagePickerController.InfoKey: Any]){
        var selectedImageFromPicker: UIImage?
        
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            selectedImageFromPicker = imageSelected
        }
        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            selectedImageFromPicker = imageOriginal
        }
    
        // save photo data
        let imageName = NSUUID().uuidString
        
        StorageService.savePhotoMessage(image: selectedImageFromPicker, id: imageName, onSuccess: { (anyValue) in
            if let dict = anyValue as? [String: Any]{
                self.sendToFirebase(dict: dict)
            }
        }) { (errorMessage) in
            // code
        }
        
        self.picker.dismiss(animated: true, completion: nil)
    }

    
}

//
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell") as! MessageTableViewCell
        cell.playButton.isHidden = messages[indexPath.row].videoUrl == ""
        cell.configureCell(uid: Api.User.currentUserId, message: messages[indexPath.row], image: imagePartner)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 0
        let message = messages[indexPath.row]
        let text = message.text
        if !text.isEmpty {
            height = text.estimateFrameForText(text).height + 60
        }

        let heightMessage = message.height
        let widthMessage = message.width
        if heightMessage != 0, widthMessage != 0 {
            height = CGFloat(heightMessage / widthMessage * 250)
        }
        return height
    }

}



