//
//  ViewController.swift
//  nOCD_minimal
//
//  Created by Ilyas Patanam on 1/9/18.
//  Copyright © 2018 Ilyas Patanam. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = UIColor.white
        self.tabBar.isTranslucent = false
    
        let planVC = PlanViewController()
        let planImg = UIImage(named: "tabBarIcon0")?.withRenderingMode(.alwaysOriginal)
        planVC.tabBarItem.image = planImg
        let planImgSelected = UIImage(named: "tabBarIcon0Selected")?.withRenderingMode(.alwaysOriginal)
        planVC.tabBarItem.selectedImage = planImgSelected
        planVC.tabBarItem.title = planVC.title
        
        let sosVC = SOSViewController()
        let sosImg = UIImage(named: "tabBarIcon2")?.withRenderingMode(.alwaysOriginal)
        sosVC.tabBarItem.image = sosImg

        let profileVC = ProfileViewController()
        let profileImg = UIImage(named: "tabBarIcon3")?.withRenderingMode(.alwaysOriginal)
        profileVC.tabBarItem.image = profileImg
        let profileImgSelected = UIImage(named: "tabBarIcon3Selected")?.withRenderingMode(.alwaysOriginal)
        profileVC.tabBarItem.selectedImage = profileImgSelected
        profileVC.title = "Profile"
            
        viewControllers = [planVC, sosVC, profileVC]
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

