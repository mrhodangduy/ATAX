//
//  MenuViewController.swift
//  ATAX
//
//  Created by QTS Coder on 8/31/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit
import SafariServices


class MenuViewController: UIViewController {
    
    @IBOutlet weak var imageAvatar: RoundImageView!
    @IBOutlet weak var lbl_userName: UILabel!
    @IBOutlet weak var lbl_Email: UILabel!
    var userInfo = [UserInformation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let token = UserDefaults.standard.object(forKey: "tokenString") as! String
        UserInformation.getUserInfo(withToken: token) { (user) in
            self.userInfo = user!
            DispatchQueue.main.async {
                self.lbl_userName.text = self.userInfo[0].fullName
                self.lbl_Email.text = self.userInfo.last?.email
//                self.imageAvatar.image = UIImage(named: <#T##String#>)
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func myTaxAction(_ sender: UIButton) {
        
        let myTaxesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mytaxesVC") as! MyTaxViewController
        let tabBarController = revealViewController().frontViewController as! UITabBarController
        tabBarController.selectedIndex = 0
        revealViewController().pushFrontViewController(tabBarController,animated:true)
        
        let navController = tabBarController.viewControllers![0] as! UINavigationController
        navController.pushViewController(myTaxesVC, animated: true  )
        
    }
    
    @IBAction func documentAction(_ sender: UIButton) {
        
        let tabBarController = revealViewController().frontViewController as! UITabBarController
        tabBarController.selectedIndex = 1
        revealViewController().pushFrontViewController(tabBarController,animated:true)
        
    }
    
    @IBAction func contactAction(_ sender: UIButton) {
        
        let tabBarController = revealViewController().frontViewController as! UITabBarController
        
        tabBarController.selectedIndex = 0
        revealViewController().pushFrontViewController(tabBarController,animated:true)
        
        let contacttaxproVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "contacttaxpro") as! ContactTaxProViewController
        
        self.present(contacttaxproVC, animated: true, completion: nil)
    }
    
    @IBAction func refundAction(_ sender: UIButton) {
        
        let sarafi = SFSafariViewController(url: refundLink!)
        sarafi.delegate = self
        self.present(sarafi, animated: true, completion: nil)
    }
    
    @IBAction func messageAction(_ sender: UIButton) {
        
        let tabBarController = revealViewController().frontViewController as! UITabBarController
        
        tabBarController.selectedIndex = 2
        revealViewController().pushFrontViewController(tabBarController,animated:true)
        
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        
        displayAlert(title: nil, mess: "Do you want to logout?", type: .actionSheet)
    }
    
    func displayAlert(title: String?, mess: String?, type: UIAlertControllerStyle)
    {
        let alert = UIAlertController(title: title, message: mess, preferredStyle: type)
        let btnDell  = UIAlertAction(title: "Logout", style: .destructive) { (action) in
            
            defaults.set(false, forKey: "isLoggedin")
            print("Logged Out")
            let signinVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "signinVC") as! SignInViewController
            self.present(signinVC, animated: false, completion: nil)
        }
        let btnCan = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(btnDell)
        alert.addAction(btnCan)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

extension MenuViewController: SFSafariViewControllerDelegate
{
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
        
    }
}



