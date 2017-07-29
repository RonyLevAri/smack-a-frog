//
//  Utils.swift
//  iSmack-a-frog
//
//  Created by rony_temp on 29/07/2017.
//  Copyright © 2017 rony_temp. All rights reserved.
//

import Foundation

struct Utils {
    
    // taken form: https://learnappmaking.com/random-numbers-swift/
    static func random(_ range:Range<Double>) -> Double {
        return range.lowerBound + Double(arc4random_uniform(UInt32(range.upperBound - range.lowerBound))) + Double(arc4random()) / Double(UInt32.max)
    }
}
