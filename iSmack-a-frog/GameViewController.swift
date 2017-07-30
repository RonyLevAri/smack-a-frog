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
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 10.0)
    
    fileprivate var cellsPerRow: CGFloat!
    
    fileprivate var cellsPerColumn: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameBoardCollectionView.dataSource = self
        gameBoardCollectionView.delegate = self
        
        scores.text = String(0)
        
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
        cell.frogImage.image = frogHolaStateToImage(state: cellState)
        
    }
    
    private func frogHolaStateToImage(state: FrogHoleState) -> UIImage? {
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
        print("cell \(indexPath.section), \(indexPath.item) was tapped")
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
        scores.text = String(points)
    }
    
    func updateCelltAt(_ row: Int, _ column: Int) {
        gameBoardCollectionView.reloadItems(at: [IndexPath(item: column, section: row)])
    }
    
    func updateLivesLeft(_ lives: Int) {
        
        let image = UIImage(named: "x-death")
        
        if lives == 0 {
            life1.image = image
            life2.image = image
            life3.image = image
        } else if lives  == 1 {
            life1.image = image
            life2.image = image
        } else if lives == 2 {
            life1.image = image
        }
    }
}
