//
//  TabBarMainVC.swift
//  GitHub
//
//  Created by Alexei Karas on 24.06.2018.
//  Copyright © 2018 TestOrg. All rights reserved.
//

import UIKit

class TabBarMainVC: UITabBarController {

    let userProfile = UserProfileVC()
    let userRepos = UserReposVC()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationVCUserRepos = UINavigationController(rootViewController: userRepos)
        userRepos.title = "Repository"
        userRepos.view.backgroundColor = UIColor.white
        userRepos.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 0)
        
        let navigationVCUserProfile = UINavigationController(rootViewController: userProfile)
        userProfile.title = "UserProfile"
        userProfile.view.backgroundColor = UIColor.white
        userProfile.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        let tabBarList = [navigationVCUserRepos, navigationVCUserProfile]
        viewControllers = tabBarList

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
