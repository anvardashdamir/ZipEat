//
//  PaymentMethodViewController.swift
//  Zolt Delivery
//
//  Created by Enver Dashdemirov on 14.03.25.
//

import UIKit

class PaymentMethodViewController: UIViewController {
    
    let paymentTitle: UILabel = {
        var label = UILabel()
        label.text = "Payment Methods"
        label.font = .boldSystemFont(ofSize: 32)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let googlePayButton = PaymentMethodButton(title: "Google Pay", iconName: "g.circle.fill")
    let applePayButton = PaymentMethodButton(title: "Apple Pay", iconName: "applelogo")
    let creditCardButton = PaymentMethodButton(title: "Credit Card", iconName: "creditcard")
    let cashButton = PaymentMethodButton(title: "Cash", iconName: "manatsign.circle")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(paymentTitle)
        
        let stackView = UIStackView(arrangedSubviews: [googlePayButton, applePayButton, creditCardButton, cashButton])
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            paymentTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            paymentTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            stackView.topAnchor.constraint(equalTo: paymentTitle.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        [googlePayButton, applePayButton, creditCardButton, cashButton].forEach { button in
            button.addTarget(self, action: #selector(paymentMethodSelected(_:)), for: .touchUpInside)
        }
    }
    
    @objc func paymentMethodSelected(_ sender: PaymentMethodButton) {
        [googlePayButton, applePayButton, creditCardButton, cashButton].forEach { $0.isSelected = false }
        sender.isSelected = true
    }
}

// Custom Button Class
class PaymentMethodButton: UIButton {
    
    private let iconImageView = UIImageView()
    private let titleLabelView = UILabel()
    private let checkmarkImageView = UIImageView()
    
    init(title: String, iconName: String) {
        super.init(frame: .zero)
        
        // Button style
        backgroundColor = .systemGray6
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Icon ImageView
        iconImageView.image = UIImage(systemName: iconName)
        iconImageView.tintColor = .darkGray
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Title Label
        titleLabelView.text = title
        titleLabelView.font = .systemFont(ofSize: 16, weight: .medium)
        titleLabelView.textColor = .black
        titleLabelView.translatesAutoresizingMaskIntoConstraints = false
        
        // Checkmark ImageView
        checkmarkImageView.image = UIImage(systemName: "checkmark.circle.fill")
        checkmarkImageView.tintColor = .systemBlue
        checkmarkImageView.isHidden = true
        checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(iconImageView)
        containerView.addSubview(titleLabelView)
        containerView.addSubview(checkmarkImageView)
        
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabelView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            titleLabelView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            checkmarkImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            checkmarkImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 24),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            checkmarkImageView.isHidden = !isSelected
            layer.borderColor = isSelected ? UIColor.systemBlue.cgColor : UIColor.lightGray.cgColor
        }
    }
}
