//
//  HomeViewModel.swift
//  Zolt Delivery
//
//  Created by Enver Dashdemirov on 23.02.25.
//

import UIKit
import Foundation

class HomeViewModel {
    
    var currentItems: [FoodItem] = []
    
    var onDataUpdated: (() -> Void)?
    
    func loadItems(for category: FoodCategory) {
        switch category{
        case .pizza:
            currentItems = pizzaItems
        case .burger:
            currentItems = burgerItems
        case .salad:
            currentItems = saladItems
        case .drink:
            currentItems = drinkItems
        }
        onDataUpdated?()
    }
    
    enum FoodCategory {
        case pizza, burger, salad, drink
    }
}
