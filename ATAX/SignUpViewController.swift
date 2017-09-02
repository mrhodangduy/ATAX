//
//  SignUpViewController.swift
//  ATAX
//
//  Created by QTS Coder on 8/29/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var txt_Firstname: UITextField!
    @IBOutlet weak var txt_Lastname: UITextField!
    @IBOutlet weak var txt_Email: UITextField!
    @IBOutlet weak var txt_Mobilephone: UITextField!
    @IBOutlet weak var txt_password: UITextField!
    @IBOutlet weak var txt_CofirmPass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txt_Firstname.delegate = self
        txt_Lastname.delegate = self
        txt_Email.delegate = self
        txt_Mobilephone.delegate = self
        txt_password.delegate = self
        txt_CofirmPass.delegate = self
        
        createTapGestureScrollview(withscrollview: scrollView)
        
        setupNotification()
                
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
        
    }    
    
    @IBAction func mobilePhoneformat(_ sender: UITextField) {
        sender.text = formattedNumber(number: txt_Mobilephone.text!)
        
    }
    
    
    @IBAction func signUpAction(_ sender: UIButton) {
        
        let checkkey = checkValidateTextField(tf1: txt_Firstname, tf2: txt_Lastname, tf3: txt_Email, tf4: txt_Mobilephone, tf5: txt_password, tf6: txt_CofirmPass)
        
        switch checkkey {
        case 1:
            
            alertMissingText(mess: "First name is required", textField: txt_Firstname)
            
        case 2:
            
            alertMissingText(mess: "Last name is required", textField: txt_Lastname)
            
        case 3:
            
            alertMissingText(mess: "Email is required", textField: txt_Email)
            
        case 4:
            
            alertMissingText(mess: "Mobile phone is required", textField: txt_Mobilephone)
            
        case 5:
            
            alertMissingText(mess: "Password is required", textField: txt_password)
            
        case 6:
            
            alertMissingText(mess: "Confirm Password is required", textField: txt_CofirmPass)
            
        default:
            
            let emailvalidate = isValidEmail(testStr: txt_Email.text!)
            
            if txt_CofirmPass.text != txt_password.text
            {
                txt_CofirmPass.text = nil
                alertMissingText(mess: "Comfirm password does not match", textField: txt_CofirmPass)
            }
            else if emailvalidate == false
            {
                alertMissingText(mess: "Email is incorrect format", textField: txt_Email)
            }
            else
            {
                print("Sign Up Sucessfully")
                defaults.set(true, forKey: "isLoggedin")

                let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC")
                self.present(homeVC, animated: false, completion: nil)
               
                
            }
        }
        
    }
    
    func signUp()
    {
        let checkkey = checkValidateTextField(tf1: txt_Firstname, tf2: txt_Lastname, tf3: txt_Email, tf4: txt_Mobilephone, tf5: txt_password, tf6: txt_CofirmPass)
        
        switch checkkey {
        case 1:
            
            alertMissingText(mess: "First name is required", textField: txt_Firstname)
            
        case 2:
            
            alertMissingText(mess: "Last name is required", textField: txt_Lastname)
            
        case 3:
            
            alertMissingText(mess: "Email is required", textField: txt_Email)
            
        case 4:
            
            alertMissingText(mess: "Mobile phone is required", textField: txt_Mobilephone)
            
        case 5:
            
            alertMissingText(mess: "Password is required", textField: txt_password)
            
        case 6:
            
            alertMissingText(mess: "Confirm Password is required", textField: txt_CofirmPass)
            
        default:
            
            let emailvalidate = isValidEmail(testStr: txt_Email.text!)
            
            if txt_CofirmPass.text != txt_password.text
            {
                txt_CofirmPass.text = nil
                alertMissingText(mess: "Comfirm password does not match", textField: txt_CofirmPass)
            }
            else if emailvalidate == false
            {
                alertMissingText(mess: "Email is incorrect format", textField: txt_Email)
            }
            else
            {
                print("Sign Up Sucessfully")
                defaults.set(true, forKey: "isLoggedin")
                
                let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC")
                self.present(homeVC, animated: false, completion: nil)
                
                
            }
        }

    }
    
    @IBAction func gobackSignIn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension SignUpViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField.tag {
        case 1:
            txt_Lastname.becomeFirstResponder()
        case 2:
            txt_Email.becomeFirstResponder()
        case 3:
            txt_Mobilephone.becomeFirstResponder()
        case 4:
            txt_password.becomeFirstResponder()
        case 5:
            txt_CofirmPass.becomeFirstResponder()
        case 6:
            self.signUp()
        default:
            textField.resignFirstResponder()
        }
        
        return true
    }
}






