//
//  TabBarViewController.swift
//  Thoughts
//
//  Created by Balsa Komnenovic on 10.2.23..
//

import UIKit

class TabBarController: UITabBarController {
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    //MARK: - Private
    private func setupTabs() {
        let homeVC = HomeViewController()
        let searchVC = SearchViewController()
        let LibraryVC = LibraryViewController()
        
        for vc in [homeVC, searchVC, LibraryVC] {
            vc.navigationItem.largeTitleDisplayMode = .always
        }
        
        let nav1 = UINavigationController(rootViewController: homeVC)
        let nav2 = UINavigationController(rootViewController: searchVC)
        let nav3 = UINavigationController(rootViewController: LibraryVC)
        
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "music.note.list"), tag: 3)
        
        for nav in [nav1, nav2, nav3] {
            nav.navigationBar.prefersLargeTitles = true
            nav.navigationBar.tintColor = .label
        }
        
        setViewControllers([nav1, nav2, nav3], animated: false)
    }
}
