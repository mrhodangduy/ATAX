//
//  ManageWS.swift
//  ATAX
//
//  Created by Paul on 9/2/17.
//  Copyright © 2017 David. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SVProgressHUD

class ManagerWS {
    
    
    
    static func login(username: String, password: String, completion: (String))
    {
        let url = URL(string: URL_WS + "token")
        let parameter: Parameters = ["grant_type":"password", "username": username, "password": password]
        let httpHeader: HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]
        
        SVProgressHUD.show()
        DispatchQueue.global(qos: .default).async(execute: {() -> Void in
            
            Alamofire.request(url!, method: HTTPMethod.post, parameters: parameter, encoding: URLEncoding.httpBody, headers: httpHeader).responseJSON { (response) in
                
                if response.response?.statusCode == 200
                {
                    
                    let json = response.result.value as! [String: AnyObject]
                    UserDefaults.standard.set(json["access_token"]!, forKey: "tokenString")
                    print(json["access_token"]!)
                    
                    print("=====\(UserDefaults.standard.object(forKey: "tokenString") as! String)\n\n")
                }
                else
                {
                    print("loi xac thuc")
                    
                }
                
                DispatchQueue.main.async(execute: {() -> Void in
                    SVProgressHUD.dismiss()
                })
            }
            
        })
        
    }
    
    static func signUpUser(firstName: String, lastName: String, email: String, phone: String, password: String)
        
    {
        let url = URL(string: URL_WS + "v1/account/register")
        
        let parameter: Parameters = ["firstname":firstName, "lastname": lastName, "email": email, "phone": phone, "password":password]
        let httpHeader: HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]
        
        Alamofire.request(url!, method: HTTPMethod.post, parameters: parameter, encoding: URLEncoding.httpBody, headers: httpHeader).responseJSON { (response) in
            print(response)
        }
    }
}










