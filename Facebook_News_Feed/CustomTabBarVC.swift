//
//  CustomTabBarVC.swift
//  Facebook_News_Feed
//
//  Created by Xiaoheng Pan on 5/4/17.
//  Copyright © 2017 Xiaoheng Pan. All rights reserved.
//

import UIKit

class CustomTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let feedController = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigationController = UINavigationController(rootViewController: feedController)
        navigationController.title = "News Feed"
        navigationController.tabBarItem.image = UIImage(named: "news_feed_icon")
        
        let friendRequestsController = UINavigationController(rootViewController: FriendRequestsController())
        friendRequestsController.title = "Requests"
        friendRequestsController.tabBarItem.image = UIImage(named: "requests_icon")
        
        let messengerController = UINavigationController(rootViewController: UIViewController())
        messengerController.title = "Messenger"
        messengerController.navigationItem.title = "Messenger"
        messengerController.tabBarItem.image = UIImage(named: "messenger_icon")
        
        let notificationController = UINavigationController(rootViewController: UIViewController())
        notificationController.title = "Notification"
        notificationController.navigationItem.title = "Notification"
        notificationController.tabBarItem.image = UIImage(named: "globe_icon")
        
        let lastController = UINavigationController(rootViewController: UIViewController())
        lastController.title = "More"
        lastController.navigationItem.title = "More"
        lastController.tabBarItem.image = UIImage(named: "more_icon")
        
        viewControllers = [navigationController, friendRequestsController, messengerController, notificationController, lastController]
        
        tabBar.isTranslucent = false
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 0.5)
        topBorder.backgroundColor = UIColor.rgb(229, 231, 235).cgColor
        tabBar.clipsToBounds = true
        tabBar.layer.addSublayer(topBorder)
    }

}
