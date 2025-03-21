//
//  SignPage.swift
//  Zolt Delivery
//
//  Created by Enver Dashdemirov on 12.03.25.
//

import UIKit

class SignPage: UIViewController {
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let signUPLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let toggleSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.onTintColor = UIColor.systemBlue
        toggle.addTarget(self, action: #selector(switchToggled), for: .valueChanged)
        return toggle
    }()
    
    private let registerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let flipContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 5
        return view
    }()
    
    private let frontView = LoginView()
    private let backView = SignUpView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    
    // Dismiss keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        pressureInput.resignFirstResponder()
//    }
    
    private func setupUI() {
        view.addSubview(registerStackView)
        registerStackView.addArrangedSubview(loginLabel)
        registerStackView.addArrangedSubview(toggleSwitch)
        registerStackView.addArrangedSubview(signUPLabel)
//        view.addSubview(toggleSwitch)
        view.addSubview(flipContainer)
        
        flipContainer.addSubview(frontView)
        flipContainer.addSubview(backView)
        
        toggleSwitch.translatesAutoresizingMaskIntoConstraints = false
        flipContainer.translatesAutoresizingMaskIntoConstraints = false
        frontView.translatesAutoresizingMaskIntoConstraints = false
        backView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            flipContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            flipContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            flipContainer.widthAnchor.constraint(equalToConstant: 300),
            flipContainer.heightAnchor.constraint(equalToConstant: 350),
            
            frontView.topAnchor.constraint(equalTo: flipContainer.topAnchor),
            frontView.leadingAnchor.constraint(equalTo: flipContainer.leadingAnchor),
            frontView.trailingAnchor.constraint(equalTo: flipContainer.trailingAnchor),
            frontView.bottomAnchor.constraint(equalTo: flipContainer.bottomAnchor),
            
            backView.topAnchor.constraint(equalTo: flipContainer.topAnchor),
            backView.leadingAnchor.constraint(equalTo: flipContainer.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: flipContainer.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: flipContainer.bottomAnchor),
            
            registerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            registerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            registerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
            
//            toggleSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            toggleSwitch.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),

        ])
        
        backView.isHidden = true
    }
    
    @objc private func switchToggled() {
        let showBack = toggleSwitch.isOn
        
        UIView.transition(with: flipContainer, duration: 0.8, options: .transitionFlipFromRight, animations: {
            self.frontView.isHidden = showBack
            self.backView.isHidden = !showBack
        })
    }
}

class LoginView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView(
            title: "Login",
            emailText: CustomTextField(),
            passwordText: PasswordTextField(),
            buttonText: AnimatedButton()
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(title: String, emailText: UITextField, passwordText: UITextField, buttonText: UIButton) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        emailText.placeholder = "Email"
        emailText.borderStyle = .roundedRect
        
        passwordText.placeholder = "Password"
        passwordText.borderStyle = .roundedRect
        passwordText.isSecureTextEntry = true
        
        buttonText.setTitle("Let's go!", for: .normal)
        buttonText.backgroundColor = .white
        buttonText.layer.cornerRadius = 10
        
        // Add subviews
        addSubview(titleLabel)
        addSubview(emailText)
        addSubview(passwordText)
        addSubview(buttonText)
        
        // Disable autoresizing masks
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        emailText.translatesAutoresizingMaskIntoConstraints = false
        passwordText.translatesAutoresizingMaskIntoConstraints = false
        buttonText.translatesAutoresizingMaskIntoConstraints = false
        
        // Set up constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            emailText.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            emailText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            emailText.heightAnchor.constraint(equalToConstant: 40),
            
            passwordText.topAnchor.constraint(equalTo: emailText.bottomAnchor, constant: 20),
            passwordText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            passwordText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            passwordText.heightAnchor.constraint(equalToConstant: 40),
            
            buttonText.topAnchor.constraint(equalTo: passwordText.bottomAnchor, constant: 20),
            buttonText.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            buttonText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            buttonText.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}


class SignUpView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView(
            title: "Sign Up",
            name: CustomTextField(),
            emailText: CustomTextField(),
            passwordText: PasswordTextField(),
            buttonText: AnimatedButton()
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(title: String, name: UITextField, emailText: UITextField, passwordText: UITextField, buttonText: UIButton) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        name.placeholder = "Name"
        name.borderStyle = .roundedRect
        
        emailText.placeholder = "Email"
        emailText.borderStyle = .roundedRect
        
        passwordText.placeholder = "Password"
        passwordText.borderStyle = .roundedRect
        passwordText.isSecureTextEntry = true
        
        buttonText.setTitle("Confirm!", for: .normal)
        buttonText.backgroundColor = .white
        buttonText.layer.cornerRadius = 10
        buttonText.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        
        
        // Add subviews
        addSubview(titleLabel)
        addSubview(name)
        addSubview(emailText)
        addSubview(passwordText)
        addSubview(buttonText)
        
        // Disable autoresizing masks
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        emailText.translatesAutoresizingMaskIntoConstraints = false
        passwordText.translatesAutoresizingMaskIntoConstraints = false
        buttonText.translatesAutoresizingMaskIntoConstraints = false
        
        // Set up constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            name.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            name.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            name.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            name.heightAnchor.constraint(equalToConstant: 40),
            
            
            emailText.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 20),
            emailText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            emailText.heightAnchor.constraint(equalToConstant: 40),
            
            
            passwordText.topAnchor.constraint(equalTo: emailText.bottomAnchor, constant: 20),
            passwordText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            passwordText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            passwordText.heightAnchor.constraint(equalToConstant: 40),
            
            
            buttonText.topAnchor.constraint(equalTo: passwordText.bottomAnchor, constant: 20),
            buttonText.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            buttonText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            buttonText.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func signUpTapped() {
        if let parentVC = findViewController() {
            let vc = MainViewController()
            vc.modalPresentationStyle = .fullScreen
            parentVC.present(vc, animated: true, completion: nil)
        }
    }
    
    // MARK: - Find Parent ViewController
    private func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            responder = nextResponder
        }
        return nil
    }
}
