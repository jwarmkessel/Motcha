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
    
    private var locationManager: CLLocationManager?
    
    private let mapView = {
        let view = MKMapView()
        view.showsUserLocation = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
	let sheetTransitioningDelegate = SheetTransitioningDelegate()
	
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
				
        setupSheetAction()
        setupMapView()
        zoomToUserLocation()
        
	}
    
    private func zoomToUserLocation() {        

        let locationManager = CLLocationManager()
        locationManager.delegate = self
            
        locationManager.requestAlwaysAuthorization()

        view.backgroundColor = .gray
        
        
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        // Check for Location Services
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }

        //Zoom to user location
        if let userLocation = locationManager.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 200, longitudinalMeters: 200)
            mapView.setRegion(viewRegion, animated: false)
        }

        self.locationManager = locationManager

        DispatchQueue.main.async {
            self.locationManager?.startUpdatingLocation()
        }

    }
    
    private func setupSheetAction() {
                
        let action = UIAction { [weak self] _ in
            let controller = SheetController()
            controller.transitioningDelegate = self?.sheetTransitioningDelegate
            controller.modalPresentationStyle = .custom
            self?.present(controller, animated: true)
        }
        
        navigationItem.rightBarButtonItem = .init(systemItem: .add, primaryAction: action, menu: nil)
    }
    
    private func setupMapView() {
        mapView.delegate = self
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

extension OpenInviteViewController: MKMapViewDelegate {
    
}

extension OpenInviteViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    // do stuff
                    print("DO STUFF")
                }
            }
        }
    }
}
