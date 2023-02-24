//
//  ConfirmLocationCell.swift
//  Motcha
//
//  Created by Justin Warmkessel on 2/22/23.
//

import Foundation
import UIKit

class ConfirmLocationCell: UITableViewCell {
    
    static let identifier = "confirmLocationCell"
    
    var confirmLocationHandler: (()->Void)?
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Confirm your Open Invite location"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let addressLabel: UILabel = {
        let view = UILabel()
        view.text = "767 Chopin Drive"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let confirmLocationButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Create", for: .normal)
        view.layer.cornerRadius = 15.0
        view.backgroundColor = .blue
        return view
    }()
        
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, confirmLocationHandler: @escaping (()->Void)) {
        super.init(style: style, reuseIdentifier: Self.identifier)
        self.confirmLocationHandler = confirmLocationHandler
        self.configCreateButtonAction()
        self.selectionStyle = .none
        setupView()
        setupConstraints()
    }
    
    func configCreateButtonAction() {
        confirmLocationButton.addTarget(self, action: #selector(pressed), for: .touchUpInside)
    }
    
    @objc func pressed() {
        guard let completion = confirmLocationHandler else { return }
        completion()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(confirmLocationButton)
    }
    
    private func setupConstraints() {
        let constraints: [NSLayoutConstraint] = [
            titleLabel.heightAnchor.constraint(equalToConstant: 60.0),
            addressLabel.heightAnchor.constraint(equalToConstant: 60.0),
            
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20.0),
                        
            addressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            addressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
            addressLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
                        
            confirmLocationButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            confirmLocationButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
            confirmLocationButton.topAnchor.constraint(equalTo: addressLabel.bottomAnchor),
            confirmLocationButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            confirmLocationButton.heightAnchor.constraint(equalToConstant: 60.0)
        ]
        
        contentView.addConstraints(constraints)
    }
}
