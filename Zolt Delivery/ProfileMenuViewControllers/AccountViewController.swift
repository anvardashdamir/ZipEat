//
//  AccountViewController.swift
//  Zolt Delivery
//
//  Created by Enver Dashdemirov on 14.03.25.
//

import UIKit

class AccountViewController: UIViewController {
    
    var label: UILabel = {
        let label = UILabel()
        label.text = "not ready yet"
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .white
    }
    
    private func setupUI() {
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
