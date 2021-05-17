//
//  ChatViewController.swift
//  prinka
//
//  Created by LIPING on 5/10/21.
//

import UIKit
import FirebaseAuth
import MobileCoreServices
import AVFoundation

class ChatViewController: UIViewController {
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textContainerView: UIView!
    @IBOutlet weak var mediaButton: UIButton!
    @IBOutlet weak var audioButton: UIButton!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    var imagePartner: UIImage!
    var avatarImageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
    
    var topLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
    var partnerUsername: String!
    var partnerId: String!
    var partnerUser: User!
    
    var placeholderLabel = UILabel()
    
    var picker = UIImagePickerController()
    
    var messages = [Message]()
    
    var isActive = false
    var lastTimeOnline = ""
    
    var isTyping = false
    var timer = Timer()
    
    var refreshControl = UIRefreshControl()
    var lastMessageKey: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPicker()
        setupSendButton()
        setupInputContainer()
        setupNavigationBar()
        setupTableView()
        observeMessages()
        // Do any additional setup after loading the view.
    }

    

    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // SEND BUTTON
    @IBAction func sendButtonDidTapped(_ sender: Any) {
        if let text = inputTextView.text, text != ""{
            inputTextView.text = ""
            self.textViewDidChange(inputTextView)
            sendToFirebase(dict: ["text": text as Any])
        }
    }

    // MEDIA BUTTON
    @IBAction func mediaButtonDidTapped(_ sender: Any) {
        // alert action
        let alert = UIAlertController(title: "prinka", message: "Select source", preferredStyle:  UIAlertController.Style.actionSheet)
        
        // selection: open camera
        let camera = UIAlertAction(title: "Take a picture", style: UIAlertAction.Style.default) {(_) in
            if  UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
                self.picker.sourceType = .camera
                self.present(self.picker, animated: true, completion: nil)
            }
            else{
                print("The camera is not available (photo)")
            }

        }
        // selection: add from photo library
        let library = UIAlertAction(title: "Choose an image or a video", style: UIAlertAction.Style.default) {(_) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
                self.picker.sourceType = .photoLibrary
                self.picker.mediaTypes = [String(kUTTypeImage), String(kUTTypeMovie)]
                
                self.present(self.picker, animated: true, completion: nil)
        }
            else{
                print("The photo library is not available")
            }
        }

        // selection: add a video
        let videoCamera = UIAlertAction(title: "Take a video", style: UIAlertAction.Style.default){ (_) in
            if  UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
                self.picker.sourceType = .camera
                self.picker.mediaTypes = [String(kUTTypeMovie)]
                self.picker.videoExportPreset = AVAssetExportPresetPassthrough
                self.picker.videoMaximumDuration = 30
                self.present(self.picker, animated: true, completion: nil)
            }
            else{
                print("The camera is not available (video)")
            }
        }
        
        // cancel
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(camera)
        alert.addAction(videoCamera)
        alert.addAction(library)
        alert.addAction(cancel)
        
        
        present(alert, animated: true, completion: nil)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


