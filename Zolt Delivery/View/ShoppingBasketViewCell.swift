//
//  ShoppingBasketViewCell.swift
//  Zolt Delivery
//
//  Created by Enver Dashdemirov on 18.02.25.
//

import UIKit

class ShoppingBasketViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    let foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.font = .boldSystemFont(ofSize: 18)
        title.textColor = .black
        title.numberOfLines = 0
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let subtitleLabel: UILabel = {
        let subtitle = UILabel()
        subtitle.font = .systemFont(ofSize: 14)
        subtitle.textColor = .gray
        subtitle.numberOfLines = 0
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        return subtitle
    }()
    
    let priceLabel: UILabel = {
        let price = UILabel()
        price.font = .boldSystemFont(ofSize: 18)
        price.textColor = .black
        price.translatesAutoresizingMaskIntoConstraints = false
        return price
    }()
    
    let textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    func setupViews() {
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(subtitleLabel)
        
        mainStackView.addArrangedSubview(foodImageView)
        mainStackView.addArrangedSubview(textStackView)
        mainStackView.addArrangedSubview(priceLabel)
        
        contentView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            foodImageView.widthAnchor.constraint(equalToConstant: 80),
            foodImageView.heightAnchor.constraint(equalToConstant: 80),
            
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            textStackView.trailingAnchor.constraint(lessThanOrEqualTo: priceLabel.leadingAnchor, constant: -8)
        ])
    }
    
    // MARK: - Configure Cell Data
     func configure(with item: FoodItem) {
         foodImageView.image = UIImage(named: item.imageName)
         titleLabel.text = item.title
         subtitleLabel.text = item.subtitle
         priceLabel.text = "\(item.price)"
     }
}
