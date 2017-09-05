//
//  ManageWS_Company.swift
//  ATAX
//
//  Created by Paul on 9/5/17.
//  Copyright © 2017 David. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD

struct CompanyInfo
{
    /*
     "id": 2,
     "name": "MyTaxesDoneLive.com",
     "shortDescription": "File your taxes online today!",
     "email": "info@mytaxesdonelive.com",
     "phone": "(718) 889-3100",
     "fax": "(718) 559-4833",
     "companyWebsite": "http://mytaxesdonelive.com",
     "address": "5536 Broadway, Bronx, NY 10463",
     "facebookUrl": "https://facebook.com/mytaxesdonelive",
     "twitterUrl": "https://twitter.com/mytaxesdonelive",
     "youTubeUrl": "https://youtube.com/mytaxesdonelive"
     */
    
    let name: String
    let shortDescription:String
    let email: String
    let phone: String
    let fax: String
    let companyWebsite: String
    let address:String
    let facebookUrl:String
    let twitterUrl:String
    let youTubeUrl:String
    
    enum ErrorHandle: Error {
        case missing(String)
        case invalid(String)
    }
    
    init(json: [String: AnyObject]) throws {
        guard let name = json["name"] as? String else { throw ErrorHandle.missing("name is missing")}
        guard let shortDescription = json["shortDescription"] as? String else { throw ErrorHandle.missing("shortDescription is missing")}
        guard let email = json["email"] as? String else { throw ErrorHandle.missing("email is missing")}
        guard let phone = json["phone"] as? String else { throw ErrorHandle.missing("phone is missing")}
        guard let fax = json["fax"] as? String else { throw ErrorHandle.missing("fax is missing")}
        guard let companyWebsite = json["companyWebsite"] as? String else { throw ErrorHandle.missing("companyWebsite is missing")}
        guard let address = json["address"] as? String else { throw ErrorHandle.missing("address is missing")}
        guard let facebookUrl = json["facebookUrl"] as? String else { throw ErrorHandle.missing("facebookUrl is missing")}
        guard let twitterUrl = json["twitterUrl"] as? String else { throw ErrorHandle.missing("twitterUrl is missing")}
        guard let youTubeUrl = json["youTubeUrl"] as? String else { throw ErrorHandle.missing("youTubeUrl is missing")}
        
        self.name = name
        self.shortDescription = shortDescription
        self.email = email
        self.phone = phone
        self.fax = fax
        self.companyWebsite = companyWebsite
        self.address = address
        self.facebookUrl = facebookUrl
        self.twitterUrl = twitterUrl
        self.youTubeUrl = youTubeUrl
        
    }
    
    static func getCompanyInfo(companyId: Int, completion: @escaping (CompanyInfo?) -> ())
    {
        let url = URL(string: URL_WS + "v1/companies/\(companyId)")
        
        SVProgressHUD.show(withStatus: "Loading...")
        DispatchQueue.global(qos: .default).async { 
            Alamofire.request(url!, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: { (response) in
                
                var companyInfo:CompanyInfo?
                
                if response.response?.statusCode == 200
                {
                    let jsonreuslts = response.result.value as? [String:AnyObject]
                    if let info = try? CompanyInfo(json: jsonreuslts!)
                    {
                        companyInfo = info
                    }
                    
                }
                else
                {
                    print("NotFound Info")
                }
                completion(companyInfo!)
                DispatchQueue.main.async(execute: { 
                    SVProgressHUD.dismiss()
                })
                
            })
        }
    }
    
}
















