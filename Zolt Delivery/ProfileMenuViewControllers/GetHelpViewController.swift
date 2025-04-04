//
//  GetHelpViewController.swift
//  Zolt Delivery
//
//  Created by Enver Dashdemirov on 14.03.25.
//


import UIKit

class GetHelpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Get Help"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "We're here to help! Please choose an option below."
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()

    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        view.backgroundColor = .white
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HelpOptionCell.self, forCellReuseIdentifier: HelpOptionCell.identifier)
    }

    let helpOptions = [
        "FAQ",
        "Contact Support",
        "Adresse",
    ]

    let helpDetails = [
        "FAQ": """
        Frequently asked questions and answers.
        
        Q: How do I change my name and profile photo?
        A: Go to Profile > Client ID > Input new name and photo.
        
        Q: What payment methods do you accept?
        A: We accept credit cards (Visa, Mastercard), ApplePay, GooglePay, and Cash.
                
        Q: What are your business hours?
        A: Our support team is available Monday-Friday, 9:00 AM to 6:00 PM local time.
        
        Q: Can I change my account email address?
        A: No, you can't change it.
        """,
        
        "Contact Support": "Contact our support team for assistance:\n+994 55 123 45 67",
        "Adresse": "18 Liberty Street, Baku, Azerbaijan"
    ]
    
    var expandedRows: Set<Int> = []

    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            tableView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }

    // MARK: - TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return helpOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HelpOptionCell.identifier, for: indexPath) as! HelpOptionCell
        let title = helpOptions[indexPath.row]
        let detail = helpDetails[title] ?? ""
        let isExpanded = expandedRows.contains(indexPath.row)
        
        cell.configure(title: title, detail: detail, isExpanded: isExpanded)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if expandedRows.contains(indexPath.row) {
            expandedRows.remove(indexPath.row)
        } else {
            expandedRows.insert(indexPath.row)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
