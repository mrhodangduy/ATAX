//
//  CustomNavi.swift
//  ATAX
//
//  Created by Paul on 8/30/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class CustomNavi: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = #colorLiteral(red: 0.3647058824, green: 0.4156862745, blue: 0.8745098039, alpha: 1)
        self.navigationBar.tintColor = .white
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
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
