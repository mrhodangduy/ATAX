//
//  ManagerWS_Document.swift
//  ATAX
//
//  Created by Paul on 9/4/17.
//  Copyright © 2017 David. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD


struct DocumentTypes
{
    
    let text :String
    let value:String
    let selected: Bool
    
    enum ErrorHandle: Error {
        case missing(String)
        case invalid(String)
    }
    
    init(json: [String: AnyObject]) throws {
        guard let text = json["text"] as? String else { throw ErrorHandle.missing("text is missing")}
        guard let value = json["value"] as? String else { throw ErrorHandle.missing("value is missing")}
        guard let selected = json["selected"] as? Bool else { throw ErrorHandle.missing("selected is missing")}
        
        self.text = text
        self.value = value
        self.selected = selected
        
    }
    
    static func getDocumentType(withToken token: String, completion: @escaping ([DocumentTypes]?) -> ())
    {
        let url = URL(string: URL_WS + "v1/documents/types")
        let httpHeader: HTTPHeaders = ["Authorization":"Bearer \(token)"]
        
        SVProgressHUD.show()
        DispatchQueue.global(qos: .default).async { 
            Alamofire.request(url!, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.httpBody, headers: httpHeader).responseJSON(completionHandler: { (response) in
                
                var listDocument = [DocumentTypes]()
                
                if response.response?.statusCode == 200
                {
                    let jsonResult = response.result.value as? [[String: AnyObject]]
                    for result in jsonResult!
                    {
                        if let type = try? DocumentTypes(json: result)
                        {
                            listDocument.append(type)
                        }
                    }
                }
                else
                {
                    print("Loi xac thuc")
                }
                
                completion(listDocument)
                
                DispatchQueue.main.async(execute: { 
                    SVProgressHUD.dismiss()
                })
            })
        }
    }
}


struct Documents
    
{
    let taxDocumentId: String
    let taxId:Int
    let taxDocumentTypeId: Int
    let taxpayerId:Int
    let contactId: Int
    let title: String
    let cdnPartialPath: String
    let createdDateUtc: String
    
    enum ErrorHandle: Error {
        case missing(String)
        case invalid(String)
    }
    
    init(json: [String: AnyObject]) throws {
        guard let taxDocumentId = json["taxDocumentId"] as? String else { throw ErrorHandle.missing("taxDocumentId is missing")}
        guard let taxId = json["taxId"] as? Int else { throw ErrorHandle.missing("taxId is missing")}
        guard let taxDocumentTypeId = json["taxDocumentTypeId"] as? Int else { throw ErrorHandle.missing("taxDocumentTypeId is missing")}
        guard let taxpayerId = json["taxpayerId"] as? Int else { throw ErrorHandle.missing("taxpayerId is missing")}
        guard let contactId = json["contactId"] as? Int else { throw ErrorHandle.missing("contactId is missing")}
        guard let title = json["title"] as? String else { throw ErrorHandle.missing("title is missing")}
        guard let cdnPartialPath = json["cdnPartialPath"] as? String else { throw ErrorHandle.missing("cdnPartialPath is missing")}
        guard let createdDateUtc = json["createdDateUtc"] as? String else { throw ErrorHandle.missing("createdDateUtc is missing")}
        
        
        self.taxDocumentId = taxDocumentId
        self.taxId = taxId
        self.taxDocumentTypeId = taxDocumentTypeId
        self.taxpayerId = taxpayerId
        self.contactId = contactId
        self.title = title
        self.cdnPartialPath = cdnPartialPath
        self.createdDateUtc = createdDateUtc
        
    }
    
    static func getAllDocuments(withToken token: String, completion: @escaping ([Documents]?) ->())
    {
        let url = URL(string: URL_WS + "v1/documents")
        let httpHeader: HTTPHeaders = ["Authorization":"Bearer \(token)"]

        SVProgressHUD.show()
        DispatchQueue.global(qos: .default).async {
            Alamofire.request(url!, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.httpBody, headers: httpHeader).responseJSON(completionHandler: { (response) in
                
                var documents = [Documents]()
                
                if response.response?.statusCode == 200
                {
                    let jsonResult = response.result.value as? [[String: AnyObject]]
                    for result in jsonResult!
                    {
                        if let document = try? Documents(json: result)
                        {
                            documents.append(document)
                        }
                    }
                }
                else
                {
                    print("Loi xac thuc")
                }
                
                completion(documents)
                
                DispatchQueue.main.async(execute: {
                    SVProgressHUD.dismiss()
                })
            })
        }
        
    }

}








