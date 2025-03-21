//
//  MainViewController.swift
//  Zolt Delivery
//
//  Created by Enver Dashdemirov on 05.02.25.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewControllers()
        self.selectedIndex = 0
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = .black
        self.tabBar.unselectedItemTintColor = .gray
    }
    
    func createNavigator(with title: String, and image: UIImage?, for viewController: UIViewController) -> UINavigationController {
        let navigator = UINavigationController(rootViewController: viewController)
        navigator.tabBarItem.title = title
        navigator.tabBarItem.image = image
        navigator.navigationBar.isHidden = true
        return navigator
    }
    
    func setupViewControllers() {
        
        let home = self.createNavigator(
            with: "Home",
            and: UIImage(systemName: "house.circle.fill"),
            for: HomeViewController()
        )
        
        let shoppingBasket = self.createNavigator(
            with: "Basket",
            and: UIImage(systemName: "cart.circle"),
            for: ShoppingBasketViewController()
        )
        
        let location = self.createNavigator(
            with: "Map",
            and: UIImage(systemName: "mappin.and.ellipse.circle"),
            for: MapViewController()
        )
        
        let profile = self.createNavigator(
            with: "Profile",
            and: UIImage(systemName: "person.circle"),
            for: ProfileViewController()
        )
        self.viewControllers = [home, shoppingBasket, location, profile]
    }
}

