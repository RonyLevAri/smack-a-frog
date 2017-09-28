//
//  Winner.swift
//  iSmack-a-frog
//
//  Created by rony_temp on 28/09/2017.
//  Copyright © 2017 rony_temp. All rights reserved.
//

import Foundation
import MapKit

class Winner: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
