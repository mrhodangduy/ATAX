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
    let taxDocumentId: Int
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
        guard let taxDocumentId = json["taxDocumentId"] as? Int else { throw ErrorHandle.missing("taxDocumentId is missing")}
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
    
    static func getAllDocuments(withToken token: String,pageNumber: Int, completion: @escaping ([Documents]?) ->())
    {
        let url = URL(string: URL_WS + "v1/documents?pageNumber=" + "\(pageNumber)" + "&pageSize=15")
        let httpHeader: HTTPHeaders = ["Authorization":"Bearer \(token)"]
        
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
                            print(document)
                        }
                        
                    }
                }
                else
                {
                    print("Loi xac thuc")
                }
                
                completion(documents)
                
            })
        }
        
    }
    
    static func uploadDocumentwithImage(withToken token: String,documenttypeid: Int,taxid: Int, year: Int, file: Data?, completion: @escaping (Bool) ->())
    {
        let url = URL(string: URL_WS + "v1/documents/\(taxid)/upload")
        let parameter: Parameters = ["documenttypeid": documenttypeid,"year":year,"taxid":taxid]
        let httpHeader: HTTPHeaders = ["Authorization":"Bearer \(token)"]
        
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            
            if let data = file
            {
                multipartFormData.append(data, withName: "file", fileName: "image.png", mimeType: "image/png")
            }
            for (key , value) in parameter
            {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
        }, usingThreshold: UInt64.init(), to: url!, method: HTTPMethod.post, headers: httpHeader) { (results) in
            
            var status:Bool!
            
            switch results
            {
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                
                status = true
                upload.uploadProgress(closure: { (progress) in
                    print("Progress: \(progress.fractionCompleted)")
                    
                    if progress.fractionCompleted == 1.0
                    {
                        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (time) in
                            completion(status)
                        })
                        
                    }
                })
               
            case .failure(let error):
                
                status = false
                print("Error in upload: \(error.localizedDescription)")
                completion(status)
                
            }
            
        }
        
    }
    
    static func deleteDocument(withToken token: String, documentId: Int, completion: @escaping (Bool) -> ())
    {
        let url = URL(string: URL_WS + "v1/documents/" + "\(documentId)")
        let httpHeader: HTTPHeaders = ["Authorization":"Bearer \(token)"]
        
        SVProgressHUD.show()
        DispatchQueue.global().async {
            Alamofire.request(url!, method: HTTPMethod.delete, parameters: nil, encoding: URLEncoding.httpBody, headers: httpHeader).responseJSON(completionHandler: { (response) in
                var status:Bool?
                print((response.response?.statusCode)!)
                if response.response?.statusCode == 200
                {
                    status = true
                    print("Deleted")
                }
                else
                {
                    status = false
                    print("Deleted failed")
                }
                completion(status!)
                DispatchQueue.main.async(execute: {
                    SVProgressHUD.dismiss()
                })
            })
        }
        
    }
    
}



