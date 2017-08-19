//
//  GameBoardSize.swift
//  iSmack-a-frog
//
//  Created by rony_temp on 17/07/2017.
//  Copyright © 2017 rony_temp. All rights reserved.
//

import Foundation

struct GameBoard {
    
    let size: BoardSize
    
    private var _cells: [[FrogHole]] = []
    
    var cells: [[FrogHole]] {
        return _cells
    }
    
    init(size: BoardSize) {
        self.size = size
        _cells = [[FrogHole]](repeating: [FrogHole](repeating: FrogHole(), count: size.columns), count: size.rows)
    }
    
    mutating func getCellStateAt(_ row: Int, _ column: Int) -> FrogHoleState {
        return _cells[row][column].state
    }
    
    mutating func resetAllCells() {
        
        for row in 0..<_cells.count {
            for column in 0..<_cells[row].count {
                print("board is reseting cell \(row), \(column)")
                resetCellAt(row, column)
            }
        }
    }
    
    mutating func resetCellAt(_ row: Int, _ column: Int) {
        _cells[row][column].resetToNonHittable()
    }
    
    mutating func activateCellAt(_ row: Int, _ column: Int) {
        _cells[row][column].changeStateRandomly()
    }
}

struct BoardSize {
    
    let rows: Int
    
    let columns: Int
    
    var numCells: Int {
        return rows * columns
    }
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
    }
    
}
