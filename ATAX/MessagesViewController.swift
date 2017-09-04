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
    
    var messageList = [Message]()
    var messageSearch = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let token = defaults.object(forKey: "tokenString") as! String
        print(token)
        Message.getAllMessages(withToken: token) { (messages) in
            
            for message in messages!
            {
                self.messageList.append(message)
                self.messageSearch = self.messageList
                self.messageTableView.reloadData()
            }
            
        }
        
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
                let range = message.subject.lowercased().range(of: textfiled.text!, options: .caseInsensitive, range: nil, locale: nil)
                
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
       
        let messageItem = messageSearch[indexPath.section]
        
        cell.lblmessTitle.text = messageItem.subject
        cell.lbldaySend.text = convertDateStringToDateFormat(longDate: messageItem.date)
        
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
        
        let messageItem = messageSearch[indexPath.section]
        print(messageItem)
        let MessDetail = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "messdetailVC") as! MessageDetailViewController
        
        MessDetail.messSubject = messageItem.subject
        MessDetail.date = convertDateStringToDateFormat(longDate: messageItem.date)
        MessDetail.messContent = messageItem.messageContent
        
        self.navigationController?.pushViewController(MessDetail, animated: true)
        
    }
    
}







