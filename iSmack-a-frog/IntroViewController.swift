//
//  ViewController.swift
//  iSmack-a-frog
//
//  Created by rony_temp on 08/07/2017.
//  Copyright © 2017 rony_temp. All rights reserved.
//

import UIKit


class IntroViewController: UIViewController {
    
    private var difficulty = GameDifficulty.Normal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("I am in the view did load of the main game menu \(self)")
    }
    
    deinit {
        print("I am destroyed \(self)")
    }

    @IBOutlet private weak var btnEasy: UIButton! {
        didSet {
            btnEasy.layer.cornerRadius = 2;
            btnEasy.layer.borderWidth = 1;
            btnEasy.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    @IBOutlet private weak var btNormal: UIButton! {
        didSet {
            btNormal.layer.cornerRadius = 2;
            btNormal.layer.borderWidth = 1;
            btNormal.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    @IBOutlet private weak var btnHard: UIButton! {
        didSet {
            btnHard.layer.cornerRadius = 2;
            btnHard.layer.borderWidth = 1;
            btnHard.layer.borderColor = UIColor.white.cgColor
        }
    }

    @IBOutlet private weak var starEasy: UIImageView!
    
    @IBOutlet private weak var starNormal: UIImageView!
    
    @IBOutlet private weak var starHard: UIImageView!
    
    @IBAction private func onDifficultyChosen(_ sender: UIButton) {
        if let text = sender.titleLabel?.text {
            let chosenDifficulty = GameDifficulty(rawValue: text)!
            difficulty = chosenDifficulty
            displayStarAboveChosenDifficultyButton(chosenDifficulty)
        }
    }
    
    private func displayStarAboveChosenDifficultyButton(_ chosenDifficulty: GameDifficulty) {
        switch chosenDifficulty {
        case .Easy:
            starEasy.image = UIImage(named: "Star")
            starNormal.image = UIImage(named: "blue_star")
            starHard.image = UIImage(named: "blue_star")
        case .Normal:
            starEasy.image = UIImage(named: "blue_star")
            starNormal.image = UIImage(named: "Star")
            starHard.image = UIImage(named: "blue_star")
        case .Hard:
            starEasy.image = UIImage(named: "blue_star")
            starNormal.image = UIImage(named: "blue_star")
            starHard.image = UIImage(named: "Star")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationRoot = (segue.destination as? UINavigationController)?.viewControllers.first
        if let destGameController = destinationRoot as? GameViewController {
            let configuration = GameConfig(difficulty: difficulty, boardSize: BoardSize(rows: 5, columns: 3))
            destGameController.gameConfig = configuration
        }
    }
    
}

