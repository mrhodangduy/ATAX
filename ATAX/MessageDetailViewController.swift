//
//  MessageDetailViewController.swift
//  ATAX
//
//  Created by QTS Coder on 8/30/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {
    
    @IBOutlet weak var lblMeaageTitle: UILabel!
    @IBOutlet weak var lblMessageDay: UILabel!
    @IBOutlet weak var tv_message: UITextView!
    @IBOutlet weak var imgAvatarSender: RoundImageView!
    
    var messSubject = ""
    var date = ""
    var messContent = ""
    var messageID:Int?
    var userID:String?
    var imageLink:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblMeaageTitle.text = messSubject
        lblMessageDay.text = date
        imgAvatarSender.downloadImage(url: imageLink!)
        
        do
        {
            let theAttString =  try NSAttributedString(data: messContent.data(using: String.Encoding.utf16, allowLossyConversion: true)!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSForegroundColorAttributeName: UIColor.darkGray], documentAttributes: nil)
            tv_message.attributedText = theAttString
        }
        catch
        {
            tv_message.text = messContent
        }
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tv_message.isScrollEnabled = false
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tv_message.isScrollEnabled = true
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func deleteMessageAction(_ sender: Any) {
        
        displayAlert(title: nil, mess: "Do you want to delete?", type: .actionSheet)
        
    }
    
    func displayAlert(title: String?, mess: String?, type: UIAlertControllerStyle)
    {
        let alert = UIAlertController(title: title, message: mess, preferredStyle: type)
        let btnDell  = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            
            let token = defaults.object(forKey: "tokenString") as! String
            Message.deleteMessage(withToken: token, id: self.userID!, messageId: self.messageID!, completion: { (status) in
                
                if status
                {
                    print("Deleted")
                    self.navigationController?.popViewController(animated: true)
                }
                else
                {
                    self.alertMissingText(mess: defaults.object(forKey: "notification") as! String, textField: nil)
                }
                
            })
            
        }
        let btnCan = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(btnDell)
        alert.addAction(btnCan)
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
