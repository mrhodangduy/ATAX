//
//  ViewController.swift
//  ATAX
//
//  Created by QTS Coder on 8/29/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {

    @IBOutlet weak var imageAtax: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imageAtax.alpha = 0
        
        
        UIView.animate(withDuration: 3, animations: { 
            self.imageAtax.alpha = 1
        }) { (action) in
            self.performSegue(withIdentifier: "intro", sender: nil)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

