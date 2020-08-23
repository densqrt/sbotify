//
//  Slider.swift
//  Sbotify
//
//  Created by Denis on 18/8/20.
//  Copyright © 2020 Denis Skuratovich. All rights reserved.
//

import UIKit
import AVFoundation

class Slider: UIViewController {
    
    static let instance = Slider()

    let slider = UISlider()
   
    func rewindCreator(player: AVAudioPlayer) -> UISlider {
        

        slider.frame = CGRect(x: 56, y: 276, width: 262, height: 30)
        slider.minimumTrackTintColor = UIColor.black
        slider.minimumValue = 0.0
        slider.maximumValue = Float(player.duration)
        slider.setThumbImage(UIImage(named: "Vertical"), for: .normal)
        return slider
    }
    
    
    
}
