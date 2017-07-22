//
//  GameBoardSize.swift
//  iSmack-a-frog
//
//  Created by rony_temp on 17/07/2017.
//  Copyright © 2017 rony_temp. All rights reserved.
//

import Foundation

struct GameBoard {
    
    let size: GameBoardSize
    
    private var _cells: [[FrogHole]] = []
    
    var cells: [[FrogHole]] {
        return _cells
    }
    
    init(size: GameBoardSize) {
        self.size = size
        _cells = [[FrogHole]](repeating: [FrogHole](repeating: FrogHole(), count: size.columns), count: size.rows)
    }
}

struct GameBoardSize {
    
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
