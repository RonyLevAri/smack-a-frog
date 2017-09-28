//
//  GameViewController.swift
//  iSmack-a-frog
//
//  Created by rony_temp on 12/07/2017.
//  Copyright © 2017 rony_temp. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var gameBoardCollectionView: UICollectionView!
    
    @IBOutlet weak var life1: UIImageView!
    
    @IBOutlet weak var life2: UIImageView!
    
    @IBOutlet weak var life3: UIImageView!

    @IBOutlet weak var scores: UILabel!
    
    fileprivate var game: Game!
    
    var gameConfig: GameConfig!
    
    let dataAccessObject = DataManager()
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 10.0)
    
    fileprivate var cellsPerRow: CGFloat!
    
    fileprivate var cellsPerColumn: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameBoardCollectionView.dataSource = self
        gameBoardCollectionView.delegate = self
        
        scores.text = "Points: " + String(0)
        
        cellsPerRow = CGFloat(gameConfig.boardSize.columns)
        cellsPerColumn = CGFloat(gameConfig.boardSize.rows)
        
        
        let timerController = BoardTimerController(
            size: gameConfig.boardSize,
            gameConfig: gameConfig
        )
        game = Game(
            gameConfig: gameConfig,
            board: GameBoard(size: gameConfig.boardSize),
            timerController: timerController
        )
        timerController.delegate = game
        game.delegate = self
        game.startGame()
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            print("device shaken")
            //game.deviceShakened()
        }
    }
    
    func gameOverSegue() {
        let points = game.gamePoints
        let isAWinner = dataAccessObject.isAmongWinners(with: points)
        if !isAWinner {
            performSegue(withIdentifier: "toGameSummary", sender: self)
        } else {
            performSegue(withIdentifier: "toWinnerDetails", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let points = game.gamePoints
        if segue.identifier == "toWinnerDetails" {
            if let controller = segue.destination as? WinnerDetailController {
                controller.points = points
            }
        }
    }
}

extension GameViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let boardRows = game.board.cells.count
        return boardRows
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let boardColumns = game.board.cells[section].count
        return boardColumns
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let gameCell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath) as! GameCellView
        return gameCell
    }
}

extension GameViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! GameCellView
        let cellState = game.board.cells[indexPath.section][indexPath.item].state
        cell.frogImage.image = frogHoleStateToImage(state: cellState)
        
    }
    
    private func frogHoleStateToImage(state: FrogHoleState) -> UIImage? {
        print("the frog hole state is: \(state)")
        switch state {
        case .HittableAngryForg:
            return UIImage(named: "toon_mean_frog")!
        case .HittableContagiousFrog:
            return UIImage(named: "toon_sick_frog")!
        case .NonHittableNoFrog:
            return nil
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("cell tappedt at \(indexPath.section) \(indexPath.item)")
        game.cellTappedAt(row: indexPath.section, column: indexPath.item)
        
    }
}

extension GameViewController: UICollectionViewDelegateFlowLayout {
    // taken from: https://www.raywenderlich.com/136159/uicollectionview-tutorial-getting-started
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpaceHorizontaly = sectionInsets.left * (cellsPerRow + 1)
        let availableWidth = gameBoardCollectionView.bounds.width - paddingSpaceHorizontaly
        let widthPerCell = availableWidth / cellsPerRow
        let paddingSpaceVertically = sectionInsets.top * (cellsPerColumn + 1) * 2
        let availableHieght = gameBoardCollectionView.bounds.height - paddingSpaceVertically
        let heightPerCell = availableHieght / cellsPerColumn
        return CGSize(width: widthPerCell, height: heightPerCell)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension GameViewController: GameDelegate {
    func updatePoints(_ points: Int) {
        scores.text = "Points: " + String(points)
    }
    
    func updateCelltAt(_ row: Int, _ column: Int) {
        print("view controller updating cell at \(row) \(column)")
        gameBoardCollectionView.reloadItems(at: [IndexPath(item: column, section: row)])
    }
    
    func animateItemAt(_ row: Int, _ column: Int, for frogHoleState: FrogHoleState) {
        let indexPath = IndexPath(item: column, section: row)
        if let cell = gameBoardCollectionView.cellForItem(at: indexPath) as? GameCellView {
            frogHoleState == .HittableContagiousFrog ? shakeAnimation(over: cell) : shootFromScreenAnnimation(over: cell)
        }
    }
    
    func shakeAnimation(over cell: GameCellView) {
        // taken from: https://www.youtube.com/watch?v=DNr5D7DSMr8&t=746s
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: cell.frogImage.center.x - 4, y: cell.frogImage.center.y - 4))
        animation.fromValue = NSValue(cgPoint: CGPoint(x: cell.frogImage.center.x + 4, y: cell.frogImage.center.y + 4))
        cell.frogImage.layer.add(animation, forKey: "position")
    }
    
    func shootFromScreenAnnimation(over cell: GameCellView) {
        let x = cell.frame.minX
        let y = cell.frame.minY
        let width = cell.frogImage.frame.width
        let height = cell.frogImage.frame.height
        let shockedToon = UIImageView(frame: CGRect(x: x, y: y, width: width, height: height))
        shockedToon.image = UIImage(named: "toon_shocked_frog")
        self.gameBoardCollectionView.addSubview(shockedToon)
        cell.frogImage.image = nil
        
        let directions = [1.0, -1.0]
        let index = Int(arc4random_uniform(UInt32(directions.count)))
        let direction = directions[index]
        
        UIView.animateKeyframes(
            withDuration: 1.0,
            delay: 0,
            options: [
                .calculationModeCubic
            ],
            animations: {
                shockedToon.alpha = 0.1
                let xNew = Utils.random(0.0..<Double(self.gameBoardCollectionView.frame.width)) * direction
                let yNew = Utils.random(0.0..<Double(self.gameBoardCollectionView.frame.width)) * direction
                shockedToon.transform = CGAffineTransform(
                    translationX: CGFloat(xNew),
                    y: CGFloat(yNew)
                    )
            },
            completion: { _ in
                shockedToon.removeFromSuperview()
            }
        )
    }
    
    func updateLivesLeft(_ lives: Int) {
        
        let image = UIImage(named: "x-death")
        
        if lives == 0 {
            life3.image = image
        } else if lives  == 1 {
            life2.image = image
        } else if lives == 2 {
            life1.image = image
        }
    }
    
    func updateAllCells() {
        print("reloading all cells")
        for row in 0..<game.board.size.rows {
            for column in 0..<game.board.size.columns {
                updateCelltAt(row, column)
            }
        }
         //gameBoardCollectionView.reloadData()
        self.gameOverSegue()
        //performSegue(withIdentifier: "toGameSummary", sender: self)
    }
}
