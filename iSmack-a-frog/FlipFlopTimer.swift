//
//  FlipFlopTimer.swift
//  iSmack-a-frog
//
//  Created by rony_temp on 15/08/2017.
//  Copyright © 2017 rony_temp. All rights reserved.
//

import Foundation

protocol FliFlopTimerDelegate: class {
    func timerRunningAt(_ row: Int, _ column: Int)
    func timerIdleAt(_ row: Int, _ column: Int) 
    
}

class FlipFlopTimer: NSObject {

    private var _state =  BinaryState.Idle
    weak var offTimer: Timer? {
        willSet {
            offTimer?.invalidate()
        }
    }
    weak var onTimer: Timer? {
        willSet {
            onTimer?.invalidate()
        }
    }
    private var randomInterval = 0.0
    private let idleIntervalRange: Range<Double>
    private let runningIntervalRange: Range<Double>
    weak var timerDelegate: FliFlopTimerDelegate?
    var row: Int
    var column: Int
    
    init(row: Int , column: Int, withIdleIntervalRange: Range<Double>, withRunningIntervalRange: Range<Double>) {
        self.row = row
        self.column = column
        self.idleIntervalRange = withIdleIntervalRange
        self.runningIntervalRange = withRunningIntervalRange
    }
    
    func start() {
        idle()
    }
    
    func stop() {
        offTimer?.invalidate()
        onTimer?.invalidate()
        //_state = .Stopped
    }
    
    func reset() {
        stop()
        start()
    }
    
    func running() {
        //guard _state != .Stopped else { return }

        // print("turining on timer \(row), \(column)")
        _state = BinaryState.Running
        timerDelegate?.timerRunningAt(row, column)
        randomInterval = Utils.random(runningIntervalRange)
        // print("timer \(row), \(column) will now run for \(randomInterval)")
        onTimer = Timer.scheduledTimer(timeInterval: randomInterval, target: self, selector: #selector(FlipFlopTimer.idle), userInfo: nil, repeats: false)
        
    }
    
    func idle() {
        //guard _state != .Stopped else { return }

        // print("turining off \(row), \(column)")
        _state = BinaryState.Idle
        timerDelegate?.timerIdleAt(row, column)
        randomInterval = Utils.random(idleIntervalRange)
        // print("timer \(row), \(column) will now be idle for \(randomInterval)")
        offTimer = Timer.scheduledTimer(timeInterval: randomInterval, target: self, selector: #selector(FlipFlopTimer.running), userInfo: nil, repeats: false)
    }
    
    enum BinaryState:String {
        case Idle
        case Running
        //case Stopped
    }
}
