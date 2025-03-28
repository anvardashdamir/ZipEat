//
//  ShoppingCardViewController.swift
//  Zolt Delivery
//
//  Created by Enver Dashdemirov on 05.02.25.
//

import UIKit

class ShoppingBasketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var basketItems: [FoodItem] = []

    // MARK: - UI Components
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Tasty choices"
        title.font = .boldSystemFont(ofSize: 30)
        title.textColor = .black
        return title
    }()
    
    let clearAll: GradientButton = {
        let button = GradientButton()
        button.setTitle("Clear", for: .normal)
        button.addTarget(self, action: #selector(clearBasket), for: .touchUpInside)
        return button
    }()
    
    let headerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()

    let orderList: UITableView = {
        let tableview = UITableView()
        tableview.register(ShoppingBasketViewCell.self, forCellReuseIdentifier: "BasketCell")
        tableview.backgroundColor = .clear
        tableview.layer.cornerRadius = 10
        tableview.allowsSelection = false
        return tableview
    }()
    
    let orderButton: AnimatedButton = {
        let button = AnimatedButton()
        button.setTitle("ORDER", for: .normal)
        button.addTarget(self, action: #selector(orderFood), for: .touchUpInside)
        return button
    }()
    
    @objc func orderFood() {
        print("Foods ordered successfully...")
    }
    
    @objc func clearBasket() {
        BasketManager.shared.clearBasket()
        basketItems.removeAll()
        orderList.reloadData()
        
        NotificationCenter.default.post(name: NSNotification.Name("BasketUpdated"), object: nil)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        orderList.delegate = self
        orderList.dataSource = self
        
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        basketItems = BasketManager.shared.getBasketItems()
        orderList.reloadData()
    }
    
    func setupLayout() {
        view.addSubview(headerStack)
        view.addSubview(orderList)
        view.addSubview(orderButton)
        
        headerStack.addArrangedSubview(titleLabel)
        headerStack.addArrangedSubview(clearAll)
        
        headerStack.translatesAutoresizingMaskIntoConstraints = false
        orderList.translatesAutoresizingMaskIntoConstraints = false
        orderButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            headerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            orderList.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: 8),
            orderList.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            orderList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            orderButton.topAnchor.constraint(equalTo: orderList.bottomAnchor, constant: 8),
            orderButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            orderButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            orderButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            orderButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basketItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BasketCell", for: indexPath) as? ShoppingBasketViewCell else {
            return UITableViewCell()
        }
        
        let item = basketItems[indexPath.row]
        cell.configure(with: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            BasketManager.shared.removeItem(at: indexPath.row)
            basketItems = BasketManager.shared.getBasketItems()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            
            NotificationCenter.default.post(name: NSNotification.Name("BasketUpdated"), object: nil)
        }
    }

}
