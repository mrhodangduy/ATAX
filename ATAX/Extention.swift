//
//  Extention-Color.swift
//  ATAX
//
//  Created by QTS Coder on 8/30/17.
//  Copyright © 2017 David. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
    func setupSlideMenu(item : UIBarButtonItem, controller: UIViewController)
    {
        item.target = revealViewController()
        item.action = #selector(SWRevealViewController.revealToggle(_:))
      
        controller.view.addGestureRecognizer(controller.revealViewController().tapGestureRecognizer())
        controller.view.addGestureRecognizer(controller.revealViewController().panGestureRecognizer())
    }
}
