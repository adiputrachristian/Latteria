//
//  DetailViewController.swift
//  Latteria
//
//  Created by Christian Adiputra on 03/05/21.
//

import UIKit

protocol DetailViewControllerDelegate: class {
    func updateData()
}

class DetailViewController: UIViewController {
    
   // static let shared = DetailViewController()
    
//    @IBOutlet var parentViewController: UIView!
    @IBOutlet weak var detailImage: UIImageView!
    
    @IBOutlet weak var detailHolder: UIView!
    
    @IBOutlet weak var coffeeName: UILabel!
    
    @IBOutlet weak var coffeeType: UILabel!
    
    @IBOutlet weak var orderDetail: UILabel!
    
    @IBOutlet weak var priceDetail: UILabel!
    
    @IBOutlet weak var deleteBtn: UIButton!
    
    weak var delegate: DetailViewControllerDelegate?
    
    var coffeedata =  [CoffeeData]()
    var datacoffee: CoffeeData?
    var ListCoffee = ListCoffeeViewController()
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showDetail()
    }

//    override func viewDidLayoutSubviews() {
//        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = view.bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        view.addSubview(blurEffectView)
//    }
    
    func showDetail(){
        print("detail")
        guard let dataCoffee = datacoffee else { return }
        detailHolder.layer.cornerRadius = 10
        detailImage.layer.cornerRadius = 10
        coffeeName.text = dataCoffee.name
        coffeeType.text = dataCoffee.typecoffee
        detailImage.image = UIImage(data: dataCoffee.imgcoffee!)
        orderDetail.text = convertDate(date: dataCoffee.date ?? Date())
        priceDetail.text = dataCoffee.price
    }
    
    func convertDate(date: Date) -> String{
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"

        let convertedDate = dateFormatter.string(from: date)

        return convertedDate
    }
    
    @IBAction func deleteTapped(_ sender: UIButton) {
        CoreDataHandler.shared.delete(coffeeDataToDelete: self.datacoffee!)
        print("index \(self.index)")
        self.dismiss(animated: true) {
            self.delegate?.updateData()
        }
        
        
    }
    


    
}
