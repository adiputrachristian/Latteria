//
//  SoundData.swift
//  Latteria
//
//  Created by Christian Adiputra on 28/04/21.
//

import Foundation
class SoundData {
    var id: Int?
    var soundData = ""
    var soundname = ""
    
    init(soundID: Int, dataSound: String, nameSound: String) {
        id = soundID
        soundData = dataSound
        soundname = nameSound
        
    }
}
