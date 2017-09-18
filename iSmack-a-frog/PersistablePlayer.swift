//
//  PersistablePlayer.swift
//  iSmack-a-frog
//
//  Created by rony_temp on 18/09/2017.
//  Copyright © 2017 rony_temp. All rights reserved.
//

import Foundation

class PersistablePlayer: NSObject, NSCoding {
    
    var name: String
    var score: String
    var latitude: String
    var longitude: String
    
    init(name: String, score: String, latitude: String, longitude: String){
        self.name = name
        self.score = score
        self.latitude = latitude
        self.longitude = longitude
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard
            let name = aDecoder.decodeObject(forKey: PersistablePlayerPropertiesKeys.Name.rawValue) as? String,
            let score = aDecoder.decodeObject(forKey: PersistablePlayerPropertiesKeys.Score.rawValue) as? String,
            let latitude = aDecoder.decodeObject(forKey: PersistablePlayerPropertiesKeys.Latitude.rawValue) as? String,
            let longitude = aDecoder.decodeObject(forKey: PersistablePlayerPropertiesKeys.Longitude.rawValue) as? String
            else { return nil }
        
        self.name = name
        self.score = score
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PersistablePlayerPropertiesKeys.Name.rawValue)
        aCoder.encode(score, forKey: PersistablePlayerPropertiesKeys.Score.rawValue)
        aCoder.encode(latitude, forKey: PersistablePlayerPropertiesKeys.Latitude.rawValue)
        aCoder.encode(longitude, forKey: PersistablePlayerPropertiesKeys.Longitude.rawValue)
    }
}

enum PersistablePlayerPropertiesKeys: String {
    case Name = "name"
    case Score = "score"
    case Latitude = "lng"
    case Longitude = "lat"
}
