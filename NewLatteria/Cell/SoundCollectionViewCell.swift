//
//  SoundCollectionViewCell.swift
//  Latteria
//
//  Created by Christian Adiputra on 28/04/21.
//

import UIKit
import AVFoundation
import AVKit
class SoundCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var soundType: UILabel!
    @IBOutlet weak var soundSwitcher: UISwitch!
    @IBOutlet weak var volumeSlider: UISlider!
    var sound: String!
    //var soundValue: Float!
    @IBAction func soundSwitch(_ sender: UISwitch) {
        if soundSwitcher.isOn{
            SoundPlayer.shared.soundStatus = true
            SoundPlayer.shared.startSound(soundName: sound)
        } else {
            SoundPlayer.shared.soundStatus = false
            SoundPlayer.shared.stopSound(soundName: sound)
        }
    }
    
    @IBAction func volumeSlide(_ sender: UISlider){
        let value = sender.value
        SoundPlayer.shared.soundVolume = Double(value)
        SoundPlayer.shared.volumeSound(soundName: sound)
//        volumeSlider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 5
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor(red:14/255, green:68/255, blue:73/255, alpha: 1).cgColor
    }
    
    
    

}
