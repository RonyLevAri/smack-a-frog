//
//  MapViewController.swift
//  iSmack-a-frog
//
//  Created by rony_temp on 28/09/2017.
//  Copyright © 2017 rony_temp. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var map: MKMapView!
    
    var dataAccessObject: DataManager!
    
    var winner: Player?
    
    let regionRadius: CLLocationDistance = 1000
    
    deinit {
        print("I am destroyed \(self)")
    }
    
    override func viewDidLoad() {
        
        let winners = dataAccessObject.winners
        let annotatedWinners: [Winner] = winners.map({
            (p: PersistablePlayer) -> Winner in
            return Winner(title: p.name, locationName: p.score, discipline: "winner", coordinate: CLLocationCoordinate2D(latitude: Double(p.latitude)!, longitude: Double(p.longitude)!))
        })
        map.addAnnotations(annotatedWinners)
        
        // let initialLocation = CLLocation(latitude: winner?.latitude ?? 21.282778, longitude: winner?.longitude ?? -157.829444)
        let initialLocation = CLLocation(latitude: winner?.latitude ?? annotatedWinners[0].coordinate.latitude, longitude: winner?.longitude ?? annotatedWinners[0].coordinate.longitude)
        centerMapOnLocation(location: initialLocation)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        map.setRegion(coordinateRegion, animated: true)
    }
}
