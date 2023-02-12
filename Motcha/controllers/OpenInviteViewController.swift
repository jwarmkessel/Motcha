//
//  OpenInviteViewController.swift
//  Motcha
//
//  Created by Justin Warmkessel on 2/10/23.
//

import UIKit
import WebKit
import MapKit

class OpenInviteViewController: UIViewController {
	
    private let TAG = "OpenInviteViewController"
    
    private let mapView = {
        let view = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
	let sheetTransitioningDelegate = SheetTransitioningDelegate()
	
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let action = UIAction { [weak self] _ in
			let controller = SheetController()
			controller.transitioningDelegate = self?.sheetTransitioningDelegate
			controller.modalPresentationStyle = .custom
			self?.present(controller, animated: true)
		}
		navigationItem.rightBarButtonItem = .init(systemItem: .add, primaryAction: action, menu: nil)
        
        setupMapView()
	}
    
    private func setupMapView() {
        view.addSubview(mapView)
        
        let constraints: [NSLayoutConstraint] = [
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0)
        ]
        
        view.addConstraints(constraints)
    }
}
