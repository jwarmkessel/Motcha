//
//  SheetViewModel.swift
//  Motcha
//
//  Created by Justin Warmkessel on 2/21/23.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

enum OpenInviteState {
    case confirmLocation
    case createOpenInvite
    case inSession
    
    func sheetHeight() -> CGFloat
    {
        switch self
        {
        case .confirmLocation:
            return 240.0
        case .createOpenInvite:
            return 294.0
        case .inSession:
            return 120.0
        }
    }
}

class SheetViewModel {
    
    var state = OpenInviteState.confirmLocation
    var coordinates: CLLocationCoordinate2D
    var address: [CLPlacemark]?
    
    init(state: OpenInviteState, coordinates: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0.0, 0.0)) {
        self.state = state
        self.coordinates = coordinates
        
        if state == .confirmLocation {
            reverseCoordinates(longitude: coordinates.longitude, latitude: coordinates.latitude)
        }
    }
    
    // Return an address based on coordinates
    private func reverseCoordinates(longitude: CLLocationDegrees, latitude: CLLocationDegrees) {
        let address = CLGeocoder.init()
        address.reverseGeocodeLocation(CLLocation.init(latitude: latitude, longitude:longitude)) { (places, error) in
            if error == nil{
                self.address = places
                
                /* Sample
                 421 Launiu St, 421 Launiu St, Honolulu, HI  96815, United States @ <+21.28291032,-157.82908722> +/- 100.00m, region CLCircularRegion (identifier:'<+21.28284750,-157.82907910> radius 70.54', center:<+21.28284750,-157.82907910>, radius:70.54m)
                 */
            }
        }
    }
    
    // Search for a restaurant name
    func searchBy(naturalLanguageQuery: String, region: MKCoordinateRegion, coordinates: CLLocationCoordinate2D, completionHandler: @escaping (_ response: MKLocalSearch.Response?, _ error: Error?) -> Void) {
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = naturalLanguageQuery
        request.region = region
        
        let search = MKLocalSearch(request: request)
            search.start { response, error in
            completionHandler(response, error)
        }
    }
    
    func sheetHeight(state: OpenInviteState) -> CGFloat {
        return OpenInviteState.sheetHeight(state)()
    }
}
