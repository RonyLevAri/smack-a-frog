//
//  WinnerDetails.swift
//  iSmack-a-frog
//
//  Created by rony_temp on 26/09/2017.
//  Copyright © 2017 rony_temp. All rights reserved.
//

import UIKit

class WinnerDetailController: UIViewController {
    
    var points: Int!
    
    let dataAccessObject = DataManager()
    
    @IBOutlet weak var tfWinnerName: UITextField!
    
    @IBOutlet weak var lblPoints: UILabel!
    
    @IBAction func closeDetailScreen(_ sender: UIButton) {
        print("closing details window")
        var playername = ""
        if tfWinnerName.text == nil {
            playername = "Annonymous"
        } else {
            playername = tfWinnerName.text!
        }
        let player = Player(score: points, name: playername, latitude: 0.0, longitude: 0.0)
        dataAccessObject.save(winner: player)
        performSegue(withIdentifier: "toWinnerFronDetails", sender: self)
    }
    
    override func viewDidLoad() {
        lblPoints.text = String(points) + " points!"
    }

}
