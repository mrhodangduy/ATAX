//
//  MessageDetailViewController.swift
//  ATAX
//
//  Created by QTS Coder on 8/30/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class MessageDetailViewController: UIViewController {

    @IBOutlet weak var lblMeaageTitle: UILabel!
    @IBOutlet weak var lblMessageDay: UILabel!
    @IBOutlet weak var imgAvatar: RoundImageView!
    @IBOutlet weak var tv_message: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
            }
    
    
    @IBAction func deleteMessageAction(_ sender: Any) {
        
        displayAlert(title: nil, mess: "Do you want to delete?", type: .actionSheet)
        
    }

    func displayAlert(title: String?, mess: String?, type: UIAlertControllerStyle)
    {
        let alert = UIAlertController(title: title, message: mess, preferredStyle: type)
        let btnDell  = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            
            print("Deleted")
            
        }
        let btnCan = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(btnDell)
        alert.addAction(btnCan)
        
        self.present(alert, animated: true, completion: nil)
    }
  
   
}
