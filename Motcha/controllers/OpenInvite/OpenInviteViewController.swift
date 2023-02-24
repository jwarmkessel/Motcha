//
//  OpenInviteViewController.swift
//  Motcha
//
//  Created by Justin Warmkessel on 2/10/23.
//

import UIKit
import WebKit
import MapKit


class OpenInviteViewController: UIViewController, UIGestureRecognizerDelegate, MKMapViewDelegate {
	
    private let TAG = "OpenInviteViewController"
    
    private var locationManager: CLLocationManager?
    
    private var currentAnnotation: MKAnnotation?
    
    private var sheetViewModel: SheetViewModel? = nil
    
    private var sheetController: SheetController?
    
    
    private let mapView = {
        let view = MKMapView()
        view.showsUserLocation = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
	    
	override func viewDidLoad() {
		super.viewDidLoad()
				
        setupSheetAction()
        setupMapView()
        zoomToUserLocation()
        addLongPressGesture()
	}
    
    private func addLongPressGesture() {
        let lpgr = UILongPressGestureRecognizer(target: self,
                             action:#selector(self.handleLongPress))
        lpgr.minimumPressDuration = 1.0
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        self.mapView.addGestureRecognizer(lpgr)
    }
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state != UIGestureRecognizer.State.ended {
            return
        }
        else if gestureRecognizer.state != UIGestureRecognizer.State.began {
            
            let touchPoint = gestureRecognizer.location(in: self.mapView)
            
            if let annot = currentAnnotation {
                mapView.removeAnnotation(annot)
            }
            
            let touchMapCoordinate =  self.mapView.convert(touchPoint, toCoordinateFrom: mapView)
            let newAnnotation = MapPin(coordinate: touchMapCoordinate, title: "Hello", subtitle: "World")
            self.mapView.addAnnotation(newAnnotation)
            self.currentAnnotation = newAnnotation
            
            self.mapView.setCenter(newAnnotation.coordinate, animated: true)
            
            sheetViewModel = SheetViewModel(state: .confirmLocation, coordinates: touchMapCoordinate)
            
            guard let model = sheetViewModel else { return }
            presentSheet(model: model)
        }
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
//            self?.presentSheet()
        }
        
        navigationItem.rightBarButtonItem = .init(systemItem: .add, primaryAction: action, menu: nil)
    }
    
    private func presentSheet(model: SheetViewModel) {
        self.sheetController = SheetController(viewModel: model) { state in
            switch state {
            case .confirmLocation:
                model.state = .createOpenInvite
            case .createOpenInvite:
                model.state = .inSession
            case .inSession:
                model.state = .confirmLocation
            }
            
            guard let controller = self.sheetController else { return }
            controller.viewModel = model
            controller.transitioningDelegate = self
            controller.modalPresentationStyle = .custom
            self.present(controller, animated: true)
        }
        
        guard let controller = sheetController else { return }
        
        controller.transitioningDelegate = self
        controller.modalPresentationStyle = .custom
        self.present(controller, animated: true)
        
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

extension OpenInviteViewController: UIViewControllerTransitioningDelegate {
    func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        let controller = UISheetPresentationController(presentedViewController: presented, presenting: presenting)
        controller.prefersScrollingExpandsWhenScrolledToEdge = true
        
        let newDetente = UISheetPresentationController.Detent.custom { context in
            guard let state = self.sheetViewModel?.state else {
                return 0.0
            }
            print("Justin \(OpenInviteState.sheetHeight(state)())")
            return OpenInviteState.sheetHeight(state)()
        }
        
        controller.detents = [newDetente]
        controller.prefersGrabberVisible = true
        
        return controller
    }
}
