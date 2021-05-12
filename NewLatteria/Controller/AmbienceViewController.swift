//
//  AmbienceControllerViewController.swift
//  Latteria
//
//  Created by Christian Adiputra on 28/04/21.
//

import UIKit
import Lottie

class AmbienceViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    let soundCollectionViewCellId = "SoundCollectionViewCell"
    var sounds = [SoundData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        let nibCell = UINib(nibName: soundCollectionViewCellId, bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: soundCollectionViewCellId)
        
        print(sounds.count)
        initData()
        //setupAnimation()
    }
  
    override func viewWillAppear(_ animated: Bool) {
        animationView.animation = Animation.named("coffeecup")
            animationView.frame = CGRect(x: 0, y: 40, width: 400, height: 250)
            animationView.contentMode = .scaleAspectFit
            animationView.backgroundColor = .none
            animationView.loopMode = .loop
            animationView.play()
            view.addSubview(animationView)
    }
    var animationView = AnimationView()
    

}

extension AmbienceViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: soundCollectionViewCellId, for: indexPath) as! SoundCollectionViewCell
        let sound = sounds[indexPath.row]
        cell.soundType.text = sound.soundname
        cell.sound = sound.soundData
        
        return cell
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sounds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset: CGFloat = 10
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 330, height: 110)
    }
    
    
    func initData(){
        let brewing = SoundData(soundID: 1,dataSound: "Brew", nameSound: "Brewing")
        let grinder = SoundData(soundID: 2, dataSound: "Grinder", nameSound: "Grinder")
        let people = SoundData(soundID: 3, dataSound: "People", nameSound: "People")
        let song = SoundData(soundID: 4, dataSound: "Song", nameSound: "Song")
        sounds.append(brewing)
        sounds.append(grinder)
        sounds.append(people)
        sounds.append(song)
        collectionView.reloadData()
    }

}


