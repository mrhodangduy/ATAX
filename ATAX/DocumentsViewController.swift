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
    
    let documentList = Document.initData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        documentTableView.dataSource = self
        documentTableView.delegate = self

    }

}

extension DocumentsViewController: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return documentList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DocumentTableViewCell
        
        cell.lblTaxdocument.text = documentList[indexPath.section].taxDocument
        cell.lbluploadDay.text = documentList[indexPath.section].uploadDay
        
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




