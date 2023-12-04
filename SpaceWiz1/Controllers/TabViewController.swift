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
        
        self.view.backgroundColor = UIColor(named: "Fon")

        navigationController?.navigationBar.isHidden = true


        self.tabBar.tintColor = .darkGray
        self.tabBar.unselectedItemTintColor = UIColor(named: "forLabelColor")
        
        let attributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont(name: "Futura-Bold", size: 20.0) ?? UIFont.systemFont(ofSize: 18.0),
                    .foregroundColor: UIColor(named: "forLabelColor") ?? UIColor.black
                ]

                // Set titleTextAttributes for each UINavigationController
                if let viewControllers = viewControllers {
                    for viewController in viewControllers {
                        if let navController = viewController as? UINavigationController {
                            navController.navigationBar.titleTextAttributes = attributes
                        }
                    }
                }
            }
    
    
    private func setupTabs() {
        let main = MainViewController()
        let quiz = QuizViewController()
        let setting = SettingsViewController()

        let mainNav = createNav(with: "Spacewiz", and: UIImage(systemName: "globe.desk.fill"), vc: main)
        let quizNav = createNav(with: "Quiz", and: UIImage(systemName: "questionmark.square"), vc: quiz)
        let settingNav = createNav(with: "Settings", and: UIImage(systemName: "gear.circle"), vc: setting)

        self.setViewControllers([mainNav, quizNav, settingNav], animated: true)
    }

    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        vc.title = title
        return nav
    }
}

