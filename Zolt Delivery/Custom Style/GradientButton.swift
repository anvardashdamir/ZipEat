//
//  Creator.swift
//  Zolt Delivery
//
//  Created by Enver Dashdemirov on 05.02.25.
//

import UIKit
import AVFoundation

class GradientButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        // Background color
        self.backgroundColor = UIColor(red: 108/255, green: 92/255, blue: 231/255, alpha: 1) // #6c5ce7
        
        // Text color
        self.setTitleColor(.white, for: .normal)
        
        // Font
        self.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        
        // Padding (contentEdgeInsets)
        self.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        
        // Corner radius
        self.layer.cornerRadius = 5
        
        // Shadow (box-shadow)
        self.layer.shadowColor = UIColor(red: 162/255, green: 155/255, blue: 254/255, alpha: 1).cgColor // #a29bfe
        self.layer.shadowOffset = CGSize(width: 0, height: 5) // 0px 5px
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 0
        
        // Add target for button press and release
        self.addTarget(self, action: #selector(buttonPressed), for: .touchDown)
        self.addTarget(self, action: #selector(buttonReleased), for: [.touchUpInside, .touchDragExit])
    }
    
    @objc private func buttonPressed() {
        // Move button down by 5px (transform: translateY(5px))
        self.transform = CGAffineTransform(translationX: 0, y: 5)
        
        // Remove shadow (box-shadow: 0px 0px 0px 0px #a29bfe)
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    @objc private func buttonReleased() {
        // Reset transform
        self.transform = .identity
        
        // Restore shadow
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
    }
}
