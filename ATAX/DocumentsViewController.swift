//
//  DocumentsViewController.swift
//  ATAX
//
//  Created by Paul on 8/30/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class DocumentsViewController: UIViewController {
    
    @IBOutlet weak var documentTableView: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var txt_SeachDocument: UITextField!
    
    var documentList = [Documents]()
    var dataSearch = [Documents]()
    var searchString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        txt_SeachDocument.delegate = self
        txt_SeachDocument.addTarget(self, action: #selector(self.searchResult(_:)), for: .editingChanged)
        
        documentTableView.dataSource = self
        documentTableView.delegate = self
        
        //setup SlideMenu
        
        setupSlideMenu(item: menuButton, controller: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let token = defaults.object(forKey: "tokenString") as! String
        print(token)
        Documents.getAllDocuments(withToken: token) { (results) in
            
            self.documentList = results!
            DispatchQueue.main.async(execute: {
                self.dataSearch = self.documentList
                self.documentTableView.reloadData()
            })
        }
        
    }
    
    func searchResult(_ textfiled:UITextField)
    {
        dataSearch.removeAll()
        if textfiled.text?.characters.count != 0
        {
            for document in documentList
            {
                let range = document.title.lowercased().range(of: textfiled.text!, options: .caseInsensitive, range: nil, locale: nil)
                
                if range != nil
                {
                    dataSearch.append(document)
                }
            }
        }
        else
        {
            dataSearch = documentList
        }
        documentTableView.reloadData()
    }
    
    func convertDateStringToDateFormat(longDate: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let date = dateFormatter.date(from: longDate)
        
        if date != nil
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM dd, yyyy HH:mm"
            let dateConvert = formatter.string(from: date!)
            
            return dateConvert
        }
        else
        {
            return longDate
        }
    }
    
}

extension DocumentsViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txt_SeachDocument.resignFirstResponder()
        return true
    }
}



extension DocumentsViewController: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSearch.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DocumentTableViewCell
        
        let documentItem = dataSearch[indexPath.section]
        
        cell.lblTaxdocument.text = documentItem.title
        cell.lbluploadDay.text = convertDateStringToDateFormat(longDate: documentItem.createdDateUtc)
        
        return cell
    }
}

extension DocumentsViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 10))
        headerView.backgroundColor = UIColor.clear
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
}




