//
//  HomeViewController.swift
//  ATAX
//
//  Created by QTS Coder on 8/29/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

 
    @IBOutlet weak var btnsignup: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func signInAction(_ sender: UIButton) {
        
        
        let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC")
        self.present(homeVC, animated: false, completion: nil)
    }
    
    @IBAction func SignUpAction(_ sender: Any)
    {
        let signupVC = storyboard?.instantiateViewController(withIdentifier: "signupVC") as! SignUpViewController
        self.present(signupVC, animated: true, completion: nil)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func forgotPass(_ sender: Any) {
        
        let forgotPswVC = storyboard?.instantiateViewController(withIdentifier: "forgotPsw") as! ForgotPasswordViewController
        self.present(forgotPswVC, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
