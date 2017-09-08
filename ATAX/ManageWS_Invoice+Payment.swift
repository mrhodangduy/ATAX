//
//  ManageWS_Invoice+Payment.swift
//  ATAX
//
//  Created by QTS Coder on 9/8/17.
//  Copyright © 2017 David. All rights reserved.
//

/*
 "id": 18,
 "contactId": 3,
 "invoiceNumber": "INV-00018",
 "invoiceIdentity": "ce33ffdd3146436e94f39a30a741e2c7",
 "billToName": "Jose Martinez",
 "dateUtc": "2017-08-28T00:00:00",
 "dueDateUtc": "2017-08-28T00:00:00",
 "taxAmount": 0,
 "discountAmount": 0,
 "subTotalAmount": 250,
 "totalAmount": 250,
 "refundAmount": 0,
 "status": 2,
 "paymentStatus": 2,
 "paymentStatusEnum": 2,
 "invoiceStatus": 2,
 "invoicePaymentUrl": "https://mytaxesdonelive.com//invoice/pay/ce33ffdd3146436e94f39a30a741e2c7"
 */

import Foundation
import Alamofire
import SVProgressHUD

struct Invoice
{
    let id :Int
    let contactId:Int
    let invoiceNumber: String
    let invoiceIdentity:String
    let billToName: String
    let dateUtc: String
    let dueDateUtc: String
    let taxAmount: Int
    let discountAmount: Int
    let subTotalAmount: Int
    let refundAmount: Int
    let status: Int
    let paymentStatus: Int
    let paymentStatusEnum: Int
    let invoiceStatus: Int
    let invoicePaymentUrl: String
    
    enum ErrorHandle: Error {
        case missing(String)
        case invalid(String)
    }
    
    init(json: [String: AnyObject]) throws {
        guard let id = json["id"] as? Int else { throw ErrorHandle.missing("taxDocumentId is missing")}
        guard let contactId = json["contactId"] as? Int else { throw ErrorHandle.missing("contactId is missing")}
        guard let invoiceNumber = json["invoiceNumber"] as? String else { throw ErrorHandle.missing("invoiceNumber is missing")}
        guard let invoiceIdentity = json["invoiceIdentity"] as? String else { throw ErrorHandle.missing("invoiceIdentity is missing")}
        guard let billToName = json["billToName"] as? String else { throw ErrorHandle.missing("billToName is missing")}
        guard let dateUtc = json["dateUtc"] as? String else { throw ErrorHandle.missing("dateUtc is missing")}
        guard let dueDateUtc = json["dueDateUtc"] as? String else { throw ErrorHandle.missing("dueDateUtc is missing")}
        guard let taxAmount = json["taxAmount"] as? Int else { throw ErrorHandle.missing("taxAmount is missing")}
        guard let discountAmount = json["discountAmount"] as? Int else { throw ErrorHandle.missing("discountAmount is missing")}
        guard let subTotalAmount = json["subTotalAmount"] as? Int else { throw ErrorHandle.missing("subTotalAmount is missing")}
        guard let refundAmount = json["refundAmount"] as? Int else { throw ErrorHandle.missing("refundAmount is missing")}
        guard let status = json["status"] as? Int else { throw ErrorHandle.missing("status is missing")}
        guard let paymentStatus = json["paymentStatus"] as? Int else { throw ErrorHandle.missing("paymentStatus is missing")}
        guard let paymentStatusEnum = json["paymentStatusEnum"] as? Int else { throw ErrorHandle.missing("paymentStatusEnum is missing")}
        guard let invoiceStatus = json["invoiceStatus"] as? Int else { throw ErrorHandle.missing("invoiceStatus is missing")}
        guard let invoicePaymentUrl = json["invoicePaymentUrl"] as? String else { throw ErrorHandle.missing("invoicePaymentUrl is missing")}
        
        self.id = id
        self.contactId = contactId
        self.invoiceNumber = invoiceNumber
        self.invoiceIdentity = invoiceIdentity
        self.billToName = billToName
        self.dateUtc = dateUtc
        self.dueDateUtc = dueDateUtc
        self.taxAmount = taxAmount
        self.discountAmount = discountAmount
        self.subTotalAmount = subTotalAmount
        self.refundAmount = refundAmount
        self.status = status
        self.paymentStatus = paymentStatus
        self.paymentStatusEnum = paymentStatusEnum
        self.invoiceStatus = invoiceStatus
        self.invoicePaymentUrl = invoicePaymentUrl
        
    }
    
    static func getInvoice(withToken token:String, contactId:Int,taxId :Int, completion: @escaping ([Invoice]?) -> ())
    {
        let url = URL(string: URL_WS + "v1/invoices/tax/" + "\(taxId)" + "/unpaid?contactId=" + "\(contactId)" + "&taxId=" + "\(taxId)")
        print(url!)
        let httpHeader: HTTPHeaders = ["Authorization":"Bearer \(token)"]
        
        Alamofire.request(url!, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.httpBody, headers: httpHeader).responseJSON { (response) in
            
            var listInvoice = [Invoice]()
            
            if response.response?.statusCode == 200
            {
                let jsonRersult = response.result.value as? [[String: AnyObject]]
                print(jsonRersult!)
                if (jsonRersult?.count)! > 0
                {
                    for result in jsonRersult!
                    {
                        if let invoice = try? Invoice(json: result)
                        {
                            listInvoice.append(invoice)
                        }
                    }
                }
                else
                {
                    listInvoice = []
                }
                
            }
            else
            {
                print((response.error?.localizedDescription)!)
            }
            completion(listInvoice)
            print(listInvoice)
            
        }
    }
    
    
}

struct Payment
{
    static func makePayment(withToken token: String, invoiceid: Int, cardholdername: String, cardnumber: String, expirationmonth: Int, expirationyear: Int, cvc: String, completion: @escaping (Bool) -> ())
    {
        
        let url = URL(string: URL_WS + "v1/payments/\(invoiceid)/pay")
        let parameter: Parameters = ["invoiceid": invoiceid,"cardholdername":cardholdername,"cardnumber":cardnumber,"expirationmonth":expirationmonth,"expirationyear":expirationyear,"cvc":cvc]
        let httpHeader: HTTPHeaders = ["Authorization":"Bearer \(token)","Content-Type":"application/x-www-form-urlencoded"]
        
        SVProgressHUD.show(withStatus: "Processing...")
        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        DispatchQueue.global(qos: .default).async {
            Alamofire.request(url!, method: HTTPMethod.post, parameters: parameter, encoding: URLEncoding.httpBody, headers: httpHeader).responseJSON(completionHandler: { (response) in
                var status:Bool?
               
                print((response.result.value)!)
                if response.response?.statusCode == 200
                {
                    print("done")
                    status = true
                }
                else
                {
                    let jsonResult = response.result.value as? [String: AnyObject]
                    let message = jsonResult?["message"] as? String
                    defaults.set(message!, forKey: "notification")
                    defaults.synchronize()
                    status = false

                }
                completion(status!)
                DispatchQueue.main.async(execute: { 
                    SVProgressHUD.dismiss()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                })
            })
        }
    }
}











