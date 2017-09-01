//
//  ForgotPasswordViewController.swift
//  ATAX
//
//  Created by Paul on 8/29/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var txt_Email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txt_Email.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func resetPasswordAction(_ sender: UIButton) {
        
        let emailvalidate = isValidEmail(testStr: txt_Email.text!)
        
        if txt_Email.text?.characters.count == 0
        {
            alertMissingText(mess: "Email is required", textField: txt_Email)
        }
        else if emailvalidate == false
        {
            alertMissingText(mess: "Email is incorrect format", textField: txt_Email)
        }
            
        else
        {
            print("Reset Password send")
            self.dismiss(animated: true, completion: nil)
        }
    }
   
}

extension ForgotPasswordViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txt_Email.resignFirstResponder()
        return true
    }
}
