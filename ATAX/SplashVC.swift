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
    
    var launchTime:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imageAtax.alpha = 0
        
        launchTime = appDell.currenTimesOfOpenApp
        print(launchTime!)
        
        
        let signinVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "signinVC") as! SignInViewController
        let introVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "introVC") as! IntroVC

        
        
        
        UIView.animate(withDuration: 3, animations: {
            self.imageAtax.alpha = 1
        }) { (action) in
            
            if self.launchTime == 1
            {
                self.present(introVC, animated: false, completion: nil)
            }
            else if defaults.bool(forKey: "isLoggedin")
            {
                let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC")
                self.present(homeVC, animated: false, completion: nil)
                
            } else
            {
                self.present(signinVC, animated: false, completion: nil)
            }
            
            
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

