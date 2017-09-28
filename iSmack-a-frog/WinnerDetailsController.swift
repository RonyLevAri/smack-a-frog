//
//  WinnerDetails.swift
//  iSmack-a-frog
//
//  Created by rony_temp on 26/09/2017.
//  Copyright © 2017 rony_temp. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class WinnerDetailController: UIViewController, CLLocationManagerDelegate {
    
    var points: Int!
    
    var dataAccessObject: DataManager!
    
    @IBOutlet weak var tfWinnerName: UITextField!
    
    @IBOutlet weak var lblPoints: UILabel!
    
    let locationManager = CLLocationManager()
    
    var winnerLocation: CLLocationCoordinate2D?
    
    var winner: Player?
    
    deinit {
        print("I am destroyed \(self)")
    }
    
    override func viewDidLoad() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        lblPoints.text = String(points) + " points!"
    }
    
    @IBAction func closeDetailScreen(_ sender: UIButton) {
        let playername = tfWinnerName.text! == "" ? "Annonymous" : tfWinnerName.text!
        winner = Player(score: points, name: playername, latitude: winnerLocation?.latitude ?? 0.0, longitude: winnerLocation?.longitude ?? 0.0)
        dataAccessObject.save(winner: winner!)
        performSegue(withIdentifier: "toWinnerFronDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? GameSummaryViewController {
            controller.dataAccessObject = dataAccessObject
            controller.winner = winner
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("im in the location function")
        winnerLocation = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
    }
}

