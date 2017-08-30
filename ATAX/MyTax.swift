//
//  MyTax.swift
//  ATAX
//
//  Created by QTS Coder on 8/30/17.
//  Copyright © 2017 David. All rights reserved.
//

import Foundation


struct MyTaxes {
    let taxName: String
    let createday: String
    
    static func initData() -> [MyTaxes]
    {
        let taxName = "SelfEmployedSchedule for 2014"
        let createDay = "2014 - Create on 08-08-2017"
        
        let mytax = MyTaxes(taxName: taxName, createday: createDay)
        
        let mytaxs = [MyTaxes](repeatElement(mytax, count: 10))
        
        return mytaxs
        
    }
}

struct Document {
    let taxDocument: String
    let uploadDay: String
    
    static func initData() -> [Document]
    {
        let taxDocument = "Tax Document 2017"
        let uploadDay = "August 01, 2017 12:00"
        
        let item = Document(taxDocument: taxDocument, uploadDay: uploadDay)
        let tax = [Document](repeatElement(item, count: 10))
        
        return tax
    }
}

struct Message {
    let messageTitle: String
    let sendDay: String
    
    static func initData() -> [Message]
    {
        let taxDocument = "Message Title"
        let uploadDay = "August 01, 2017 12:00"
        
        let item = Message(messageTitle: taxDocument, sendDay: uploadDay)
        let tax = [Message](repeatElement(item, count: 10))
        
        return tax
    }
}
