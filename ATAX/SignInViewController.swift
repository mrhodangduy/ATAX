//
//  HomeViewController.swift
//  ATAX
//
//  Created by QTS Coder on 8/29/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit
import SVProgressHUD

class SignInViewController: UIViewController {
    
    
    @IBOutlet weak var btnsignup: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txt_Email: UITextField!
    @IBOutlet weak var txt_Password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txt_Email.delegate = self
        txt_Password.delegate = self
        
        createTapGestureScrollview(withscrollview: scrollView)
        
        setupNotification()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    func login()
    {
        let checkKey = checkValidateTextField(tf1: txt_Email, tf2: txt_Password, tf3: nil, tf4: nil, tf5: nil, tf6: nil)
        
        switch checkKey {
            
        case 1:
            alertMissingText(mess: "Email is required", textField: txt_Email)
            
        case 2:
            alertMissingText(mess: "Password is required", textField: txt_Password)
            
        default:
            
            let emailvalidate = isValidEmail(testStr: txt_Email.text!)
            
            if emailvalidate == false
            {
                alertMissingText(mess: "Email is incorrect format", textField: txt_Email)
            }
            else
            {
                let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC")
                self.present(homeVC, animated: false, completion: nil)
                
                defaults.set(true, forKey: "isLoggedin")
                
            }
            
        }

    }
    
    @IBAction func signInAction(_ sender: UIButton) {
        
        let checkKey = checkValidateTextField(tf1: txt_Email, tf2: txt_Password, tf3: nil, tf4: nil, tf5: nil, tf6: nil)
        
        switch checkKey {
            
        case 1:
            alertMissingText(mess: "Email is required", textField: txt_Email)
            
        case 2:
            alertMissingText(mess: "Password is required", textField: txt_Password)
            
        default:
            
            let emailvalidate = isValidEmail(testStr: txt_Email.text!)
            
            if emailvalidate == false
            {
                alertMissingText(mess: "Email is incorrect format", textField: txt_Email)
            }
            else
            {
                defaults.set(true, forKey: "isLoggedin")

                let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC")
                self.present(homeVC, animated: false, completion: nil)

            }
            
        }
        
    }
    
    @IBAction func SignUpAction(_ sender: Any)
    {
        let signupVC = storyboard?.instantiateViewController(withIdentifier: "signupVC") as! SignUpViewController
        self.present(signupVC, animated: true, completion: nil)
        
    }
    
    @IBAction func forgotPass(_ sender: Any) {
        
        let forgotPswVC = storyboard?.instantiateViewController(withIdentifier: "forgotPsw") as! ForgotPasswordViewController
        self.present(forgotPswVC, animated: true, completion: nil)
    }
        
}

extension SignInViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField.tag {
            
        case 1:
            txt_Password.becomeFirstResponder()
            
        case 2:
            
            login()
        
        default:
            textField.resignFirstResponder()
        }
                
        return true
    }
}






