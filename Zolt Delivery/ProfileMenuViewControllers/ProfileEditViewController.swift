//
//  ProfileEditViewController.swift
//  ZipEat
//
//  Created by Dashdemirli Enver on 28.03.25.
//

import UIKit

protocol ProfileEditDelegate: AnyObject {
    func didUpdateProfile(name: String, image: UIImage?)
}

class ProfileEditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    weak var delegate: ProfileEditDelegate?
    
    let nameTextField: NameTextField = {
        let textField = NameTextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let saveButton: AnimatedButton = {
        let button = AnimatedButton()
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(saveChanges), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupLayout()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectProfileImage))
        profileImageView.addGestureRecognizer(tapGesture)
        
        loadProfileData()
    }
    
    func setupLayout() {
        view.addSubview(nameTextField)
        view.addSubview(profileImageView)
        view.addSubview(saveButton)
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            
            nameTextField.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            saveButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            saveButton.widthAnchor.constraint(equalToConstant: 240)
        ])
    }
    
    @objc func selectProfileImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            profileImageView.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            profileImageView.image = originalImage
        }
        dismiss(animated: true)
    }
    
    @objc func saveChanges() {
        let name = nameTextField.text ?? "Unknown"
        let image = profileImageView.image
        
        // Save to UserDefaults
        UserDefaults.standard.set(name, forKey: "profileName")
        if let imageData = image?.jpegData(compressionQuality: 0.8) {
            UserDefaults.standard.set(imageData, forKey: "profileImage")
        }
        
        delegate?.didUpdateProfile(name: name, image: image)
        navigationController?.popViewController(animated: true)
    }
    
    // Load saved data
    func loadProfileData() {
        nameTextField.text = UserDefaults.standard.string(forKey: "profileName") ?? "John Smith"
        if let imageData = UserDefaults.standard.data(forKey: "profileImage"),
           let image = UIImage(data: imageData) {
            profileImageView.image = image
        }
    }
}
