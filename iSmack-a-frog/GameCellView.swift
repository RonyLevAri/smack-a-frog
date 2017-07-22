//
//  GameTile.swift
//  iSmack-a-frog
//
//  Created by rony_temp on 15/07/2017.
//  Copyright © 2017 rony_temp. All rights reserved.
//

import UIKit

protocol GameCellViewDelegate {
    func updateCellState(forCell: GameCellView)
}

class GameCellView: UICollectionViewCell {
    
    @IBOutlet weak var frogImage: UIImageView!
    
    var delegate: GameCellViewDelegate? = nil
    
    // var showFrog: Bool = false { didSet { setNeedsDisplay() } }
    
    //override func draw(_ rect: CGRect) {
        // Drawing code
    //}
    
    override func awakeFromNib() {
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.updateState (_:)))
        self.addGestureRecognizer(gesture)
    }
    
    func updateState(_ sender:UITapGestureRecognizer) {
        delegate?.updateCellState(forCell: self)
    }
    
    

    
    
}
