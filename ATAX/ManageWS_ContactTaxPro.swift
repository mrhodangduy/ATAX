//
//  ManageWS_ContactTaxPro.swift
//  ATAX
//
//  Created by Paul on 9/5/17.
//  Copyright © 2017 David. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD

class ContactTaxPro
{
    static func SendMessSupport(withToken token: String, messContent: String, completion: @escaping (Bool) -> ())
    {
        let url = URL(string: URL_WS + "v1/support" + messContent)
        print(url!)
        let httpHeader: HTTPHeaders = ["Authorization":"Bearer \(token)"]

        SVProgressHUD.show(withStatus: "Sending...")
        DispatchQueue.global(qos: .default).async { 
            Alamofire.request(url!, method: HTTPMethod.post, parameters: nil, encoding: URLEncoding.httpBody, headers: httpHeader).responseJSON(completionHandler: { (response) in
                
                var status:Bool?
                
                if response.response?.statusCode == 200
                {
                    status = true
                    print("Mess sent!")
                }
                else
                {
                    status = false
                    print("Cannot send")
                }
                completion(status!)
                
                DispatchQueue.main.async(execute: {
                    SVProgressHUD.dismiss()
                })
            })
        }
    }
}
