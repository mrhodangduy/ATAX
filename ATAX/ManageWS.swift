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










