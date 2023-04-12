//
//  TabBar.swift
//  Articula Inc Task
//
//  Created by Macbook Air on 10.04.2023.
//

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let voiceCallingVC = CallScreenVC()
        voiceCallingVC.tabBarItem = UITabBarItem(title: "Video Calling", image: UIImage(systemName: "phone") , tag: 0)
    
        let messagesVC = MessagesVC()
        messagesVC.tabBarItem = UITabBarItem(title: "Messages", image: UIImage(systemName: "message"), tag: 1)
        
        let settingsVC = SettingsVC()
        settingsVC.modalPresentationStyle = .fullScreen
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
        let settingsNavigationController = UINavigationController(rootViewController: settingsVC)
        
        
        tabBar.tintColor = .systemTeal
        
        setViewControllers([voiceCallingVC,messagesVC,settingsNavigationController], animated: true)
        
    }
   

}
