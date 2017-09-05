//
//  Extention-Color.swift
//  ATAX
//
//  Created by QTS Coder on 8/30/17.
//  Copyright © 2017 David. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SVProgressHUD

extension UIViewController
{
    
    func setupSlideMenu(item : UIBarButtonItem, controller: UIViewController)
    {
        item.target = revealViewController()
        item.action = #selector(SWRevealViewController.revealToggle(_:))
        
        controller.view.addGestureRecognizer(controller.revealViewController().tapGestureRecognizer())
        controller.view.addGestureRecognizer(controller.revealViewController().panGestureRecognizer())
    }
    
    func createAnimatePopup(from mainView: UIView, with backGroundView: UIView)
    {
        
        mainView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        backGroundView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 0.2, animations: {
            mainView.transform = .identity
            backGroundView.transform = .identity
        }, completion: nil)
        
        backGroundView.backgroundColor = UIColor.darkGray
        backGroundView.alpha = 0.7
        mainView.alpha = 1
        
    }
    
    func alertMissingText(mess: String, textField: UITextField?)
        
    {
        let alert = UIAlertController(title: "ATAX", message: mess, preferredStyle: .alert)
        let btnOK = UIAlertAction(title: "OK", style: .default) { (action) in
            textField?.becomeFirstResponder()
        }
        
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
    }
    
    func checkValidateTextField(tf1: UITextField? ,tf2: UITextField?,tf3: UITextField?,tf4: UITextField?,tf5: UITextField?,tf6: UITextField?) -> Int
    {
        
        if tf1?.text?.characters.count == 0
        {
            return 1
        }
        else if tf2?.text?.characters.count == 0
        {
            return 2
        }
        else if tf3?.text?.characters.count == 0
        {
            return 3
        }
        else if tf4?.text?.characters.count == 0
        {
            return 4
        }
        else if tf5?.text?.characters.count == 0
        {
            return 5
        }
        else if tf6?.text?.characters.count == 0
        {
            return 6
        }
        else
        {
            return 0
            
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    func formattedNumber(number: String) -> String {
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var mask = "(XXX) XXX XXXX"
        
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask.characters {
            if index == cleanPhoneNumber.endIndex {
                break
            }
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    func tapToClose()
    {
        view.endEditing(true)
    }
    
    func createTapGestureScrollview(withscrollview scrollView:UIScrollView)
    {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIViewController.tapToClose))
        scrollView.addGestureRecognizer(tapGesture)
    }
    
  
    
}

