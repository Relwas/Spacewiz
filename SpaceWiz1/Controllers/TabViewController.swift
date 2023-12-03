//
//  TabViewController.swift
//  SpaceWiz1
//
//  Created by relwas on 02/12/23.
//

import UIKit

@available(iOS 13.0, *)
class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        view.backgroundColor = UIColor(named: "Fon")
        
        self.tabBar.tintColor = .darkGray
        self.tabBar.unselectedItemTintColor = UIColor(named: "forLabelColor")
    }
    
    private func setupTabs() {
        let main = createNav(with: "Main", and: UIImage(systemName: "globe.desk.fill"), vc: MainViewController())
        let quiz = createNav(with: "Quiz", and: UIImage(systemName: "questionmark.square.dashed"), vc: QuizViewController())
        let setting = createNav(with: "Settings", and: UIImage(systemName: "gear.circle"), vc: SettingsViewController())
        
        self.setViewControllers([main, quiz, setting], animated: true)
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        vc.title = title  // Set the title of the root view controller
        return nav
    }
}

