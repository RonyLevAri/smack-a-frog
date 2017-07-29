//
//  BoardTimeController.swift
//  iSmack-a-frog
//
//  Created by rony_temp on 29/07/2017.
//  Copyright © 2017 rony_temp. All rights reserved.
//

import Foundation

protocol BoardTimerControllerDelegate: class {
    func activationTimerGotSetAt(_ row: Int, _ column: Int)
    func latencyTimerGotSetAt(_ row: Int, _ column: Int)
}

class BoardTimerController: NSObject {
    
    private var _actionTimers: [[Timer?]] = []
    
    private var _latencyTimers: [[Timer?]] = []
    
    weak var delegate: BoardTimerControllerDelegate? = nil
    
    private var gameConfig: GameConfig
    
    init(size: BoardSize, gameConfig: GameConfig) {
        self.gameConfig = gameConfig
        self._actionTimers = [[Timer?]](repeating: [Timer?](repeating: nil, count: size.columns), count: size.rows)
        self._latencyTimers = [[Timer?]](repeating: [Timer?](repeating: nil, count: size.columns), count: size.rows)
    }
    
    func start() {
        initializeLatencyTimers()
    }
    
    func stop() {
        invalidateTimers()
    }
    
    private func initializeLatencyTimers() {
        
        for row in 0..<_latencyTimers.count {
            for column in 0..<_latencyTimers[row].count {
                _latencyTimers[row][column] = generateTimerFor(latency: true, selector: #selector(BoardTimerController.activateActionTimerAt(timer:)), userInfo: ["row": row, "column": column])
            }
        }
    }
    
    func activateActionTimerAt(timer: Timer) {
        
        let dict = timer.userInfo as! [String : Any]
        let row = dict["row"] as! Int
        let column = dict["column"] as! Int
        
        reportActivationChangeAt(row, column)
        
        _actionTimers[row][column] = generateTimerFor(latency: false, selector: #selector(BoardTimerController.activateLatencyTimerAt(timer:)), userInfo: ["row": row, "column": column])
        
    }
    
    func activateLatencyTimerAt(timer: Timer) {
        
        let dict = timer.userInfo as? [String : Any]
        let row = dict?["row"] as! Int
        let column = dict?["column"] as! Int
        
        _actionTimers[row][column] = nil
        reportLatencyAt(row, column)
        
        _latencyTimers[row][column] = generateTimerFor(latency: true, selector: #selector(BoardTimerController.activateActionTimerAt(timer:)), userInfo: ["row": row, "column": column])
    }
    
    private func invalidateTimers() {
        
        for row in 0..<_latencyTimers.count {
            for column in 0..<_latencyTimers[row].count {
                if let latencyTimer = _latencyTimers[row][column] {
                    latencyTimer.invalidate()
                }
                if let activationTimer = _actionTimers[row][column] {
                    activationTimer.invalidate()
                }
                _latencyTimers[row][column] = nil
                _actionTimers[row][column] = nil
            }
        }
    }
    
    func resetTimerAt(row: Int, column: Int) {
        _actionTimers[row][column] = nil
    }
    
    func isTimerRunnindAt(row: Int, column: Int) -> Bool {
        return _actionTimers[row][column] != nil
    }
    
    private func reportActivationChangeAt(_ row: Int, _ column: Int) {
        delegate?.activationTimerGotSetAt(row, column)
    }
    
    private func reportLatencyAt(_ row: Int, _ column: Int) {
        _actionTimers[row][column] = nil
        delegate?.latencyTimerGotSetAt(row, column)
    }
    
    private func generateTimerFor(latency: Bool, selector: Selector, userInfo: [String : Int]) -> Timer {
        
        let interval = latency ? gameConfig.latencyBetweenTimers : gameConfig.timeTargetAppersOnScreen
        
        return Timer.scheduledTimer(
            timeInterval: Utils.random(interval),
            target: self,
            selector: selector,
            userInfo: userInfo,
            repeats: false)
    }
    
}
