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


