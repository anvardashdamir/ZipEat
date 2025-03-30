//
//  nameTextField.swift
//  ZipEat
//
//  Created by Dashdemirli Enver on 28.03.25.
//

import UIKit

class NameTextField: UITextField {
    
    init() {
        super.init(frame: .zero)
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTextField()
    }
    
    private func setupTextField() {
        backgroundColor = UIColor(red: 34/255, green: 38/255, blue: 48/255, alpha: 1) // #222630
        textColor = .white
        attributedPlaceholder = NSAttributedString(
            string: "Enter Name",
            attributes: [.foregroundColor: UIColor.lightGray]
        )
        
        // Border
        layer.borderWidth = 2
        layer.borderColor = UIColor(red: 43/255, green: 48/255, blue: 64/255, alpha: 1).cgColor // #2B3040
        layer.cornerRadius = 8
        
        // Padding
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
        
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 48).isActive = true
        widthAnchor.constraint(equalToConstant: 280).isActive = true
        
        // Focus state (editing)
        addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
    }
    
    @objc private func editingDidBegin() {
        // Focus border color
        layer.borderColor = UIColor(red: 89/255, green: 106/255, blue: 149/255, alpha: 1).cgColor // #596A95
    }
    
    @objc private func editingDidEnd() {
        // Default border color
        layer.borderColor = UIColor(red: 43/255, green: 48/255, blue: 64/255, alpha: 1).cgColor // #2B3040
    }
}
