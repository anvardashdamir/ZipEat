//
//  FoodCollectionViewCell.swift
//  Zolt Delivery
//
//  Created by Enver Dashdemirov on 05.02.25.
//

import UIKit

class FoodCollectionViewCell: UICollectionViewCell {
    
    var isAddedToCart = false
    var foodItem: FoodItem?
    
    // MARK: - UI Elements
    let foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1).isActive = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.font = .boldSystemFont(ofSize: 18)
        title.textColor = .black
        title.numberOfLines = 0
        return title
    }()
    
    let subtitleLabel: UILabel = {
        let subtitles = UILabel()
        subtitles.font = .systemFont(ofSize: 14)
        subtitles.textColor = .gray
        subtitles.numberOfLines = 0
        return subtitles
    }()
    
    let priceLabel: UILabel = {
        let title = UILabel()
        title.font = .boldSystemFont(ofSize: 18)
        title.textColor = .black
        return title
    }()
    
    let addButton: AnimatedButton = {
        let button = AnimatedButton()
        button.setTitle("Add", for: .normal)
        button.addTarget(self, action: #selector(toggleButton), for: .touchUpInside)
        return button
    }()
    
    let priceAndButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        NotificationCenter.default.addObserver(self, selector: #selector(basketUpdated), name: NSNotification.Name("BasketUpdated"), object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    func setupViews() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 6
        layer.masksToBounds = false
        
        contentView.addSubview(foodImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(priceAndButtonStackView)
        priceAndButtonStackView.addArrangedSubview(priceLabel)
        priceAndButtonStackView.addArrangedSubview(addButton)
        priceAndButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        foodImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            foodImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            foodImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            foodImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
           
            titleLabel.topAnchor.constraint(equalTo: foodImageView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
         
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
          
            priceAndButtonStackView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 8),
            priceAndButtonStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            priceAndButtonStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            priceAndButtonStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

        ])
    }

    
    // MARK: - Action
    @objc func toggleButton(_ sender: UIButton) {
        guard let item = foodItem else { return }
        isAddedToCart.toggle()
        if isAddedToCart {
            BasketManager.shared.addToBasket(item: item)
        } else {
            BasketManager.shared.removeFromBasket(item: item)
        }
        updateButtonAppearance()
    }
    
    func updateButtonAppearance() {
        addButton.setTitle(isAddedToCart ? "Added" : "Add", for: .normal)
    }
    
    @objc private func basketUpdated() {
        guard let item = foodItem else { return }
        isAddedToCart = BasketManager.shared.getBasketItems().contains { $0.title == item.title }
        updateButtonAppearance()
    }
    
    func configure(with item: FoodItem) {
        self.foodItem = item
        
        foodImageView.image = UIImage(named: item.imageName)
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        priceLabel.text = item.price
                
        // Check if item is already in the basket
        isAddedToCart = BasketManager.shared.getBasketItems().contains { $0.title == item.title }
        updateButtonAppearance()
    }
}

