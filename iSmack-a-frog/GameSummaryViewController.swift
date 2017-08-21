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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pointLabel.text = String(points) + " points"
    }
}
