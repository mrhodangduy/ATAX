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
        UINavigationBar.appearance().barTintColor = UIColor(red: 62/225, green: 109/255, blue: 223/255, alpha: 1)
        
        let unselectedColor   = UIColor(red: 109/255.0, green: 109/255.0, blue: 109/255.0, alpha: 1.0)
        let selectedColor = UIColor(red: 62/225, green: 109/255, blue: 223/255, alpha: 1)

        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: unselectedColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: selectedColor], for: .selected)
        
    }

}
