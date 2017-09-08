//
//  MessagesViewController.swift
//  ATAX
//
//  Created by Paul on 8/30/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit
import SVProgressHUD

class MessagesViewController: UIViewController {
    
    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var txt_SearchBar: UITextField!
    
    var messageList = [Message]()
    var messageSearch = [Message]()
    var currentPage:Int!
    let token = defaults.object(forKey: "tokenString") as! String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        txt_SearchBar.delegate = self
        txt_SearchBar.addTarget(self, action: #selector(self.searchResult(_:)), for: .editingChanged)
        
        //setup SlideMenu
        
        setupSlideMenu(item: menuButton, controller: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentPage = 1
        SVProgressHUD.show()
        DispatchQueue.global(qos: .background).async { 
            Message.getAllMessages(withToken: self.token, pagenumber: self.currentPage) { (messages) in
                
                self.messageList = messages!
                DispatchQueue.main.async {
                    self.messageSearch = self.messageList
                    self.messageTableView.reloadData()
                    SVProgressHUD.dismiss()
                    
                }
                
            }
        }
        
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
        cell.imgAvatar.downloadImage(url: URL_Image + messageItem.senderProfileImageUrl)
        print(URL_Image + messageItem.senderProfileImageUrl)
        
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
        let MessDetail = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "messdetailVC") as! MessageDetailViewController
        
        MessDetail.messSubject = messageItem.subject
        MessDetail.date = convertDateStringToDateFormat(longDate: messageItem.date)
        MessDetail.messContent = messageItem.messageContent
        MessDetail.messageID = messageItem.id
        MessDetail.userID = String(messageItem.userId)
        MessDetail.imageLink = messageItem.senderProfileImageUrl
        
        self.navigationController?.pushViewController(MessDetail, animated: true)
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastItem = messageSearch.count - 2
        if indexPath.section == lastItem
        {
            currentPage = currentPage + 1
            loadMore(pageNumber: currentPage)
        }
        
    }
    
    func loadMore(pageNumber: Int)
    {
        
        Message.getAllMessages(withToken: token, pagenumber: pageNumber) { (results) in
            for result in results!
            {
                self.messageList.append(result)
                DispatchQueue.main.async(execute: {
                    self.messageSearch = self.messageList
                    self.messageTableView.reloadData()
                })
            }
        }
    }
}









