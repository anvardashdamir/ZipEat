//
//  ProfileViewController.swift
//  Zolt Delivery
//
//  Created by Enver Dashdemirov on 05.02.25.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - UI Elements
    let profileTitle: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.black.cgColor
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "John Smith"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    let clientEmailLabel: UILabel = {
        let label = UILabel()
        label.text = "Client Email: 123456"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .darkGray
        label.textAlignment = .left
        return label
    }()
    
    let profileEdit: UIView = {
        let imageView = UIView()
        imageView.layer.cornerRadius = 5
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.backgroundColor = UIColor.white
        
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 4, height: 4)
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowRadius = 0
        
        return imageView
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
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupLayout()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        profileImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectProfileImage))
        profileImageView.addGestureRecognizer(tapGesture)
        
        loadProfileData()
    }
     
    // MARK: - Layout
    func setupLayout() {
        view.addSubview(profileTitle)
        view.addSubview(profileEdit)
        view.addSubview(tableView)
        view.addSubview(logoutButton)
        
        profileEdit.addSubview(profileImageView)
        profileEdit.addSubview(nameLabel)
        profileEdit.addSubview(clientEmailLabel)
        
        profileTitle.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        clientEmailLabel.translatesAutoresizingMaskIntoConstraints = false
        profileEdit.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            profileTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            profileEdit.topAnchor.constraint(equalTo: profileTitle.bottomAnchor, constant: 16),
            profileEdit.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            profileEdit.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            profileEdit.heightAnchor.constraint(equalToConstant: 120),
            
            profileImageView.leadingAnchor.constraint(equalTo: profileEdit.leadingAnchor, constant: 16),
            profileImageView.centerYAnchor.constraint(equalTo: profileEdit.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: profileEdit.topAnchor, constant: 24),
            nameLabel.trailingAnchor.constraint(equalTo: profileEdit.trailingAnchor, constant: -16),
            
            clientEmailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            clientEmailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            clientEmailLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: profileEdit.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: logoutButton.topAnchor, constant: -20),
            
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            logoutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
        
    // MARK: - TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = profileItems[indexPath.row]
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
            selectedViewController = OrderHistoryViewController()
        case 1:
            selectedViewController = PaymentMethodViewController()
        case 2:
            selectedViewController = GetHelpViewController()
        default:
            return
        }
        navigationController?.pushViewController(selectedViewController, animated: true)
    }
    
    // MARK: - Actions
    func loadProfileData() {
        if let savedName = UserDefaults.standard.string(forKey: "userName") {
            nameLabel.text = savedName
        }
        
        if let savedEmail = UserDefaults.standard.string(forKey: "userEmail") {
            clientEmailLabel.text = savedEmail
        }
        
        if let imageData = UserDefaults.standard.data(forKey: "profileImage"),
           let savedImage = UIImage(data: imageData) {
            profileImageView.image = savedImage
        }
    }

    @objc func logoutTapped() {
        let vc = SignInViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @objc func selectProfileImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    // Handle the image selection
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
            profileImageView.image = selectedImage
            
            // Save the image using UserDefaultsManager
            UserDefaultsManager.shared.saveUser(
                name: nameLabel.text ?? "",
                email: clientEmailLabel.text ?? "",
                password: "",
                image: selectedImage
            )
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func saveProfileImage(image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            UserDefaults.standard.set(imageData, forKey: "profileImage")
        }
    }
}

