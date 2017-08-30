//
//  OurOfficeViewController.swift
//  ATAX
//
//  Created by QTS Coder on 8/30/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit
import SafariServices

class OurOfficeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func sendMessageAction(_ sender: Any) {
        
        let contacttaxproVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "contacttaxpro") as! ContactTaxProViewController
        
        self.present(contacttaxproVC, animated: true, completion: nil)
    }
    
    @IBAction func getDirectionAction(_ sender: Any) {
    }

    @IBAction func connectSocial(_ sender: UIButton) {
        
       
        if sender.tag == 1
        {
            let svc = SFSafariViewController(url: fbLink!, entersReaderIfAvailable: false)
            svc.delegate = self
            self.present(svc, animated: true, completion: nil)
        } else if sender.tag == 2
        {
            let svc = SFSafariViewController(url: ttLink!, entersReaderIfAvailable: false)
            svc.delegate = self
            self.present(svc, animated: true, completion: nil)
        }
        else
        {
            let svc = SFSafariViewController(url: youtubeLink!, entersReaderIfAvailable: false)
            svc.delegate = self
            self.present(svc, animated: true, completion: nil)
        }
    
    }
}


extension OurOfficeViewController: SFSafariViewControllerDelegate
{
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
