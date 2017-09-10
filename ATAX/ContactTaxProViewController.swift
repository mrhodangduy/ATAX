//
//  ContactTaxProViewController.swift
//  ATAX
//
//  Created by QTS Coder on 8/30/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class ContactTaxProViewController: UIViewController {
    
    @IBOutlet weak var tv_Message: RoundTextView!
    @IBOutlet weak var scrollView: UIScrollView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tv_Message.text = "Enter your message here"
        tv_Message.textColor = UIColor.lightGray
        tv_Message.delegate = self
        
        createTapGestureScrollview(withscrollview: scrollView)
        
        
    }
    
    @IBAction func sendMessageAction(_ sender: UIButton) {
        
        // Encode message content, avoid killing app when return line.
        
        let queryItem = URLQueryItem(name: "messageContent", value: tv_Message.text)
        var urlComponents = URLComponents()
        urlComponents.queryItems = [queryItem]
        let messContent = urlComponents.url
        
        self.view.endEditing(true)
        if Connectivity.isConnectedToInternet
        {
            if (tv_Message.textColor == UIColor.lightGray) || tv_Message.text.characters.count == 0
            {
                alertMissingText(mess: "Message is required.", textField: nil)
                tv_Message.becomeFirstResponder()
            }
                
            else
            {
                let token = defaults.object(forKey: "tokenString") as! String
                ContactTaxPro.SendMessSupport(withToken: token, messContent: "\(messContent!)", completion: { (status) in
                    
                    if status
                    {
                        self.dismiss(animated: true, completion: nil)
                        self.alertMissingText(mess: "Messages sent.", textField: nil)
                    }
                    else
                    {
                        self.alertMissingText(mess: "Can not send messages.", textField: nil)
                    }
                })
                
            }
            
        }
        else
            
        {
            alertMissingText(mess: "The Internet connetion appears to be offline.", textField: nil)
        }
        
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

extension ContactTaxProViewController: UITextViewDelegate
{
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if tv_Message.textColor == UIColor.lightGray
        {
            tv_Message.text = nil
            tv_Message.textColor = UIColor.black
        }
        scrollView.setContentOffset(CGPoint(x: 0, y: 70), animated: true)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if tv_Message.text.isEmpty
        {
            tv_Message.text = "Enter your message here"
            tv_Message.textColor = UIColor.lightGray
        }
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
}
