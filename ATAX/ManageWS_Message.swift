//
//  ManageWS_Message.swift
//  ATAX
//
//  Created by Paul on 9/4/17.
//  Copyright © 2017 David. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD

struct Message
{
    let id:Int
    let userId: Int
    let subject: String
    let messageContent: String
    let date: String
    let status: String
    let isSuccess: Bool
    let priority: String
    let senderProfileImageUrl: String
    
    enum ErrorHandle: Error {
        case missing(String)
        case invalid(String)
    }
    
    init(json: [String: AnyObject]) throws {
        guard let id = json["id"] as? Int else { throw ErrorHandle.missing("id is missing")}
        guard let userId = json["userId"] as? Int else { throw ErrorHandle.missing("userId is missing")}
        guard let subject = json["subject"] as? String else { throw ErrorHandle.missing("subject is missing")}
        guard let messageContent = json["messageContent"] as? String else { throw ErrorHandle.missing("messageContent is missing")}
        guard let date = json["date"] as? String else { throw ErrorHandle.missing("date is missing")}
        guard let status = json["status"] as? String else { throw ErrorHandle.missing("status is missing")}
        guard let isSuccess = json["isSuccess"] as? Bool else { throw ErrorHandle.missing("isSuccess is missing")}
        guard let priority = json["priority"] as? String else { throw ErrorHandle.missing("priority is missing")}
        guard let senderProfileImageUrl = json["senderProfileImageUrl"] as? String else { throw ErrorHandle.missing("senderProfileImageUrl is missing")}
        
        self.id = id
        self.userId = userId
        self.subject = subject
        self.messageContent = messageContent
        self.date = date
        self.status = status
        self.isSuccess = isSuccess
        self.priority = priority
        self.senderProfileImageUrl = senderProfileImageUrl
        
    }
    
    static func getAllMessages(withToken token:String,pagenumber:Int, completion: @escaping ([Message]?)-> ())
    {
        let url = URL(string: URL_WS + "v1/messages?pageNumber=" + "\(pagenumber)" + "&pageSize=20")
        let httpHeader: HTTPHeaders = ["Authorization":"Bearer \(token)"]
        
        SVProgressHUD.show()
        DispatchQueue.global(qos: .default).async {
            Alamofire.request(url!, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.httpBody, headers: httpHeader).responseJSON(completionHandler: { (response) in
                
                var messages = [Message]()
                
                if response.response?.statusCode == 200
                {
                    let jsonResults = response.result.value as? [String: AnyObject]
                    let json = jsonResults?["messages"] as? [[String: AnyObject]]
                    for result in json!
                    {
                        if let message = try? Message(json: result)
                        {
                            messages.append(message)
                        }
                    }
                }
                else
                {
                    print("Loi xac thuc")
                }
                
                completion(messages)
                
                DispatchQueue.main.async(execute: {
                    SVProgressHUD.dismiss()
                })
            })
        }

    }
    
    static func deleteMessage(withToken token: String, id: String, messageId: Int, completion: @escaping (Bool) ->())
    {
        let url = URL(string: URL_WS + "v1/messages/\(id)?messageId=\(messageId)")
        let httpHeader: HTTPHeaders = ["Authorization":"Bearer \(token)"]
        
        Alamofire.request(url!, method: HTTPMethod.delete, parameters: nil, encoding: URLEncoding.httpBody, headers: httpHeader).responseJSON { (response) in
            
            var delStatus:Bool?
            
            if response.response?.statusCode == 200
            {
                let jsonResult = response.result.value as? [String: AnyObject]
                let isSuccess = jsonResult?["isSuccess"] as? Bool
                defaults.set(jsonResult?["notification"], forKey: "notification")
                defaults.synchronize()
                delStatus = isSuccess!
            }
            else
            {
                print("Loi xac thuc")
            }
            completion(delStatus!)
            
        }
    }
    
}


