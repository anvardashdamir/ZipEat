//
//  CustomTextField.swift
//  Zolt Delivery
//
//  Created by Enver Dashdemirov on 12.03.25.
//

import UIKit

class CustomTextField: UITextField {
    
    // MARK: - UI Elements
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(hex: "#0B2447")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.transform = CGAffineTransform(scaleX: 0, y: 0)
        label.alpha = 0
        return label
    }()
    
    private let topline: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#0B2447")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let underline: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#0B2447")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupTextFieldStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupTextFieldStyle()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        addSubview(label)
        addSubview(topline)
        addSubview(underline)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            topline.topAnchor.constraint(equalTo: topAnchor),
            topline.trailingAnchor.constraint(equalTo: trailingAnchor),
            topline.heightAnchor.constraint(equalToConstant: 2),
            topline.widthAnchor.constraint(equalToConstant: 0),
            
            underline.bottomAnchor.constraint(equalTo: bottomAnchor),
            underline.trailingAnchor.constraint(equalTo: trailingAnchor),
            underline.heightAnchor.constraint(equalToConstant: 2),
            underline.widthAnchor.constraint(equalToConstant: 0)
        ])
        
        addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
    }
    
    // MARK: - Apply PasswordTextField Styling
    private func setupTextFieldStyle() {
        // Set the border radius
        self.layer.cornerRadius = 5
        
        // Set the border color and width
        self.layer.borderColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1).cgColor
        self.layer.borderWidth = 2
        
        // Set the background color
        self.backgroundColor = .white
        
        // Set the shadow
        self.layer.shadowColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1).cgColor
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 0
        
        // Set the font and text color
        self.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        self.textColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
        
        // Set the padding
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        
        // Set the placeholder color
        self.attributedPlaceholder = NSAttributedString(
            string: self.placeholder ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 0.8)]
        )
    }
    
    // MARK: - Text Field Events
    @objc private func textFieldDidBeginEditing() {
        // Animate label
        UIView.animate(withDuration: 0.5) {
            self.label.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.label.alpha = 1
            self.label.frame.origin.y = -10
        }
        
        // Animate topline
        UIView.animate(withDuration: 0.5) {
            self.topline.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.35).isActive = true
            self.layoutIfNeeded()
        }
        
        // Animate underline
        UIView.animate(withDuration: 0.5) {
            self.underline.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
            self.layoutIfNeeded()
        }
        
        // Change border color on focus
        self.layer.borderColor = UIColor(red: 45/255, green: 140/255, blue: 240/255, alpha: 1).cgColor
    }
    
    @objc private func textFieldDidEndEditing() {
        // Reset label
        UIView.animate(withDuration: 0.5) {
            self.label.transform = CGAffineTransform(scaleX: 0, y: 0)
            self.label.alpha = 0
            self.label.frame.origin.y = 10
        }
        
        // Reset topline and underline
        UIView.animate(withDuration: 0.5) {
            self.topline.widthAnchor.constraint(equalToConstant: 0).isActive = true
            self.underline.widthAnchor.constraint(equalToConstant: 0).isActive = true
            self.layoutIfNeeded()
        }
        
        // Reset border color
        self.layer.borderColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1).cgColor
    }
}

// MARK: - UIColor Extension for Hex Support
extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
