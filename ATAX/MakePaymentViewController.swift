//
//  MakePaymentViewController.swift
//  ATAX
//
//  Created by QTS Coder on 8/30/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit
import SVProgressHUD

class MakePaymentViewController: UIViewController {
    
    @IBOutlet var viewData: UIView!
    @IBOutlet weak var dataTableview: UITableView!
    @IBOutlet weak var txt_taxinfo: UITextField!
    @IBOutlet weak var nameOnCard: UITextField!
    @IBOutlet weak var cardNumber: UITextField!
    @IBOutlet weak var expMonth: UITextField!
    @IBOutlet weak var expYear: UITextField!
    @IBOutlet weak var cvvCode: UITextField!
    @IBOutlet weak var btn_SelectInvoice: UIButton!
    @IBOutlet weak var imgDownlist: UIImageView!
    @IBOutlet weak var lblPay: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    var activeTF:UITextField!
    
    let token = defaults.object(forKey: "tokenString") as! String
    let contactId = defaults.object(forKey: "contactId") as! Int
    let taxid = defaults.object(forKey: "taxId") as! Int
    var listInvoice = [Invoice]()
    var invoiceId:Int?
    
    var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(contactId,taxid)
        
        SVProgressHUD.show()
        DispatchQueue.global(qos: .background).async {
            Invoice.getInvoice(withToken: self.token, contactId: self.contactId, taxId: self.taxid, completion: { (lists) in
                
                self.listInvoice = lists!
                DispatchQueue.main.async(execute: {
                    SVProgressHUD.dismiss()
                    self.dataTableview.reloadData()
                    if self.listInvoice.count == 0
                    {
                        self.txt_taxinfo.placeholder = "No invoices to pay"
                        self.txt_taxinfo.isUserInteractionEnabled = false
                        self.btn_SelectInvoice.isUserInteractionEnabled = false
                        self.imgDownlist.isHidden = true
                    }
                    else
                    {
                        self.txt_taxinfo.placeholder = "Select an invoice"
                    }
                })
            })
        }
        
        createTapGestureScrollview(withscrollview: scrollView)
        
        setupViewData()
        
        txt_taxinfo.tintColor = UIColor.clear
        
        dataTableview.dataSource = self
        dataTableview.delegate = self
        
        dataTableview.tag = 1
        dataTableview.tableFooterView = UIView(frame: .zero)
        
        nameOnCard.delegate = self
        cardNumber.delegate = self
        expYear.delegate = self
        expMonth.delegate = self
        cvvCode.delegate = self
        
        expMonth.addTarget(self, action: #selector(self.expMonthCheck), for: .editingDidEnd)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CardIOUtilities.preloadCardIO()
    }
    
    func expMonthCheck()
    {
        
        if (expMonth.text?.characters.count)! > 0
        {
            if Int(expMonth.text!)! < 10 && (expMonth.text?.characters.count)! < 2
            {
                expMonth.text = "0" + expMonth.text!
            }
            else
            {
                return
            }
            
        }
    }
    
    func setupViewData()
    {
        backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        backgroundView.backgroundColor = UIColor.gray
        backgroundView.alpha = 0
        
        view.addSubview(backgroundView)
        view.addSubview(viewData)
        
        let widthView = view.frame.size.width * (18/20)
        let heightView = view.frame.size.height * (6/8)
        
        viewData.frame = CGRect(x: view.frame.size.width * (1/20), y: view.frame.size.height * (1/8), width: widthView, height: heightView)
        
        viewData.alpha = 0
        
    }
    
    @IBAction func paymentAction(_ sender: UIButton) {
        
        let checkkey = checkValidateTextField(tf1: txt_taxinfo, tf2: nameOnCard, tf3: cardNumber, tf4: expMonth, tf5: expYear, tf6: cvvCode)
        
        switch checkkey {
        case 1:
            alertMissingText(mess: "Invoice is required", textField: nil)
            
        case 2:
            alertMissingText(mess: "Name on card is required", textField: nameOnCard)
            
        case 3:
            alertMissingText(mess: "Card number is required", textField: cardNumber)
            
        case 4:
            alertMissingText(mess: "Exp Month is required", textField: expMonth)
            
        case 5:
            alertMissingText(mess: "Exp Year is required", textField: expYear)
            
        case 6:
            alertMissingText(mess: "Security code is required", textField: cvvCode)
            
        default:
            
            checkValidateValueAndMakePayment()
        }
        
    }
    func callPaymentAPI()
    {
        Payment.makePayment(withToken: token, invoiceid: invoiceId!, cardholdername: nameOnCard.text!, cardnumber: cardNumber.text!, expirationmonth: Int(expMonth.text!)!, expirationyear: Int(expYear.text!)!, cvc: cvvCode.text!, completion: { (done) in
            
            if done
            {
                self.dismiss(animated: true, completion: {
                    self.alertMissingText(mess: "Payment successful", textField: nil)
                })
                
            }
            else
            {
                self.alertMissingText(mess: (defaults.object(forKey: "notification") as? String)!, textField: nil)
            }
            
        })
    }
    
    func checkValidateValueAndMakePayment()
    {
        if (cardNumber.text?.characters.count)! < 14
        {
            self.alertMissingText(mess: "Card Number invalid format. Range is 14-16.", textField: cardNumber)
        }
        else if Int(expMonth.text!)! < 1 || Int(expMonth.text!)! > 12
        {
            self.alertMissingText(mess: "Expiration Month invalid format. Range is 1-12.", textField: expMonth)
        }
        else if (expYear.text?.characters.count)! < 4
        {
            self.alertMissingText(mess: "Expiration Year invalid format. Field should have 4 digits.", textField: expYear)
        }
        else if (cvvCode.text?.characters.count)! < 3
        {
            self.alertMissingText(mess: "CVC code invalid format. Must be 3 or 4 digits.", textField: cvvCode)
        }
        else
        {
            self.view.endEditing(true)
            callPaymentAPI()
        }
    }
    
    @IBAction func CancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func invoiceAction(_ sender: UIButton) {
        
        createAnimatePopup(from: viewData, with: backgroundView)
        
    }
    
    @IBAction func closePopup(_ sender: UIButton) {
        viewData.alpha = 0
        self.backgroundView.alpha = 0
    }
    
    @IBAction func scanYourCard(_ sender: UIButton) {
        
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.2431372549, green: 0.4274509804, blue: 0.8745098039, alpha: 1)
        
        let scanVC = CardIOPaymentViewController(paymentDelegate: self)
        present(scanVC ?? UIViewController(), animated: true) { _ in }
        
    }
    
}

extension MakePaymentViewController: CardIOPaymentViewControllerDelegate
{
    func userDidCancel(_ paymentViewController: CardIOPaymentViewController!) {
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    func userDidProvide(_ cardInfo: CardIOCreditCardInfo!, in paymentViewController: CardIOPaymentViewController!) {
        
        self.nameOnCard.text = cardInfo.cardholderName
        self.cardNumber.text = cardInfo.cardNumber
        if cardInfo.expiryMonth < 10
        {
            self.expMonth.text = "0\(cardInfo.expiryMonth)"
        }
        else
        {
            self.expMonth.text = "\(cardInfo.expiryMonth)"
        }
        self.expYear.text = "\(cardInfo.expiryYear)"
        self.cvvCode.text = cardInfo.cvv
        
        paymentViewController.dismiss(animated: true, completion: nil)
    }
}

extension MakePaymentViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listInvoice.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InvoiceTableViewCell
        cell.lblInvoice.text = "\(listInvoice[indexPath.row].invoiceNumber)" + " - $" + "\(listInvoice[indexPath.row].totalAmount)"
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.txt_taxinfo.text = "\(listInvoice[indexPath.row].invoiceNumber)" + " - $" + "\(listInvoice[indexPath.row].subTotalAmount)"
        self.lblPay.text = "Pay $" + "\(listInvoice[indexPath.row].totalAmount)"
        self.invoiceId = listInvoice[indexPath.row].id
        self.viewData.alpha  = 0
        self.backgroundView.alpha = 0
        
    }
    
}

extension MakePaymentViewController: UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case 1...2:
            scrollView.setContentOffset(CGPoint(x: 0, y: 150), animated: true)
        default:
            scrollView.setContentOffset(CGPoint(x: 0, y: 200), animated: true)
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 1:
            cardNumber.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}




