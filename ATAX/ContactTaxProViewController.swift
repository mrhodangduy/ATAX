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
    override func viewDidLoad() {
        super.viewDidLoad()
        tv_Message.text = "Enter your message here"
        tv_Message.textColor = UIColor.lightGray
        tv_Message.delegate = self
        tv_Message.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
