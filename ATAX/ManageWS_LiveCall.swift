//
//  ManageWS_LiveCall.swift
//  ATAX
//
//  Created by Paul on 9/10/17.
//  Copyright © 2017 David. All rights reserved.
//

import Foundation
import Alamofire

/*
 "roomName": "live-video-room-37",
 "videoToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImN0eSI6InR3aWxpby1mcGE7dj0xIn0.eyJpc3MiOiJTSzg5ODViNTViN2FiYjdlZTg3MTg1MTc1MGIzNzY4MzM2IiwiZXhwIjoxNTA1MDYwMjI2LCJqdGkiOiJTSzg5ODViNTViN2FiYjdlZTg3MTg1MTc1MGIzNzY4MzM2LTE1MDUwNTY2MjYiLCJzdWIiOiJBQ2EwZTc5N2UzOGMyMDM3ZTliN2ExNTlmMWJhZWJmYmFmIiwiZ3JhbnRzIjp7ImlkZW50aXR5IjoiRHV5IEhvIiwidmlkZW8iOnsicm9vbSI6ImxpdmUtdmlkZW8tcm9vbS0zNyJ9fX0.xJjI-ABpHPLoMwY1nQNkGRVNhiTBzb7ors8NjJBbcb0",
 "organizerContactId": 30,
 "organizerFirstName": "wayne4",
 "organizerLastName": "Tat",
 "participantContactId": 37,
 "participantFirstName": "Duy",
 "participantLastName": "Ho"
 */

struct LiveCall
{
    let roomName: String
    let videoToken:String
//    let organizerContactId: Int
//    let organizerFirstName: String
//    let organizerLastName: String
//    let participantContactId: Int
//    let participantFirstName: String
//    let participantLastName: String
    
    
    enum ErrorHandle: Error {
        case missing(String)
        case invalid(String)
    }
    
    init(json: [String: AnyObject]) throws {
        guard let roomName = json["roomName"] as? String else { throw ErrorHandle.missing("roomName is missing")}
        guard let videoToken = json["videoToken"] as? String else { throw ErrorHandle.missing("videoToken is missing")}
//        guard let organizerContactId = json["organizerContactId"] as? Int else { throw ErrorHandle.missing("organizerContactId is missing")}
//        guard let organizerFirstName = json["organizerFirstName"] as? String else { throw ErrorHandle.missing("organizerFirstName is missing")}
//        guard let organizerLastName = json["organizerLastName"] as? String else { throw ErrorHandle.missing("organizerLastName is missing")}
//        guard let participantContactId = json["status"] as? Int else { throw ErrorHandle.missing("participantContactId is missing")}
//        guard let participantFirstName = json["participantFirstName"] as? String else { throw ErrorHandle.missing("participantFirstName is missing")}
//        guard let participantLastName = json["participantLastName"] as? String else { throw ErrorHandle.missing("participantLastName is missing")}
        
        
        self.roomName = roomName
        self.videoToken = videoToken
//        self.organizerContactId = organizerContactId
//        self.organizerFirstName = organizerFirstName
//        self.organizerLastName = organizerLastName
//        self.participantContactId = participantContactId
//        self.participantFirstName = participantFirstName
//        self.participantLastName = participantLastName
//        
        
    }
    
    static func getVideoSession(withToken token:String, contactId: Int, completion: @escaping ((LiveCall)?) -> ())
        
    {
        let url = URL(string: URL_WS + "v1/live/video/session/\(contactId)")
        let httpHeader: HTTPHeaders = ["Authorization":"Bearer \(token)"]
        
        Alamofire.request(url!, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.httpBody, headers: httpHeader).responseJSON { (response) in
            var livecall: LiveCall?
                        
            switch response.result
            {
            case .success(let jsonresult ):
                
                print(jsonresult)
                
                if let result = try? LiveCall(json: (jsonresult as? [String: AnyObject])!)
                {
                    livecall = result
                }
                
            case .failure(let error):
                
                print(error.localizedDescription)
                livecall = nil
                
            }
            completion(livecall)
            
            
        }
        
    }
    
    
    
    
    
    
    
    
    
}
