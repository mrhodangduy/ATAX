//
//  MoreViewController.swift
//  ATAX
//
//  Created by Paul on 8/30/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit
import SafariServices

class MoreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func connectSocial(_ sender: UIButton) {
        
        
        if sender.tag == 1
        {
            let svc = SFSafariViewController(url: ataxLink!, entersReaderIfAvailable: false)
            svc.delegate = self
            self.present(svc, animated: true, completion: nil)
        } else if sender.tag == 2
        {
            let svc = SFSafariViewController(url: taxnewLink!, entersReaderIfAvailable: false)
            svc.delegate = self
            self.present(svc, animated: true, completion: nil)
        }
        else
        {
            let svc = SFSafariViewController(url: irsWebLink!, entersReaderIfAvailable: false)
            svc.delegate = self
            self.present(svc, animated: true, completion: nil)
        }
        
    }

    
}



extension MoreViewController: SFSafariViewControllerDelegate
{
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
