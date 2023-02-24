//
//  OpenInviteSessionCell.swift
//  Motcha
//
//  Created by Justin Warmkessel on 2/19/23.
//

import UIKit

class OpenInviteSessionCell: UITableViewCell {
    let identifier = "openInviteSessionCell"
    
    var cancelOpenInviteHandler: (()->Void)?
    
    private let cancelButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Cancel", for: .normal)
        view.layer.cornerRadius = 15.0
        view.backgroundColor = .blue
        return view
    }()
        
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, openInviteHandler: @escaping (()->Void)) {
        super.init(style: style, reuseIdentifier: identifier)
        self.cancelOpenInviteHandler = openInviteHandler
        self.configButtonAction()
        self.setupView()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configButtonAction() {
        cancelButton.addTarget(self, action: #selector(pressed), for: .touchUpInside)
    }
    
    @objc func pressed() {
        guard let completion = cancelOpenInviteHandler else { return }
        completion()
    }
    
    private func setupView() {
        contentView.addSubview(cancelButton)
    }
    
    private func setupConstraints() {
        let constraints: [NSLayoutConstraint] = [
            cancelButton.heightAnchor.constraint(equalToConstant: 120.0),
            cancelButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
            cancelButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            cancelButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20.0),
            cancelButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20.0),
        ]
        
        contentView.addConstraints(constraints)
    }
}
