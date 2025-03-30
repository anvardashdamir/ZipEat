//
//  PasswordTextField.swift
//  Zolt Delivery
//
//  Created by Enver Dashdemirov on 14.03.25.
//

import UIKit

class PasswordTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTextField()
    }

    private func setupTextField() {
        self.frame.size = CGSize(width: 200, height: 40)
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1).cgColor
        self.layer.borderWidth = 2
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

        // Set the focus border color
        self.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        self.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
    }

    @objc private func textFieldDidBeginEditing() {
        self.layer.borderColor = UIColor(red: 45/255, green: 140/255, blue: 240/255, alpha: 1).cgColor
    }

    @objc private func textFieldDidEndEditing() {
        self.layer.borderColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1).cgColor
    }
}
