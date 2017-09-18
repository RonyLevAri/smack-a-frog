//
//  Player.swift
//  iSmack-a-frog
//
//  Created by rony_temp on 17/09/2017.
//  Copyright © 2017 rony_temp. All rights reserved.
//

import Foundation

struct Player {
    
    let score: Int
    let name: String
    let latitude: Double
    let longitude: Double
    
    init(score: Int, name: String, latitude: Double, longitude: Double) {
        self.score = score
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    var description: String {
        return "\(score), \(name), \(latitude), \(longitude)"
    }
}
