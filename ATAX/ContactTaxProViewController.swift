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
        
        setupNotification()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func sendMessageAction(_ sender: UIButton) {
        
        if (tv_Message.textColor == UIColor.lightGray) && tv_Message.text.isEmpty
        {
            alertMissingText(mess: "Message is required", textField: nil)
            tv_Message.becomeFirstResponder()
        }
        else
        {
            print("Your message is sent")
            dismiss(animated: true, completion: nil)

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
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if tv_Message.text.isEmpty
        {
            tv_Message.text = "Enter your message here"
            tv_Message.textColor = UIColor.lightGray
        }
    }
    
}
