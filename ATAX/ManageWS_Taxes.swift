//
//  DefineTaxes.swift
//  ATAX
//
//  Created by Paul on 9/4/17.
//  Copyright © 2017 David. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD


struct TaxInfomation
{
    let id: Int
    let contactId:Int
    let title: String
    let year: Int
    let taxType: Int
    let status: String
    let createdDate: String
    
    enum ErrorHandle: Error {
        case missing(String)
        case invalid(String)
    }
    
    init(json: [String: AnyObject]) throws {
        guard let id = json["id"] as? Int else { throw ErrorHandle.missing("id is missing")}
        guard let contactId = json["contactId"] as? Int else { throw ErrorHandle.missing("contactId is missing")}
        guard let title = json["title"] as? String else { throw ErrorHandle.missing("title is missing")}
        guard let year = json["year"] as? Int else { throw ErrorHandle.missing("year is missing")}
        guard let taxType = json["taxType"] as? Int else { throw ErrorHandle.missing("taxType is missing")}
        guard let status = json["status"] as? String else { throw ErrorHandle.missing("status is missing")}
        guard let createdDate = json["createdDate"] as? String else { throw ErrorHandle.missing("createDate is missing")}
        
        self.id = id
        self.contactId = contactId
        self.title = title
        self.year = year
        self.taxType = taxType
        self.status = status
        self.createdDate = createdDate
        
    }
    
    static func getTaxeswithPage(withToken token:String,pageNumber:Int, completion: @escaping ([TaxInfomation]?) -> ())
    {
        let url = URL(string: URL_WS + "v1/taxes?pageNumber=" + "\(pageNumber)" + "&pageSize=20")
        let httpHeader: HTTPHeaders = ["Authorization":"Bearer \(token)"]
        
        Alamofire.request(url!, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.httpBody, headers: httpHeader).responseJSON(completionHandler: { (response) in
            
            var taxesList = [TaxInfomation]()
            
            if response.response?.statusCode == 200
            {
                let jsonResult = response.result.value as? [[String: AnyObject]]
                for taxeItem in jsonResult!
                {
                    let item = try? TaxInfomation(json: taxeItem)
                    taxesList.append(item!)
                }
                
            }
            else
            {
                print("Loi xac thuc")
            }
            
            completion(taxesList)
            
        })
                
    }
    
    static func getAllTaxes(withToken token:String, completion: @escaping ([TaxInfomation]?) -> ())
    {
        let url = URL(string: URL_WS + "v1/taxes")
        let httpHeader: HTTPHeaders = ["Authorization":"Bearer \(token)"]
        
        Alamofire.request(url!, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.httpBody, headers: httpHeader).responseJSON(completionHandler: { (response) in
            
            var taxesList = [TaxInfomation]()
            
            if response.response?.statusCode == 200
            {
                let jsonResult = response.result.value as? [[String: AnyObject]]
                for taxItem in jsonResult!
                {
                    let item = try? TaxInfomation(json: taxItem)
                    taxesList.append(item!)
                }
                
            }
            else
            {
                print("Loi xac thuc")
            }
            
            completion(taxesList)
            
        })
        
    }

    
    static func postTaxes(withToken token:String, year: Int,taxtTypeString: String, taxtype: Int, completion: @escaping (Int)-> ())
    {
        let url = URL(string: URL_WS + "v1/taxes/")
        let parameter: Parameters = ["title":"\(taxtTypeString) for \(year)","year": year,"taxtype":taxtype]
        
        let httpHeader: HTTPHeaders = ["Authorization":"Bearer \(token)","Content-Type":"application/x-www-form-urlencoded"]
        var uploadStatus:Int?
        
        SVProgressHUD.show()
        DispatchQueue.global(qos: .default).async {
            Alamofire.request(url!, method: HTTPMethod.post, parameters: parameter, encoding: URLEncoding.httpBody, headers: httpHeader).responseJSON(completionHandler: { (response) in
                if response.response?.statusCode == 200
                {
                    uploadStatus = 200
                }
                    
                else if response.response?.statusCode == 400
                {
                    uploadStatus = 400
                    let message = (response.result.value as? [String: AnyObject])?["message"] as? String
                    defaults.set(message!, forKey: "notification")
                    defaults.synchronize()
                }
                else
                {
                    uploadStatus = (response.response?.statusCode)!
                    print("Loi xac thuc")
                }
                
                completion(uploadStatus!)
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                }
                
            })
        }
        
    }
    
}

struct TaxForm {
    let display: String
    let value: Int
    let isSelected:Bool
    
    enum ErrorHandle: Error {
        case missing(String)
        case invalid(String)
    }
    
    init(json: [String: AnyObject]) throws {
        guard let display = json["display"] as? String else { throw ErrorHandle.missing("display is missing")}
        guard let value = json["value"] as? Int else { throw ErrorHandle.missing("value is missing")}
        guard let isSelected = json["isSelected"] as? Bool else { throw ErrorHandle.missing("isSelected is missing")}
        
        
        self.display = display
        self.value = value
        self.isSelected = isSelected
        
    }
    
    static func getTaxYear(withToken token:String, completion: @escaping ([TaxForm]?) ->())
    {
        let url = URL(string: URL_WS + "v1/taxes/taxformdata")
        
        let httpHeader: HTTPHeaders = ["Authorization":"Bearer \(token)","Content-Type":"application/x-www-form-urlencoded"]
        
        SVProgressHUD.show()
        DispatchQueue.global(qos: .default).async {
            Alamofire.request(url!, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.httpBody, headers: httpHeader).responseJSON(completionHandler: { (response) in
                
                var taxYear = [TaxForm]()
                
                if response.response?.statusCode == 200
                {
                    let jsonResult = response.result.value as? [String: AnyObject]
                    let jsonYears = jsonResult?["yearsDropdown"] as? [[String: AnyObject]]
                    
                    for years in jsonYears!
                    {
                        if let year = try? TaxForm(json: years)
                        {
                            taxYear.append(year)
                        }
                    }
                }
                    
                else
                {
                    
                    print("Loi xac thuc")
                }
                
                completion(taxYear)
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                }
                
            })
        }
        
    }
    
    static func getTaxTypes(withToken token:String, completion: @escaping ([TaxForm]?) ->())
    {
        let url = URL(string: URL_WS + "v1/taxes/taxformdata")
        
        let httpHeader: HTTPHeaders = ["Authorization":"Bearer \(token)","Content-Type":"application/x-www-form-urlencoded"]
        
        SVProgressHUD.show()
        DispatchQueue.global(qos: .default).async {
            Alamofire.request(url!, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.httpBody, headers: httpHeader).responseJSON(completionHandler: { (response) in
                
                var taxTypes = [TaxForm]()
                
                if response.response?.statusCode == 200
                {
                    let jsonResult = response.result.value as? [String: AnyObject]
                    let jsonTaxTypes = jsonResult?["taxTypes"] as? [[String: AnyObject]]
                    
                    for types in jsonTaxTypes!
                    {
                        if let type = try? TaxForm(json: types)
                        {
                            taxTypes.append(type)
                        }
                    }
                }
                    
                else
                {
                    
                    print("Loi xac thuc")
                }
                
                completion(taxTypes)
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                }
                
            })
        }
        
    }
        
}

struct Taxes
{
    let taxName: String
    let taxtId: Int
    let year:Int
}




