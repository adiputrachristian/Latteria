//
//  SoundPlayer.swift
//  Latteria
//
//  Created by Christian Adiputra on 28/04/21.
//

import Foundation
import AVFoundation

class SoundPlayer{
    static let shared = SoundPlayer()
    var brewPlayer: AVAudioPlayer?
    var grinderPlayer: AVAudioPlayer?
    var peoplePlayer: AVAudioPlayer?
    var songPlayer: AVAudioPlayer?
    
    var soundStatus = false
    var soundVolume = Double()
    func startSound(soundName: String) {
        if soundStatus {
            switch soundName {
            case "Brew":
                if soundStatus {
                    if let bundle = Bundle.main.path(forResource: soundName, ofType: "wav") {
                        let soundMusic = NSURL(fileURLWithPath: bundle)
                        do {
                            brewPlayer = try AVAudioPlayer(contentsOf: soundMusic as URL)
                            guard let brewPlayer = brewPlayer else {return}
                            brewPlayer.numberOfLoops = -1
                            brewPlayer.prepareToPlay()
                            brewPlayer.play()
                            print(soundName)
                        } catch  {
                            print(error)
                        }
                    }
                }
            case "Grinder":
                if soundStatus {
                    if let bundle = Bundle.main.path(forResource: soundName, ofType: "wav") {
                        let soundMusic = NSURL(fileURLWithPath: bundle)
                        do {
                            grinderPlayer = try AVAudioPlayer(contentsOf: soundMusic as URL)
                            guard let grinderPlayer = grinderPlayer else {return}
                            grinderPlayer.numberOfLoops = -1
                            grinderPlayer.prepareToPlay()
                            grinderPlayer.play()
                            print(soundName)
                        } catch  {
                            print(error)
                        }
                    }
                }
                
            case "People":
                if soundStatus {
                    if let bundle = Bundle.main.path(forResource: soundName, ofType: "wav") {
                        let soundMusic = NSURL(fileURLWithPath: bundle)
                        do {
                            peoplePlayer = try AVAudioPlayer(contentsOf: soundMusic as URL)
                            guard let peoplePlayer = peoplePlayer else {return}
                            peoplePlayer.numberOfLoops = -1
                            peoplePlayer.prepareToPlay()
                            peoplePlayer.play()
                            print(soundName)
                        } catch  {
                            print(error)
                        }
                    }
                }
            case "Song":
                if soundStatus {
                    if let bundle = Bundle.main.path(forResource: soundName, ofType: "wav") {
                        let soundMusic = NSURL(fileURLWithPath: bundle)
                        do {
                            songPlayer = try AVAudioPlayer(contentsOf: soundMusic as URL)
                            guard let songPlayer = songPlayer else {return}
                            songPlayer.numberOfLoops = -1
                            songPlayer.prepareToPlay()
                            songPlayer.play()
                            print(soundName)
                        } catch  {
                            print(error)
                        }
                    }
                }
            default:
                print(soundName)
            }
        }
        
    }
    
    func stopSound(soundName: String) {
        switch soundName {
        case "Brew":
            guard let brewPlayer = brewPlayer else { return }
           // brewPlayer.stop()
            brewPlayer.pause()
        case "Grinder":
            guard let grinderPlayer = grinderPlayer else { return }
            
            grinderPlayer.pause()
        case "People":
            guard let peoplePlayer = peoplePlayer else { return }
            peoplePlayer.pause()
        case "Song":
            guard let songPlayer = songPlayer else { return }
            songPlayer.pause()
        default:
            print(soundName)
        }
    }
    
    func volumeSound(soundName: String) {
        switch soundName {
        case "Brew":
            brewPlayer?.volume = Float(soundVolume)
        case "Grinder":
            grinderPlayer?.volume = Float(soundVolume)
        case "People":
            peoplePlayer?.volume = Float(soundVolume)
        case "Song":
            songPlayer?.volume = Float(soundVolume)
        default:
            print(soundName)
        }
    }
    
}
