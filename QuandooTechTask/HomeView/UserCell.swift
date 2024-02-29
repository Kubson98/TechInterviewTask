//
//  UserCell.swift
//  QuandooTechTask
//
//  Created by Jakub Sędal on 25/02/2024.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var nameContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var nameLabelContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private let nameImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "a.circle")
        image.tintColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var usernameContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var usernameLabelContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private let usernameImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.circle")
        image.tintColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let usernameValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emailContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var emailLabelContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private let emailImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "at")
        image.contentMode = .scaleAspectFit
        image.tintColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addressContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var addressLabelContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private let addressImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "envelope")
        image.tintColor = .white
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addressValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        addSubview(containerView)
        containerView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(nameContentStackView)
        contentStackView.addArrangedSubview(usernameContentStackView)
        contentStackView.addArrangedSubview(emailContentStackView)
        contentStackView.addArrangedSubview(addressContentStackView)
        
        nameContentStackView.addArrangedSubview(nameImage)
        nameContentStackView.addArrangedSubview(nameLabelContentStackView)
        nameLabelContentStackView.addArrangedSubview(nameLabel)
        nameLabelContentStackView.addArrangedSubview(nameValueLabel)
        
        usernameContentStackView.addArrangedSubview(usernameImage)
        usernameContentStackView.addArrangedSubview(usernameLabelContentStackView)
        usernameLabelContentStackView.addArrangedSubview(usernameLabel)
        usernameLabelContentStackView.addArrangedSubview(usernameValueLabel)
        
        addressContentStackView.addArrangedSubview(addressImage)
        addressContentStackView.addArrangedSubview(addressLabelContentStackView)
        addressLabelContentStackView.addArrangedSubview(addressLabel)
        addressLabelContentStackView.addArrangedSubview(addressValueLabel)
        
        emailContentStackView.addArrangedSubview(emailImage)
        emailContentStackView.addArrangedSubview(emailLabelContentStackView)
        emailLabelContentStackView.addArrangedSubview(emailLabel)
        emailLabelContentStackView.addArrangedSubview(emailValueLabel)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            contentStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            contentStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            contentStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            contentStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            nameContentStackView.widthAnchor.constraint(lessThanOrEqualTo: contentStackView.widthAnchor),
            nameContentStackView.heightAnchor.constraint(lessThanOrEqualTo: contentStackView.heightAnchor),
            
            nameImage.widthAnchor.constraint(equalToConstant: 30),
            
            usernameContentStackView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),
            usernameContentStackView.heightAnchor.constraint(lessThanOrEqualTo: contentStackView.heightAnchor),
            
            usernameImage.widthAnchor.constraint(equalToConstant: 30),
            
            emailContentStackView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),
            emailContentStackView.heightAnchor.constraint(lessThanOrEqualTo: contentStackView.heightAnchor),
            emailImage.widthAnchor.constraint(equalToConstant: 30),
            
            addressContentStackView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),
            addressContentStackView.heightAnchor.constraint(lessThanOrEqualTo: contentStackView.heightAnchor),
            
            addressImage.widthAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    func configure(with user: User) {
        containerView.backgroundColor = UIColor(red: 0.19, green: 0.18, blue: 0.11, alpha: 1.00)
        nameLabel.text = "Name"
        nameValueLabel.text = user.name
        usernameLabel.text = "User Name"
        usernameValueLabel.text = user.username
        emailLabel.text = "Email"
        emailValueLabel.text = user.email
        addressLabel.text = "Address"
        addressValueLabel.text = user.address
    }
}
