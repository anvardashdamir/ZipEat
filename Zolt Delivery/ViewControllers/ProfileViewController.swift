//
//  ProfileViewController.swift
//  Zolt Delivery
//
//  Created by Enver Dashdemirov on 05.02.25.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    // MARK: - UI Elements
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = .white
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    
    let fullName: UILabel = {
        let label = UILabel()
        label.text = "Welcome (user)"
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
        
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 60
        return tableView
    }()
    
    let logoutButton: AnimatedButton = {
        let button = AnimatedButton()
        button.setTitle("Log Out", for: .normal)
        button.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Tableview name and icon list
    let menuItems = [
        ("Account", "person.crop.circle"),
        ("Order History", "cart.circle"),
        ("Payment Methods", "creditcard.circle"),
        ("Get Help", "questionmark.circle")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupLayout()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setupLayout() {
        view.addSubview(profileImage)
        view.addSubview(fullName)
        view.addSubview(tableView)
        view.addSubview(logoutButton)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        fullName.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            profileImage.widthAnchor.constraint(equalToConstant: 100),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            
            fullName.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 16),
            fullName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            fullName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            
            tableView.topAnchor.constraint(equalTo: fullName.bottomAnchor, constant: 32),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: logoutButton.topAnchor, constant: -20),
            
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            logoutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Log out action
    @objc func logoutTapped() {
        let vc = SignPage()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    // MARK: - TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = menuItems[indexPath.row]
        cell.textLabel?.text = item.0
        cell.textLabel?.font = .systemFont(ofSize: 18)
        cell.imageView?.image = UIImage(systemName: item.1)?.withTintColor(.black, renderingMode: .alwaysOriginal) // Black icons
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedViewController: UIViewController
        
        switch indexPath.row {
        case 0:
            selectedViewController = AccountViewController()
        case 1:
            selectedViewController = OrderHistoryViewController()
        case 2:
            selectedViewController = PaymentMethodViewController()
        case 3:
            selectedViewController = GetHelpViewController()
        default:
            return
        }
        navigationController?.pushViewController(selectedViewController, animated: true)
    }
}
