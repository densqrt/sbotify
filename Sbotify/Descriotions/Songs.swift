//
//  Songs.swift
//  Sbotify
//
//  Created by Denis on 19/8/20.
//  Copyright © 2020 Denis Skuratovich. All rights reserved.
//

import AVFoundation
import UIKit

class Songs {
    
    static let instance = Songs()
    
    enum List: Int, CaseIterable {
        case diamonds
        case godzilla
        case silovoe_pole
        
        var title: String {
            switch self {
            case .diamonds:
                return "Diamonds"
            case .godzilla:
                return "Godzilla"
            case .silovoe_pole:
                return "Silovoe_pole"
            }
        }
    }
    
   var counter = 0
    
    func songCreator(operand: Int = 0) -> String {
        
        var songChoice = String()
        let variants = List.allCases.map { $0.title }
        
        if operand != 0 {
            counter += operand
            if counter > 2 {
                counter = 0
            }
            if counter < 0 {
                counter = 2
            }
            songChoice = variants[counter]
        } else {
            songChoice = variants[Int.random(in: 0...2)]
        }
        
        return songChoice
    }
    
    func artistCreator(song: String) -> String {
        switch song {
        case "Diamonds":
            return "Rhianna"
        case "Godzilla":
            return "Eminem"
        case "Silovoe_pole":
            return "ЛСП"
        default:
            return "Wrong song"
        }
    }
}
