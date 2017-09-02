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
    
    let documentList = Document.initData()
    
    var dataSearch = [Document]()
    var searchString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSearch = documentList
        txt_SeachDocument.delegate = self
        txt_SeachDocument.addTarget(self, action: #selector(self.searchResult(_:)), for: .editingChanged)
        
        documentTableView.dataSource = self
        documentTableView.delegate = self
        
        //setup SlideMenu
        
        setupSlideMenu(item: menuButton, controller: self)
        
    }
    func searchResult(_ textfiled:UITextField)
    {
        dataSearch.removeAll()
        if textfiled.text?.characters.count != 0
        {
            for document in documentList
            {
                let range = document.taxDocument.lowercased().range(of: textfiled.text!, options: .caseInsensitive, range: nil, locale: nil)
                
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
        
        cell.lblTaxdocument.text = dataSearch[indexPath.section].taxDocument
        cell.lbluploadDay.text = dataSearch[indexPath.section].uploadDay
        
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




