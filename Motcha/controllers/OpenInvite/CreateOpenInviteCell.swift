//
//  CreateOpenInviteCell.swift
//  Motcha
//
//  Created by Justin Warmkessel on 2/11/23.
//

import UIKit
import Foundation

class CreateOpenInviteCell: UITableViewCell {
    
    let identifier = "createOpenInviteCell"
    
    var createOpenInviteHandler: (()->Void)?
    
    
    private let vStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()
    
    private let hStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        return view
    }()
    
    private let eventNameTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "What do you want to do?"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let locationTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Where?"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let startTimeButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Start Time", for: .normal)
        view.setTitleColor(.lightGray, for: .normal)
        return view
    }()
    
    private let endTimeButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("End Time", for: .normal)
        view.setTitleColor(.lightGray, for: .normal)
        return view
    }()
    
    private let createButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Create", for: .normal)
        view.layer.cornerRadius = 15.0
        view.backgroundColor = .blue
        return view
    }()
        
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, openInviteHandler: @escaping (()->Void)) {
        super.init(style: style, reuseIdentifier: identifier)
        self.createOpenInviteHandler = openInviteHandler
        self.configCreateButtonAction()
        self.selectionStyle = .none
        setupView()
        setupConstraints()
    }
    
    func configCreateButtonAction() {
        createButton.addTarget(self, action: #selector(pressed), for: .touchUpInside)
    }
    
    @objc func pressed() {
        guard let completion = createOpenInviteHandler else { return }
        completion()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(eventNameTextField)
        contentView.addSubview(locationTextField)
        contentView.addSubview(startTimeButton)
        contentView.addSubview(endTimeButton)
        contentView.addSubview(createButton)
    }
    
    private func setupConstraints() {
        let constraints: [NSLayoutConstraint] = [
            eventNameTextField.heightAnchor.constraint(equalToConstant: 60.0),
            locationTextField.heightAnchor.constraint(equalToConstant: 60.0),
            startTimeButton.heightAnchor.constraint(equalToConstant: 60.0),
            endTimeButton.heightAnchor.constraint(equalToConstant: 60.0),

            
            eventNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            eventNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
            eventNameTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20.0),
            
            
            locationTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            locationTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
            locationTextField.topAnchor.constraint(equalTo: eventNameTextField.bottomAnchor),
            
            
            startTimeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            startTimeButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            startTimeButton.topAnchor.constraint(equalTo: locationTextField.bottomAnchor),
            
            
            endTimeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            endTimeButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            endTimeButton.topAnchor.constraint(equalTo: locationTextField.bottomAnchor),
            
            
            createButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            createButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
            createButton.topAnchor.constraint(equalTo: startTimeButton.bottomAnchor),
            createButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ]
        
        contentView.addConstraints(constraints)
    }
}
