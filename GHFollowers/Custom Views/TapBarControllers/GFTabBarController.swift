//
//  GFTabBarController.swift
//  GHFollowers
//
//  Created by MacOS on 28/07/2022.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.backgroundColor = UIColor(named: "tabBarColor")
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNC() , createFavoriteListNC()]
        
        
    }

    func createSearchNC()-> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavoriteListNC()-> UINavigationController{
        let favoriteVC = FavoritesListVC()
        favoriteVC.title = "Favorites"
        favoriteVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favoriteVC)
    }
    
    
    
}
