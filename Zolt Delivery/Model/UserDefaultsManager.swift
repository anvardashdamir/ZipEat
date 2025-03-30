//
//  UserDefaultsManager.swift
//  ZipEat
//
//  Created by Dashdemirli Enver on 30.03.25.
//

import Foundation
import UIKit

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    private let nameKey = "userName"
    private let emailKey = "userEmail"
    private let imageKey = "userImage"
    private let passwordKey = "userPassword"
    
    private init() {}
    
    // Save user data
    func saveUser(name: String, email: String, password: String, image: UIImage?) {
        UserDefaults.standard.set(name, forKey: nameKey)
        UserDefaults.standard.set(email, forKey: emailKey)
        UserDefaults.standard.set(password, forKey: passwordKey)
        
        if let image = image, let imageData = image.jpegData(compressionQuality: 0.8) {
            UserDefaults.standard.set(imageData, forKey: imageKey)
        }
    }
    
    // Retrieve user data
    func getUser() -> (name: String?, email: String?, password: String?, image: UIImage?) {
        let name = UserDefaults.standard.string(forKey: nameKey)
        let email = UserDefaults.standard.string(forKey: emailKey)
        let password = UserDefaults.standard.string(forKey: passwordKey)
        
        var userImage: UIImage? = nil
        if let imageData = UserDefaults.standard.data(forKey: imageKey) {
            userImage = UIImage(data: imageData)
        }
        
        return (name, email, password, userImage)
    }
    
    // Clear user data
    func clearUser() {
        UserDefaults.standard.removeObject(forKey: nameKey)
        UserDefaults.standard.removeObject(forKey: emailKey)
        UserDefaults.standard.removeObject(forKey: passwordKey)
        UserDefaults.standard.removeObject(forKey: imageKey)
    }
}
