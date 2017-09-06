//
//  LiveCallViewController.swift
//  ATAX
//
//  Created by Paul on 8/31/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class LiveCallViewController: UIViewController {

    var mute: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func mutedAction(_ sender: UIButton) {
        
        if mute
        {
            sender.setImage(#imageLiteral(resourceName: "btn_muted"), for: .normal)
        }
        else
        {
            sender.setImage(#imageLiteral(resourceName: "btn_mute"), for: .normal)

        }
        mute = !mute
        
    }
       

    @IBAction func endCallAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func backAction(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
    }
   
}
