//
//  Player.swift
//  Sbotify
//
//  Created by Denis on 18/8/20.
//  Copyright © 2020 Denis Skuratovich. All rights reserved.
//

import AVFoundation
import UIKit

class Player: UIViewController {
    
    static let instance = Player()
    
    var player: AVAudioPlayer!
    
    func playerCreator(name: String) -> AVAudioPlayer {
        do {
            if let audioPath = Bundle.main.path(forResource: name, ofType: "mp3") {
                try self.player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
            }
        } catch {
            print("Error in player creating")
        }
        self.player.play()
        return player
    }
}
