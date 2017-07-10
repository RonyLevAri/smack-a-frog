//
//  ViewController.swift
//  iSmack-a-frog
//
//  Created by rony_temp on 08/07/2017.
//  Copyright © 2017 rony_temp. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    private var difficulty = Difficulty.Normal

    @IBOutlet weak var btnEasy: UIButton! {
        didSet {
            btnEasy.layer.cornerRadius = 2;
            btnEasy.layer.borderWidth = 1;
            btnEasy.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    @IBOutlet weak var btNormal: UIButton! {
        didSet {
            btNormal.layer.cornerRadius = 2;
            btNormal.layer.borderWidth = 1;
            btNormal.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    @IBOutlet weak var btnHard: UIButton! {
        didSet {
            btnHard.layer.cornerRadius = 2;
            btnHard.layer.borderWidth = 1;
            btnHard.layer.borderColor = UIColor.white.cgColor
        }
    }

    @IBOutlet weak var starEasy: UIImageView! {
        didSet {
            let image = UIImage(named: "blue_star")
            starEasy.image = image
        }
    }
    
    @IBOutlet weak var starNormal: UIImageView! {
        didSet {
            starNormal.isHidden = false
        }
    }
    
    @IBOutlet weak var starHard: UIImageView! {
        didSet {
            let image = UIImage(named: "blue_star")
            starHard.image = image
        }
    }
    
    @IBAction func onDifficultyChosen(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

