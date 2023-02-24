//
//  TimeEntryView.swift
//  Motcha
//
//  Created by Justin Warmkessel on 2/19/23.
//

import UIKit

class TimeEntryView: UIView {
    
    let label: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let time: UIDatePicker = {
        let view = UIDatePicker()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.datePickerMode = .time
        return view
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setup()
        setupContraints()
    }
    
    private func setup() {
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1.0
        addSubview(label)
        addSubview(time)
    }
    
    private func setupContraints() {
        let constraints: [NSLayoutConstraint] = [
            label.heightAnchor.constraint(equalToConstant: 60.0), //set to half height computed value
            time.heightAnchor.constraint(equalToConstant: 60.0), //set to half height computed value
            
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            
            time.centerXAnchor.constraint(equalTo: centerXAnchor),
            time.topAnchor.constraint(equalTo: label.bottomAnchor)
        ]
        
        addConstraints(constraints)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
