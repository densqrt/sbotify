//
//  Labels.swift
//  Sbotify
//
//  Created by Denis on 18/8/20.
//  Copyright © 2020 Denis Skuratovich. All rights reserved.
//

import UIKit
import AVFoundation

class Labels: UIViewController {
    
    static let instance = Labels()
    
    func timeEndCreator() -> UILabel {
        
        let timeEndLabel = UILabel()
        
        timeEndLabel.frame = CGRect(x: 320, y: 280, width: 32, height: 20)
        timeEndLabel.textColor = .black
        timeEndLabel.font = UIFont(name: "Thonburi", size: 9)
        timeEndLabel.textAlignment = .center
        
        return timeEndLabel
    }
    
    func timeStartCreator() -> UILabel {
        
        let timeStartLabel = UILabel()
        
        timeStartLabel.frame = CGRect(x: 15, y: 280, width: 32, height: 20)
        timeStartLabel.textColor = .black
        timeStartLabel.font = UIFont(name: "Thonburi", size: 9)
        timeStartLabel.textAlignment = .center
        
        
        return timeStartLabel
    }
    
}
