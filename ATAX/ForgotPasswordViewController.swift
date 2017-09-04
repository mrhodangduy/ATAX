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
            
            if Connectivity.isConnectedToInternet
            {
                UserInformation.ForgotPassword(email: txt_Email.text!, compete: { (status) in
                    
                    if status
                    {
                        
                        let alert = UIAlertController(title: "ATAX", message: (defaults.object(forKey: "notification") as? String)!, preferredStyle: .alert)
                        let btnOK = UIAlertAction(title: "OK", style: .default) { (action) in
                            print("Reset Password send")
                            self.dismiss(animated: true, completion: nil)
                        }
                        
                        alert.addAction(btnOK)
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    else
                    {
                        self.alertMissingText(mess: (defaults.object(forKey: "notification") as? String)!, textField: nil)
                    }
                })
            }
            else
            {
                alertMissingText(mess: "The Internet connetion appears to be offline.", textField: nil)
            }
            
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
