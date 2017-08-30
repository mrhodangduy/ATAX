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
        
        let signinVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "signinVC") as! HomeViewController
        UIView.animate(withDuration: 2, animations: {
            self.imageAtax.alpha = 1
        }) { (action) in
//            self.performSegue(withIdentifier: "intro", sender: nil)
            self.show(signinVC, sender: self)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

