//
//  CardCollectionViewCell.swift
//  Latteria
//
//  Created by Christian Adiputra on 30/04/21.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var imgCoffee: UIImageView!
    @IBOutlet weak var nameCoffee: UILabel!
    @IBOutlet weak var priceCoffee: UILabel!
    var dataImgCoffee: Data?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 5
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor(red:14/255, green:68/255, blue:73/255, alpha: 1).cgColor
        setImageView()
    }

    func setImageView() {
        imgCoffee.layer.borderWidth = 2
        imgCoffee.layer.borderColor = UIColor.white.cgColor
    }
    

}
