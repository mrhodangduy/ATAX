//
//  IntroVC.swift
//  ATAX
//
//  Created by QTS Coder on 8/29/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit
import paper_onboarding

class IntroVC: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var paer_onboarding: PaperOnboarding!
    override func viewDidLoad() {
        super.viewDidLoad()

        paer_onboarding.dataSource = self
        startButton.isHidden = true
        // Do any additional setup after loading the view.
    }
}



extension IntroVC: PaperOnboardingDataSource
{
    func onboardingItemsCount() -> Int {
        return 3
        
    }
    
    func onboardingItemAtIndex(_ index: Int) -> OnboardingItemInfo {
        
        let titleFont = UIFont(name: "OpenSans-SemiBold", size: 30) ?? UIFont.boldSystemFont(ofSize: 25)
        let descriptionFont = UIFont(name: "SourceSansPro-Light", size: 14) ?? UIFont.boldSystemFont(ofSize: 12)
        
        
        var items = [OnboardingItemInfo]()
        items = [
            (imageName: UIImage(named: "intro1")! , title: Intro1, description: IntroDes1, iconName: UIImage(named: "dot")!, color: UIColor(patternImage: UIImage(named: "bg_dashboard")!), titleColor: UIColor.black, descriptionColor: UIColor.black, titleFont: titleFont, descriptionFont: descriptionFont),
            
            (imageName: UIImage(named: "intro2")!, title: Intro2, description: IntroDes2, iconName: UIImage(named: "dot")!, color: UIColor(patternImage: UIImage(named: "bg_dashboard")!), titleColor: UIColor.black, descriptionColor: UIColor.black, titleFont: titleFont, descriptionFont: descriptionFont),
            
            (imageName: UIImage(named: "intro3")!, title: Intro3, description: IntroDes3, iconName: UIImage(named: "dot")!, color: UIColor(patternImage: UIImage(named: "bg_dashboard")!), titleColor: UIColor.black, descriptionColor: UIColor.black, titleFont: titleFont, descriptionFont: descriptionFont),
            ]
        
        return items[index]

        
    }
}
