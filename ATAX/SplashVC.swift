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
    
    let loginStatus = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imageAtax.alpha = 0
        
        let signinVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "signinVC") as! SignInViewController
        let introVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "introVC") as! IntroVC

        
        UIView.animate(withDuration: 2, animations: { 
            self.imageAtax.alpha = 1
        }) { (action) in
            
            if self.loginStatus
            {
                self.present(signinVC, animated: false, completion: nil)

            }
            
            self.present(introVC, animated: false, completion: nil)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

