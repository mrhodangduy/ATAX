//
//  CustomTabbar.swift
//  ATAX
//
//  Created by QTS Coder on 8/30/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class CustomTabbar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        UINavigationBar.appearance().barTintColor = UIColor(patternImage: #imageLiteral(resourceName: "bg_blue"))
        
        let unselectedColor   = UIColor(red: 109/255.0, green: 109/255.0, blue: 109/255.0, alpha: 1.0)
        let selectedColor = #colorLiteral(red: 0.3598896265, green: 0.5517957211, blue: 0.8724040389, alpha: 1)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: unselectedColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: selectedColor], for: .selected)
        
//        let imageView:UIImageView = UIImageView()
//        let constaint:NSLayoutConstraint = NSLayoutConstraint(item: imageView, attribute:.topMargin, relatedBy: .equal, toItem: self.view, attribute: .bottomMargin, multiplier: 1, constant: 0)
//        imageView.constraints = NSLayoutConstraint(
//        
//        imageView.image = #imageLiteral(resourceName: "bg_dashboard")
//        imageView.contentMode = .scaleAspectFit
//        
//        self.view.addSubview(imageView)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
