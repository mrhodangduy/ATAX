//
//  MakePaymentViewController.swift
//  ATAX
//
//  Created by QTS Coder on 8/30/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class MakePaymentViewController: UIViewController {
    
    @IBOutlet var viewData: UIView!
    @IBOutlet weak var dataTableview: UITableView!
    @IBOutlet weak var txt_taxinfo: UITextField!
    @IBOutlet weak var nameOnCard: UITextField!
    @IBOutlet weak var cardNumber: UITextField!
    @IBOutlet weak var expMonth: UITextField!
    @IBOutlet weak var expYear: UITextField!
    @IBOutlet weak var cvvCode: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    var activeTF:UITextField!

    
    var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTapGestureScrollview(withscrollview: scrollView)
        
        setupViewData()
        
        txt_taxinfo.tintColor = UIColor.clear
        
        dataTableview.dataSource = self
        dataTableview.delegate = self        
        
        dataTableview.tag = 1
        
        nameOnCard.delegate = self
        cardNumber.delegate = self
        expYear.delegate = self
        expMonth.delegate = self
        cvvCode.delegate = self
        
        
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
            alertMissingText(mess: "Maked payment", textField: nil)
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
    
}

extension MakePaymentViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return invoiceList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = invoiceList[indexPath.row]
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.txt_taxinfo.text = invoiceList[indexPath.row]
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




