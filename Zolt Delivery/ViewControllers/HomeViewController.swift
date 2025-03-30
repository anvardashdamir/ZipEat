//
//  HomeViewController.swift
//  Zolt Delivery
//
//  Created by Enver Dashdemirov on 05.02.25.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var viewModel = HomeViewModel()
    var selectedButton: UIButton?
    let refreshControl = UIRefreshControl()

    // MARK: - Properties
    let titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Delicious Food"
        title.font = .boldSystemFont(ofSize: 30)
        title.textColor = .black
        return title
    }()
    
    let subtitlesLabel: UILabel = {
        let subtitles = UILabel()
        subtitles.text = "Discover and Get Great Food"
        subtitles.font = .systemFont(ofSize: 18)
        subtitles.textColor = .gray
        return subtitles
    }()
    
    let categoryTitlesStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()
    
    let pizzaButton: AnimatedButton = {
        let button = AnimatedButton(type: .system)
        button.setTitle("Pizza", for: .normal)
        button.addTarget(self, action: #selector(loadPizzaItems), for: .touchUpInside)
        return button
    }()
    
    let saladButton: AnimatedButton = {
        let button = AnimatedButton(type: .system)
        button.setTitle("Salad", for: .normal)
        button.addTarget(self, action: #selector(loadSaladItems), for: .touchUpInside)
        return button
    }()
    
    let burgerButton: AnimatedButton = {
        let button = AnimatedButton(type: .system)
        button.setTitle("Burger", for: .normal)
        button.addTarget(self, action: #selector(loadBurgerItems), for: .touchUpInside)
        
        return button
    }()
    
    let drinkButton: AnimatedButton = {
        let button = AnimatedButton(type: .system)
        button.setTitle("Drink", for: .normal)
        button.addTarget(self, action: #selector(loadBeerItems), for: .touchUpInside)
        return button
    }()
    
    let foodListView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupLayout()
        setupBindings()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateFoodList), name: NSNotification.Name("BasketUpdated"), object: nil)
        
        foodListView.delegate = self
        foodListView.dataSource = self
        foodListView.register(FoodCollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
        viewModel.loadItems(for: .pizza)
    }
    
    @objc func updateFoodList() {
        foodListView.reloadData()
    }
    
    // MARK: - ViewModel Bindings
    private func setupBindings() {
        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.foodListView.reloadData()
            }
        }
    }
        
    // MARK: - Setup Methods
    func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(subtitlesLabel)
        view.addSubview(categoryTitlesStackView)
        categoryTitlesStackView.addArrangedSubview(pizzaButton)
        categoryTitlesStackView.addArrangedSubview(saladButton)
        categoryTitlesStackView.addArrangedSubview(burgerButton)
        categoryTitlesStackView.addArrangedSubview(drinkButton)
        view.addSubview(foodListView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitlesLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryTitlesStackView.translatesAutoresizingMaskIntoConstraints = false
        foodListView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            subtitlesLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            subtitlesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            subtitlesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            categoryTitlesStackView.topAnchor.constraint(equalTo: subtitlesLabel.bottomAnchor, constant: 16),
            categoryTitlesStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            categoryTitlesStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            foodListView.topAnchor.constraint(equalTo: categoryTitlesStackView.bottomAnchor, constant: 16),
            foodListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            foodListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            foodListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
        
    // MARK: - Category Actions
    @objc func loadPizzaItems() {
        viewModel.loadItems(for: .pizza)
    }
    
    @objc func loadBurgerItems() {
        viewModel.loadItems(for: .burger)
    }
    
    @objc func loadSaladItems() {
        viewModel.loadItems(for: .salad)
    }
    
    @objc func loadBeerItems() {
        viewModel.loadItems(for: .drink)
    }
        
    // MARK: - CollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.currentItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! FoodCollectionViewCell
        cell.configure(with: viewModel.currentItems[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16
        let spacing: CGFloat = 10
        let availableWidth = collectionView.frame.width - padding - spacing
        let widthPerItem = availableWidth / 2
        return CGSize(width: widthPerItem, height: 250)
    }
}
