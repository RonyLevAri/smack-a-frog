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
    
    var dataAccessObject = DataManager()
    
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // print("number of sections \(tableView.description)")
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // print("number of rows in section \(tableView.description)")
        return dataAccessObject.maxWinners
    }
}

extension GameSummaryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = winners[indexPath.item].description
        // print("preparing cell number \(indexPath.item)")
        return cell
    }
    
    
}
