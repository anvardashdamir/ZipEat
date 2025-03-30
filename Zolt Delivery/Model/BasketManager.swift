//
//  BasketManager.swift
//  Zolt Delivery
//
//  Created by Enver Dashdemirov on 07.02.25.
//

import UIKit
import Foundation

class BasketManager {
    
    static let shared = BasketManager()
    
    private init() {}
    
    private var basketItems: [FoodItem] = []
    
    func addToBasket(item: FoodItem) {
        basketItems.append(item)
    }
    
    // Removes item from basket menu
    func removeFromBasket(item: FoodItem) {
        basketItems.removeAll { $0.title == item.title }
    }
    
    // Removes item already added in home menu
    func removeItem(at index: Int) {
        guard index >= 0, index < basketItems.count else { return }
        basketItems.remove(at: index)
    }
    
    func getBasketItems() -> [FoodItem] {
        return basketItems
    }
    
    // Removes all items at once from basket menu
    func clearBasket() {
        basketItems.removeAll()
    }
    
}

