//
//  HomeTabBarController.swift
//  FavoritePets
//
//  Created by King Bileygr on 7/3/21.
//

import UIKit

class HomeTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let allCatsTabBar = AllCatsViewController()
        let catsILikeTabBar = CatsILikeViewController(collectionViewLayout: CatsILikeViewController.collectionViewLayout())
        delegate = self
        
        allCatsTabBar.title = "All Cats"
        catsILikeTabBar.title = "Cats I Like"
        
        let allCatsHome = UINavigationController(rootViewController: allCatsTabBar)
        let catsILikeHome = UINavigationController(rootViewController: catsILikeTabBar)
        
        allCatsHome.tabBarItem = UITabBarItem(title: "All cats", image: UIImage(named: "CatTabVector"), tag: 0)
        allCatsHome.tabBarItem.setTitleTextAttributes(Constants.tabBarText, for: .normal)
        catsILikeHome.tabBarItem = UITabBarItem(title: "Cats I like", image: UIImage(named: "LikeVector"), tag: 1)
        catsILikeHome.tabBarItem.setTitleTextAttributes(Constants.tabBarText, for: .normal)
        
       
        tabBar.barTintColor = .white
        tabBar.tintColor = .black
        
        allCatsHome.navigationBar.prefersLargeTitles = true
        catsILikeHome.navigationBar.prefersLargeTitles = true
        
        setViewControllers([allCatsHome, catsILikeHome], animated: true)
        
    }
    
}

extension HomeTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomTransition(viewControllers: tabBarController.viewControllers)
    }
}


