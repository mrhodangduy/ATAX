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
    
    let myTaxesList = MyTaxes.initData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtSearch.delegate = self
        mytaxTableView.dataSource = self
        mytaxTableView.delegate = self

        // Do any additional setup after loading the view.
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
        return myTaxesList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTaxTableViewCell
        
        cell.lblTaxName.text = myTaxesList[indexPath.section].taxName
        cell.lblCreateday.text = myTaxesList[indexPath.section].createday
        
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
