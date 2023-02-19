//
//  MapPin.swift
//  Motcha
//
//  Created by Justin Warmkessel on 2/19/23.
//

import Foundation
import CoreLocation
import MapKit

class MapPin : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?

    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
