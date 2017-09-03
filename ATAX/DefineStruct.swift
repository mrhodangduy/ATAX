//
//  DefineStruct.swift
//  ATAX
//
//  Created by Paul on 9/2/17.
//  Copyright © 2017 David. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD


struct UserInformation
{
    
    let firstName: String
    let lastName: String
    let email:String
    let phone:String
    let fullName: String
    let imageAvatarLink: String
    
    enum ErrorHandle: Error {
        case missing(String)
        case invalid(String)
    }
    
    init(json: [String: AnyObject]) throws {
        guard let firstName = json["firstName"] as? String else { throw ErrorHandle.missing("firstName is missing")}
        guard let lastName = json["lastName"] as? String else { throw ErrorHandle.missing("lastName is missing")}
        guard let email = json["email"] as? String else { throw ErrorHandle.missing("email is missing")}
        guard let phone = json["phone"] as? String else { throw ErrorHandle.missing("phone is missing")}
        guard let fullName = json["fullName"] as? String else { throw ErrorHandle.missing("fullName is missing")}
        guard let imageAvatarLink = json["userImageFullPath"] as? String else { throw ErrorHandle.missing("imageAvatarLink is missing")}
        
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phone = phone
        self.fullName = fullName
        self.imageAvatarLink = imageAvatarLink
        
    }
    
    static func getUserInfo(withToken token:String, completion: @escaping ([UserInformation]?)->())
    {
        let url = URL(string: URL_WS + "v1/account/loginuserinfo")
        let httpHeader: HTTPHeaders = ["Authorization":"Bearer \(token)","Content-Type":"application/x-www-form-urlencoded"]
        
        Alamofire.request(url!, method: HTTPMethod.post, parameters: nil, encoding: URLEncoding.httpBody, headers: httpHeader).responseJSON { (response) in
            
            var userInfo = [UserInformation]()
            
            if response.response?.statusCode == 200
            {
                let jsonResult = response.result.value as? [String: AnyObject]
                let userInfor = try? UserInformation(json: jsonResult!)
                userInfo.append(userInfor!)
            }
            else
            {
                print("Error")
            }
            completion(userInfo)
        }
        
    }
    
    static func login(username: String, password: String, complete: @escaping (Bool) -> ())
    {
        let url = URL(string: URL_WS + "token")
        let parameter: Parameters = ["grant_type":"password", "username": username, "password": password]
        let httpHeader: HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]
        var isLoggedIn:Bool = Bool.init()
        
        SVProgressHUD.show(withStatus: "Loading...")
        DispatchQueue.global(qos: .default).async(execute: {() -> Void in
            
            Alamofire.request(url!, method: HTTPMethod.post, parameters: parameter, encoding: URLEncoding.httpBody, headers: httpHeader).responseJSON { (response) in
                
                if response.response?.statusCode == 200
                {
                    
                    let json = response.result.value as! [String: AnyObject]
                    UserDefaults.standard.set(json["access_token"]!, forKey: "tokenString")
                    print(json["access_token"]!)
                    
                    print("=====\(UserDefaults.standard.object(forKey: "tokenString") as! String)\n\n")
                    
                    let token = defaults.object(forKey: "tokenString") as! String
                    defaults.synchronize()
                    isLoggedIn = true
                    
                    getUserInfo(withToken: token, completion: { (users) in
                        
                        print(users!)
                        let fullname = users?.last?.fullName
                        let email = users?.last?.email
                        
                        defaults.set(fullname, forKey: "userName")
                        defaults.set(email, forKey: "email")
                        defaults.synchronize()
                        
                    })

                }
                else
                {
                    print("loi xac thuc")
                    isLoggedIn = false
                    
                }
                complete(isLoggedIn)
                
                DispatchQueue.main.async(execute: {() -> Void in
                    SVProgressHUD.dismiss()
                })
            }
            
        })
        
    }
    
    static func signUpUser(firstName: String, lastName: String, email: String, phone: String, password: String,complete: @escaping (Bool) -> ())

    {
        let url = URL(string: URL_WS + "v1/account/register")
        
        let parameter: Parameters = ["firstname":firstName, "lastname": lastName, "email": email, "phone": phone, "password":password]
        let httpHeader: HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]
        
        var isSignedUp:Bool = Bool.init()
        
        SVProgressHUD.show(withStatus: "Loading...")
        DispatchQueue.global(qos: .default).async { 
            Alamofire.request(url!, method: HTTPMethod.post, parameters: parameter, encoding: URLEncoding.httpBody, headers: httpHeader).responseJSON { (response) in
                print(response)
                
                if response.response?.statusCode == 200
                {
                    let jsonResult = response.result.value as? [String: AnyObject]
                    let isSucess = jsonResult?["isSuccess"] as? Bool
                    let notification = jsonResult?["notification"] as? String
                    defaults.set(notification!, forKey: "notification")
                    defaults.synchronize()
                    
                    if isSucess! == true
                    {
                        
                        isSignedUp = true
                    }
                    else
                    {
                        isSignedUp = false
                    }
                    
                    complete(isSignedUp)
                    DispatchQueue.main.async(execute: {() -> Void in
                        SVProgressHUD.dismiss()
                    })
                }
            }
        }
        
    }
    
    static func ForgotPassword(email: String, compete: @escaping (Bool) -> ())
    {
        let url = URL(string: URL_WS + "v1/account/forgotpassword?email=" + email)
        let httpHeader: HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded"]
        
        var isSentMail: Bool = Bool.init()
        
        SVProgressHUD.show(withStatus: "Sending...")
        DispatchQueue.global(qos: .default).async { 
            Alamofire.request(url!, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.httpBody, headers: httpHeader).responseJSON(completionHandler: { (response) in
                
                print(response.response!)
                
                let jsonResult = response.result.value as? [String: AnyObject]
                let isSuccess = jsonResult?["isSuccess"] as? Bool
                let notificationforgot  = jsonResult?["notification"] as? String
                defaults.set(notificationforgot!, forKey: "notification")
                defaults.synchronize()
                
                if isSuccess!
                {
                    isSentMail = true
                }
                else
                {
                    isSentMail = false
                }
                compete(isSentMail)
                DispatchQueue.main.async(execute: { 
                    SVProgressHUD.dismiss()
                })
                
            })
        }
    }

    
}

struct TaxInfomation
{
    let title: String
    let year: Int
    let taxType: Int
    let status: String
    let createDate: String
}

struct MessaseInfomation
{
    let subject: String
    let messageContent: String
    let date: String
    let status: String
    let isSuccess: Bool
    let priority: String
    let senderProfileImageUrl: String
    let from: String
}

