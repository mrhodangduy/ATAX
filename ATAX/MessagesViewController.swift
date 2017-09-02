//
//  MessagesViewController.swift
//  ATAX
//
//  Created by Paul on 8/30/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController {

    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var txt_SearchBar: UITextField!
    
    let messageList = Message.initData()
    var messageSearch = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageSearch = messageList

        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        txt_SearchBar.delegate = self
        txt_SearchBar.addTarget(self, action: #selector(self.searchResult(_:)), for: .editingChanged)
        
        //setup SlideMenu
        
        setupSlideMenu(item: menuButton, controller: self)
    }
    func searchResult(_ textfiled:UITextField)
    {
        messageSearch.removeAll()
        if textfiled.text?.characters.count != 0
        {
            for message in messageList
            {
                let range = message.messageTitle.lowercased().range(of: textfiled.text!, options: .caseInsensitive, range: nil, locale: nil)
                
                if range != nil
                {
                    messageSearch.append(message)
                }
            }
        }
        else
        {
            messageSearch = messageList
        }
        messageTableView.reloadData()
    }

}
extension MessagesViewController:UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txt_SearchBar.resignFirstResponder()
        return true
    }
}

extension MessagesViewController: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return messageSearch.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MessageTableViewCell
        
        cell.lblmessTitle.text = messageSearch[indexPath.section].messageTitle
        cell.lbldaySend.text = messageSearch[indexPath.section].sendDay
        
        return cell
    }
    
    
    
}

extension MessagesViewController: UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 10))
        headerView.backgroundColor = UIColor.clear
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        view.endEditing(true)
    }
    
}







