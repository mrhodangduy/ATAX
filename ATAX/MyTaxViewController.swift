//
//  MyTaxViewController.swift
//  ATAX
//
//  Created by QTS Coder on 8/30/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit
import SVProgressHUD

class MyTaxViewController: UIViewController {
    
    @IBOutlet weak var mytaxTableView: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    
    var myTaxesList = [TaxInfomation]()
    var searchTax = [TaxInfomation]()
    var currentPage:Int!
    
    let token = defaults.object(forKey: "tokenString") as! String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPage = 1
        SVProgressHUD.show()
        DispatchQueue.global(qos: .default).async {
            TaxInfomation.getTaxeswithPage(withToken: self.token, pageNumber: self.currentPage!) { (results) in
                
                self.myTaxesList = results!
                DispatchQueue.main.async(execute: {
                    self.searchTax = self.myTaxesList
                    self.mytaxTableView.reloadData()
                    SVProgressHUD.dismiss()
                })
                
            }
            
        }
        
        txtSearch.delegate = self
        txtSearch.addTarget(self, action: #selector(self.searchResult(_:)), for: .editingChanged)
        
        mytaxTableView.dataSource = self
        mytaxTableView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.getTaxes), name: NSNotification.Name(rawValue: notifi_addNewTax), object: nil)
        
    }
    
    func getTaxes()
    {
        currentPage = 1
        DispatchQueue.global(qos: .default).async {
            TaxInfomation.getTaxeswithPage(withToken: self.token, pageNumber: self.currentPage!) { (results) in
                
                self.myTaxesList = results!
                DispatchQueue.main.async(execute: {
                    self.searchTax = self.myTaxesList
                    self.mytaxTableView.reloadData()
                    
                })
                
            }
            
        }
        
    }
    
    func convertDateStringToDate(longDate: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let date = dateFormatter.date(from: longDate)
        
        if date != nil
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM-dd-yyyy"
            let dateConvert = formatter.string(from: date!)
            
            return dateConvert
        }
        else
        {
            return longDate
        }
    }
    
    func searchResult(_ textfiled: UITextField)
    {
        searchTax.removeAll()
        
        if textfiled.text?.characters.count != 0
        {
            for tax in myTaxesList
            {
                let range = tax.title.lowercased().range(of: textfiled.text!, options: .caseInsensitive, range: nil, locale: nil)
                if range != nil
                {
                    searchTax.append(tax)
                }
            }
        }
        else
        {
            searchTax = myTaxesList
        }
        mytaxTableView.reloadData()
    }
    
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func newTaxAction(_ sender: Any) {
        let newTaxVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newtax") as! NewTaxViewController
        
        self.present(newTaxVC, animated: true, completion: nil)
    }
//    func uploadDoc()
//    {
//        let uploadVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "uploaddocument") as! UploadDocumentViewController
//        
//        self.present(uploadVC, animated: true, completion: nil)
//    }
    func makePayment()
    {
        let makePaymentVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "makepayment") as! MakePaymentViewController
        
        self.present(makePaymentVC, animated: true, completion: nil)
    }
}

extension MyTaxViewController: UITableViewDataSource
{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return searchTax.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTaxTableViewCell
        
        //user section instead of row
        
        let taxItem = searchTax[indexPath.section]
        
        cell.lblTaxName.text = taxItem.title
        cell.lblActive.text = taxItem.status
        cell.lblCreateday.text = "\(taxItem.year) - Created on \(convertDateStringToDate(longDate: taxItem.createdDate))"
        cell.delegateCell = self
        cell.indexPath = indexPath
        
//        cell.btnUpload.addTarget(self, action: #selector(MyTaxViewController.uploadDoc), for: .touchUpInside)
//        cell.btnMakePayment.addTarget(self, action: #selector(MyTaxViewController.makePayment), for: .touchUpInside)
        
        return cell
    }
    
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
            let lastItem = searchTax.count - 1
            
            if lastItem == indexPath.section
            {
                currentPage  = currentPage + 1
                loadMoreTaxes(pageNumber: currentPage!)
                
            }
    
        }
    
    func loadMoreTaxes (pageNumber: Int)
    {
        let activity = UIActivityIndicatorView(activityIndicatorStyle: .white)
        activity.center = self.view.center
        activity.color = .red
        activity.hidesWhenStopped = true
        view.addSubview(activity)
        
        TaxInfomation.getTaxeswithPage(withToken: token, pageNumber: pageNumber) { (results) in
            for result in results!
            {
                activity.startAnimating()
                self.myTaxesList.append(result)
                DispatchQueue.main.async {
                    self.searchTax = self.myTaxesList
                    self.mytaxTableView.reloadData()
                    activity.stopAnimating()
                    activity.removeFromSuperview()
                    
                }
                
            }
        }
    }

}

extension MyTaxViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 13))
        headerView.backgroundColor = UIColor.clear
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 13
    }
    
}

extension MyTaxViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.txtSearch.resignFirstResponder()
        return true
    }
}

extension MyTaxViewController: MyTaxDelegate
{
    func uploadDocument(cell: MyTaxTableViewCell) {
        let uploadVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "uploaddocument") as! UploadDocumentViewController
        
        self.present(uploadVC, animated: true, completion: nil)
    }
    func makePayment(cell: MyTaxTableViewCell, indexPath: IndexPath) {
        
        print(searchTax[indexPath.section].id)
        let taxid = searchTax[indexPath.section].id
        defaults.set(taxid, forKey: "taxId")
        
        let makePaymentVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "makepayment") as! MakePaymentViewController
        
        self.present(makePaymentVC, animated: true, completion: nil)
    }
}
