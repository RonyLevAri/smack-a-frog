//
//  GameSummaryViewController.swift
//  iSmack-a-frog
//
//  Created by rony_temp on 19/08/2017.
//  Copyright © 2017 rony_temp. All rights reserved.
//

import UIKit


class GameSummaryViewController: UIViewController {
    
    @IBAction func startNewGame(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBOutlet weak var pointLabel: UILabel!
    
    var points: Int!
    
    let dataAccessObject = DataManager()
    
    var winners: [PersistablePlayer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pointLabel.text = String(points) + " points"
        if dataAccessObject.isAmongWinners(with: points) {
            let player = Player(score: points, name: "pipi2", latitude: 0.0, longitude: 0.0)
            dataAccessObject.save(winner: player)
        }
        winners = dataAccessObject.winners
        for i in 0..<winners.count {
            print(winners[i])
        }
        
    }
}
