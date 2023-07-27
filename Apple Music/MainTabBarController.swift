//
//  MainTabBarController.swift
//  Apple Music
//
//  Created by Yehor Krupiei on 27.07.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        viewControllers = [
            generateViewController(rootViewController: SearchViewController(), image: UIImage(imageLiteralResourceName: "search"), title: "Search"),
            generateViewController(rootViewController: ViewController(), image: UIImage(imageLiteralResourceName: "library"), title: "Library")
        ]
    }
    
    private func generateViewController(rootViewController: UIViewController, image: UIImage, title: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        rootViewController.navigationItem.title = title
        navigationVC.navigationBar.prefersLargeTitles = true
        
        return navigationVC
    }
}
