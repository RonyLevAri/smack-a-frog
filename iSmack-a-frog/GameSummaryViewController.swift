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

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var earthImage: UIImageView!
    
    @IBOutlet weak var mapTxet: UILabel!
    
    @IBOutlet weak var pointLabel: UILabel!
    
    var points: Int!
    
    let dataAccessObject = DataManager()
    
    var winners: [PersistablePlayer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapTxet.isUserInteractionEnabled = true
        earthImage.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(loadWinnerMap(tapGestureRecognizer:)))
        
        mapTxet.addGestureRecognizer(tapGesture)
        earthImage.addGestureRecognizer(tapGesture)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.isScrollEnabled = false
        tableView.separatorColor = UIColor.clear
        // tableView.isHidden = true
        
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
    
    func loadWinnerMap(tapGestureRecognizer: UITapGestureRecognizer) {
        print("opening map")
    }
}

extension GameSummaryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = winners[0].description
        return cell
    }
}

extension GameSummaryViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}
