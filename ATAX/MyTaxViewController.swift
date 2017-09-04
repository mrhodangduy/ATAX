//
//  MyTaxViewController.swift
//  ATAX
//
//  Created by QTS Coder on 8/30/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class MyTaxViewController: UIViewController {

    @IBOutlet weak var mytaxTableView: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    
    var myTaxesList = [TaxInfomation]()
    var searchTax = [TaxInfomation]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                        
        txtSearch.delegate = self
        txtSearch.addTarget(self, action: #selector(self.searchResult(_:)), for: .editingChanged)
        
        mytaxTableView.dataSource = self
        mytaxTableView.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        let token = defaults.object(forKey: "tokenString") as! String
        print(token)
        TaxInfomation.getAllTaxes(withToken: token) { (results) in
            self.myTaxesList.removeAll()
            for result in results!
            {
                self.myTaxesList.append(result)
                DispatchQueue.main.async(execute: {
                    self.searchTax = self.myTaxesList
                    self.mytaxTableView.reloadData()
                    print(self.searchTax)
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
    func uploadDoc()
    {
        let uploadVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "uploaddocument") as! UploadDocumentViewController
        
        self.present(uploadVC, animated: true, completion: nil)
    }
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
        
        cell.btnUpload.addTarget(self, action: #selector(MyTaxViewController.uploadDoc), for: .touchUpInside)
        cell.btnMakePayment.addTarget(self, action: #selector(MyTaxViewController.makePayment), for: .touchUpInside)
        
        return cell
    }
    
}

extension MyTaxViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 10))
        headerView.backgroundColor = UIColor.clear
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

}

extension MyTaxViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.txtSearch.resignFirstResponder()
        return true
    }
}
