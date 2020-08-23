//
//  ViewController.swift
//  player
//
//  
//

import UIKit
import AVFoundation
import MediaPlayer

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    var player = AVAudioPlayer()
    
    //Переменная для переключения треков (тест)
    var x = 2
    //slider
    var volumeSlider = UISlider()
    let rewindSlider = UISlider()
    var timer = Timer()
    var timer2 = Timer()
    
    //Button
    let playPauseButton = UIButton()
    
    let nextTrackButton = UIButton()
    let backTrackButton = UIButton()
    
    //Labels
    
    let timeStartLabel = UILabel()
    let timeEndLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Methods
        playFile()
        
        volume(sender: volumeSlider)
        rewind(sender: rewindSlider)
        
        buttonForControl(sender: playPauseButton)
        
        preventSystemVolumePopup()
        
        controlCentr ()
        
        labels()
        
        backgroundMusic()
        
        // Timer
        
        timer = Timer.scheduledTimer(timeInterval: 0.1 , target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    //MARK: Lets play music and search file
    
    //Воспроизведение трека
    func playFile() {
        do {
            if let track = Bundle.main.path(forResource: String(x) + "track", ofType: "mp3") {
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: track))
                player.delegate = self
                
            }
        } catch  {
            print("Не удалось найти файл")
        }
        player.play()
    }
    
    
    //MARK: Sliders for volume and rewind
    
    //Создаем слайдер для звука
    
    func volume(sender:UISlider) {
        if sender == volumeSlider {
            volumeSlider.frame = CGRect(x: 18, y: 502, width: 285, height: 20)
            //при загрузке приложения звук будет равен звука слайдера контрол центра
            volumeSlider.value = AVAudioSession.sharedInstance().outputVolume
            volumeSlider.maximumValue = 1
            volumeSlider.minimumValue = 0
            
            //устанавливаем изображение переключателя у слайдера
            let imageVolume = UIImage(named: "volume trumbl.png")
            volumeSlider.setThumbImage(imageVolume, for: .normal)
            let imageVolumeToch = UIImage(named: "volume truml ++.png")
            volumeSlider.setThumbImage(imageVolumeToch, for: .highlighted)
            
            volumeSlider.addTarget(self, action: #selector(changeVolume(sender:)), for: .valueChanged)
            
            view.addSubview(volumeSlider)
        }
    }
    
    func changeVolume(sender:UISlider) {
        //изменяем уровень звука у слайдера в control centr
        (MPVolumeView().subviews.filter{NSStringFromClass($0.classForCoder) == "MPVolumeSlider"}.first as? UISlider)?.setValue(volumeSlider.value, animated: false)
    }
    
    
    //Создаем слайдер для перемотки
    func rewind(sender: UISlider) {
        if sender == rewindSlider {
            rewindSlider.frame = CGRect(x: 35, y: 296, width: 250, height: 20)
            
            let imageThumb = UIImage(named: "Line 3 litle.png")
            rewindSlider.setThumbImage(imageThumb, for: .normal)
            
            rewindSlider.minimumValue = 0.0
            rewindSlider.maximumValue = Float(player.duration)
            
            rewindSlider.addTarget(self, action: #selector(changeRewind(sender:)), for: .valueChanged)
            view.addSubview(rewindSlider)
        }
    }
    
    func changeRewind(sender: UISlider) {
        if sender == rewindSlider {
            player.currentTime = TimeInterval(rewindSlider.value)
        }
    }
    
    //MARK: Button music controll
    
    //Создаем кнопки
    
    func buttonForControl (sender: UIButton){
        playPauseButton.frame = CGRect(x: 135, y: 419, width: 50, height: 50)
        playPauseButton.setImage(UIImage(named:"Pause Button.png"), for: .normal)
        playPauseButton.addTarget(self, action: #selector(play(sender:)), for: .touchDown)
        
        nextTrackButton.frame = CGRect(x: 215, y: 419, width: 50, height: 50)
        nextTrackButton.setImage(UIImage(named:"NextButton.png"), for: .normal)
        nextTrackButton.addTarget(self, action: #selector(next(sender:)), for: .touchDown)
        
        backTrackButton.frame = CGRect(x: 55, y: 419, width: 50, height: 50)
        backTrackButton.setImage(UIImage(named:"BackButton.png"), for: .normal)
        backTrackButton.addTarget(self, action: #selector(back(sender:)), for: .touchDown)
        
        view.addSubview(playPauseButton)
        view.addSubview(nextTrackButton)
        view.addSubview(backTrackButton)
    }
    
    // Методы для кнопок
    func play (sender: UIButton){
        if !player.isPlaying {
            playPauseButton.setImage(UIImage(named:"Pause Button.png"), for: .normal)
            player.play()
        } else {
            playPauseButton.setImage(UIImage(named:"Play Button.png"), for: .normal)
            player.stop()
        }
        
        
    }
    
    func next (sender: UIButton) {
        if sender == nextTrackButton {
            x += 1
            playFile()
        }
    }
    
    func back (sender: UIButton) {
        if sender == backTrackButton {
            x -= 1
            playFile()
        }
    }
    
    //MARK: Labels
    
    func labels() {
        //Начальное время (изменяемое)
        timeStartLabel.frame = CGRect(x: 0, y: 296, width: 32, height: 20)
        timeStartLabel.textColor = #colorLiteral(red: 0.1254901961, green: 0.7294117647, blue: 0.8470588235, alpha: 1)
        timeStartLabel.font = UIFont(name: "Thonburi", size: 9)
        timeStartLabel.textAlignment = .center
        view.addSubview(timeStartLabel)
        
        //Время всего трека
        
        timeEndLabel.frame = CGRect(x: 288, y: 296, width: 32, height: 20)
        
        ////Приводим в нормальный формат время окончания трека
        let currentTime = Int(player.duration)
        let minutes = currentTime/60
        let seconds = currentTime - minutes * 60
        timeEndLabel.text = NSString(format: "%02d:%02d", minutes,seconds) as String
        
        timeEndLabel.textColor = #colorLiteral(red: 0.1254901961, green: 0.7294117647, blue: 0.8470588235, alpha: 1)
        timeEndLabel.font = UIFont(name: "Thonburi", size: 9)
        timeEndLabel.textAlignment = .center
        view.addSubview(timeEndLabel)
        
    }
    
    //MARK: Contrrol center
    
    
    //Button control center(test)
    func controlCentr () {
        UIApplication.shared.beginReceivingRemoteControlEvents()
        let commandCenter = MPRemoteCommandCenter.shared()
        
        commandCenter.playCommand.isEnabled = true
        commandCenter.playCommand.addTarget(self, action: #selector(playControlCenter))
        
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.pauseCommand.addTarget(self, action: #selector(pauseControlCenter))
    }
    
    //Methods for control center(test)
    func playControlCenter() {
        player.play()
    }
    func pauseControlCenter() {
        player.pause()
    }
    
    //MARK: Others
    
    //убираем HUD
    
    func preventSystemVolumePopup() {
        // Prevent Audio-Change Popus
        let volumeView = MPVolumeView(frame: CGRect(x: -2000.0, y: -2000.0, width: 0.0, height: 0.0))
        let windows: [Any] = UIApplication.shared.windows
        volumeView.alpha = 0.1
        volumeView.isUserInteractionEnabled = false
        if windows.count > 0 {
            (windows[0] as AnyObject).addSubview(volumeView)
        }
    }
    
    //Методы для таймера вызываються каждую секунду
    func updateTimer() {
        
        ////Перемотка
        rewindSlider.value = Float(player.currentTime)
        
        ////Каждую секунду у нас чекаеться положение слайдера звука контрол центра и наш слайдер принимает его значение
        volumeSlider.value = AVAudioSession.sharedInstance().outputVolume
        
        
        if volumeSlider.value == 0 {
            volumeSlider.minimumValueImage = UIImage(named: "Volume off.png")
        } else {
            volumeSlider.minimumValueImage = UIImage(named: "Volume min.png")
        }
        if volumeSlider.value < 0.5 {
            volumeSlider.maximumValueImage = UIImage(named: "Volume 12.png")
        } else {
            volumeSlider.maximumValueImage = UIImage(named: "Volume max.png")
        }
        
        
        ////Приводим в нормальный формат время трека
        let currentTime = Int(player.currentTime)
        let minutes = currentTime/60
        let seconds = currentTime - minutes * 60
        timeStartLabel.text = NSString(format: "%02d:%02d", minutes,seconds) as String
    }
    
    //Когда трек закончился
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        rewindSlider.value = 0.0
        playPauseButton.setImage(UIImage(named:"Play Button.png"), for: .normal)
        player.stop()
    }
    
    //Музыка в backgroud
    
    func backgroundMusic() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayback)
        } catch {}
    }
}
