//
//  ViewController.swift
//  Sbotify
//
//  Created by Denis on 18/8/20.
//  Copyright © 2020 Denis Skuratovich. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    var player: AVAudioPlayer!
    var timer = Timer()
    var imageView = UIImageView(frame: CGRect(x: 87, y: 56, width: 200, height: 200))
    lazy var song = Songs.instance.songCreator()
    lazy var artist = Songs.instance.artistCreator(song: song)
    
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var songLabel: UILabel!
    
    var timeStartLabel = UILabel()
    var timeEndLabel = UILabel()
    
    @IBOutlet weak var volumeSlider: UISlider!
    var rewindSlider = UISlider()
       
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        self.view.addSubview(imageView)
        
        addLabels()
        setSongInfo(song: song)
        customizeSlider()
        
        
        
        
        //set timer to make view actual
        timer = Timer.scheduledTimer(timeInterval: 0.1 , target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
}
    
//MARK: - Methods

extension AVAudioPlayer {
    
    func curentTimeCounter() -> (minutes: Int, seconds: Int) {
    
        let currentTime = Int(self.currentTime)
        let minutes = currentTime/60
        let seconds = currentTime - minutes * 60
        
        return (minutes, seconds)
        
    }
    
    func durationTimeCounter() -> (minutes: Int, seconds: Int) {
        let currentTime = Int(self.duration)
        let minutes = currentTime/60
        let seconds = currentTime - minutes * 60
        
        return (minutes, seconds)
        
    }
}


extension ViewController {
    
    @objc func changeSlider(sender: UISlider) {
        if sender.isEqual(rewindSlider) {
            player.currentTime = TimeInterval(sender.value)
        }
    }
    
    func setSongInfo(song: String) {
        
        player = Player.instance.playerCreator(name: song)
        imageView.image = UIImage(named: song)
        songLabel.text = (song == "Silovoe_pole" ? "Силовое поле" : song)
        artistLabel.text = Songs.instance.artistCreator(song: song)
        
        timeStartLabel.text = NSString(format: "%02d:%02d", player.curentTimeCounter().minutes, player.curentTimeCounter().seconds) as String
        
        timeEndLabel.text = NSString(format: "%02d:%02d", player.durationTimeCounter().minutes, player.durationTimeCounter().seconds) as String
        
        
    }
    
    @objc func updateTimer() {
        
        rewindSlider.value = Float(player.currentTime)
        timeStartLabel.text = NSString(format: "%02d:%02d", player.curentTimeCounter().minutes, player.curentTimeCounter().seconds) as String
        
        if timeStartLabel.text == timeEndLabel.text {
            rewindSlider.value = 0.0
        }
 
        volumeSlider.minimumValueImage = UIImage(named: volumeSlider.value == 0 ? "Disabled" : "Low")
        volumeSlider.maximumValueImage = UIImage(named: volumeSlider.value < 0.5 ? "Medium" : "Loud")
    }
}

//MARK: - Adding Elements
extension ViewController {
    
    func customizeSlider() {
        rewindSlider.frame = CGRect(x: 56, y: 276, width: 262, height: 30)
        rewindSlider.minimumTrackTintColor = .black
        rewindSlider.minimumValue = 0.0
        rewindSlider.maximumValue = Float(player.duration)
        rewindSlider.setThumbImage(UIImage(named: "Vertical"), for: .normal)
        rewindSlider.addTarget(self, action: #selector(changeSlider), for: .valueChanged)
        self.view.addSubview(rewindSlider)
    }
    
    func addLabels() {
        timeStartLabel = Labels.instance.timeStartCreator()
        self.view.addSubview(timeStartLabel)
        
        timeEndLabel = Labels.instance.timeEndCreator()
        self.view.addSubview(timeEndLabel)
    }
}
    
// MARK: - Actions
extension ViewController {
    
    @IBAction func volumeSlider(_ sender: Any) {
        player.volume = volumeSlider.value
    }
    
    @IBAction func playButton(_ sender: Any) {
        if player.isPlaying {
            self.player.pause()
        } else {
            self.player.play()
        }
    }
    
    @IBAction func nextButton(_ sender: Any) {
        song = Songs.instance.songCreator(operand: +1)
        setSongInfo(song: song)
    }
    @IBAction func previousButton(_ sender: Any) {
        song = Songs.instance.songCreator(operand: -1)
        setSongInfo(song: song)
    }
}


