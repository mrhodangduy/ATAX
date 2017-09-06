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
    @IBOutlet weak var skipbtn: UIButton!
    @IBOutlet weak var paer_onboarding: PaperOnboarding!
    override func viewDidLoad() {
        super.viewDidLoad()

        paer_onboarding.dataSource = self
        paer_onboarding.delegate = self
        startButton.alpha = 0
        
    }
    
    @IBAction func getStart(_ sender: Any) {
        gotoSignInVC()
    }
    
    @IBAction func skipIntro(_ sender: UIButton)
    {
        gotoSignInVC()
    }
    
    func gotoSignInVC()
    {
        let signinVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "signinVC") as! SignInViewController
        self.present(signinVC, animated: false, completion: nil)
    }
    
}

extension IntroVC: PaperOnboardingDataSource, PaperOnboardingDelegate
{
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        
        if index == 2
        {
            UIView.animate(withDuration: 0.5, animations: {
                self.startButton.alpha = 1
                self.skipbtn.alpha = 0
            })
            
        } else
        {
            startButton.alpha = 0
            skipbtn.alpha = 1
        }
        
        
    }
    func onboardingDidTransitonToIndex(_ index: Int) {
        
    }
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
      
    }
    
    func onboardingItemsCount() -> Int {
        return 3
    }
    
    func onboardingItemAtIndex(_ index: Int) -> OnboardingItemInfo {
        
        let titleFont = UIFont(name: "OpenSans-SemiBold", size: 20) ?? UIFont.boldSystemFont(ofSize: 20)
        let descriptionFont = UIFont(name: "SourceSansPro-Light", size: 12) ?? UIFont.boldSystemFont(ofSize: 12)
        
        
        var items = [OnboardingItemInfo]()
        items = [
            (imageName: UIImage(named: "intro1")! , title: Intro1, description: IntroDes1, iconName: UIImage(), color: UIColor(red:0.40, green:0.56, blue:0.71, alpha:1.00), titleColor: UIColor.black, descriptionColor: UIColor.black, titleFont: titleFont, descriptionFont: descriptionFont),
            
            (imageName: UIImage(named: "intro2")!, title: Intro2, description: IntroDes2, iconName: UIImage(), color: UIColor(red:0.40, green:0.69, blue:0.71, alpha:1.00), titleColor: UIColor.black, descriptionColor: UIColor.black, titleFont: titleFont, descriptionFont: descriptionFont),
            
            (imageName: UIImage(named: "intro3")!, title: Intro3, description: IntroDes3, iconName: UIImage(), color: UIColor(red: 0.61, green:0.56, blue:0.74, alpha:1.00), titleColor: UIColor.black, descriptionColor: UIColor.black, titleFont: titleFont, descriptionFont: descriptionFont),
            ]
        
        return items[index]

        
    }
}
