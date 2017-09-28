//
//  DataManager.swift
//  iSmack-a-frog
//
//  Created by rony_temp on 17/09/2017.
//  Copyright © 2017 rony_temp. All rights reserved.
//

import Foundation

class DataManager {
    
    let maxWinners = 10
    let file = "test"
    lazy var winners: [PersistablePlayer] = {
        self.loadWinners()
    }()
    // TODO: make filePath optional to allow gracefull fallback in case of error
    lazy var filePath: String = {
        do {
            let documentDirURL = try FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileURL = documentDirURL.appendingPathComponent(self.file).appendingPathExtension("txt")
            return fileURL.path
        } catch {
            print("error did not find file!")
            return ""
        }
    }()
    
    private func makePersistant(the player: Player) -> PersistablePlayer {
        let persistablePlayer = PersistablePlayer(
            name: player.name,
            score: String(player.score),
            latitude: String(player.latitude),
            longitude: String(player.longitude)
        )
        return persistablePlayer
    }
    
    func loadWinners() -> [PersistablePlayer] {
        var winners: [PersistablePlayer] = []
        if let data = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [PersistablePlayer] {
            winners = data
        }
        return winners
    }
    
    private func parsePlayer(rawString: Player) -> Player {
        let p = Player(score: 1, name: "rony", latitude: 0.0, longitude: 0.0)
        return p
    }
    
    func isAmongWinners(with score: Int) -> Bool {
        return winners.count < 10 ? true : Int(winners[winners.count - 1].score)! < Int(score)
    }
    
    func save(winner: Player) {
        if winners.count == 10 {
            deleteLastWinner()
        }
        winners.append(makePersistant(the: winner))
        winners.sort(by: { (p1, p2) -> Bool in
            return Int(p1.score)! > Int(p2.score)!
        })
        writeToFile()
    }
    
    private func deleteLastWinner() {
        winners.remove(at: winners.count - 1)
    }
    
    private func writeToFile() {
        NSKeyedArchiver.archiveRootObject(winners, toFile: filePath)
    }
}
