
//
//  HanldeKryboard.swift
//  ATAX
//
//  Created by Paul on 9/4/17.
//  Copyright © 2017 David. All rights reserved.
//

import Foundation
import UIKit

class Keyboard
{
    func setupNotification()
    {
        NotificationCenter.default.addObserver(UIViewController(), selector: #selector(UIViewController.keyboardShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewController.keyboardHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    func removeNotification()
    {
        NotificationCenter.default.removeObserver(UIViewController(), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(UIViewController(), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
}
