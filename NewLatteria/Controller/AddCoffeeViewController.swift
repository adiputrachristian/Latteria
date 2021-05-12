//
//  AddCoffeeViewController.swift
//  Latteria
//
//  Created by Christian Adiputra on 30/04/21.
//

import UIKit
import CoreData
import Photos
import CoreML
import Vision

protocol AddCoffeeViewControllerDelegate {
    func backToMain()
}

class AddCoffeeViewController: UIViewController{
    
//    @IBOutlet var modalView: UIView!
    //Background Card
    @IBOutlet weak var cardBG: UIView!
    
    //text field price
    @IBOutlet weak var priceTextField: UITextField!
    var tempPrice: String?
    
    //text field Coffee
    @IBOutlet weak var coffeenameTextField: UITextField!
    var tempName: String?
    
    // UI Image for coffee photo
    @IBOutlet weak var coffeeImageHolder: UIImageView!
    
    // add button
    @IBOutlet weak var addButton: UIButton!
    
    //Input Holder
    @IBOutlet weak var inputHolder: UIView!
    
    //Date Picker
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var typeCoffeeLabel: UILabel!
    
    var tempDate = Date()
    
    //Buat coffee ID
    var tempId = 0
    
    var ListCoffee: ListCoffeeViewController?
    var imagePickerController = UIImagePickerController()
    var delegate:AddCoffeeViewControllerDelegate?
    var dataCoffee = [CoffeeData]()
    
//    private let classifier = VisionClassifier(mlModel: LatteriaDataModel3().model)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //var data = CoreDataHandler.shared.retrive()
        //print(data.count)
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        imagePickerController.delegate = self
        view.backgroundColor = .white
        view.addGestureRecognizer(tap)
        //print("test")
        checkPermission()
//        setCardView()
//        setImageHolder()
        //print("Sebelum diadd \(CoffeeData.count)")
        
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @IBAction func didAddButtonTap(_ sender: UIButton) {
        
        tempName = coffeenameTextField.text
        //tempPrice = priceTextField.text
        let imgCoffee = self.coffeeImageHolder.image?.jpegData(compressionQuality: 0.75)
        CoreDataHandler.shared.create(name: tempName!, price: priceTextField.text ?? "No Price", imgdata: imgCoffee ?? Data(), typecoffee: typeCoffeeLabel.text ?? "", putdate: tempDate)
        
            
        dismiss(animated: true) {
            self.ListCoffee?.models = CoreDataHandler.shared.retrive()
            self.ListCoffee?.collectionView.reloadData()
        }
        //self.ListCoffee?.collectionView.reloadData()
        
    }
    
    @IBAction func didImageHolderTap(_ sender: UIButton) {
        
        presentActionSheet()
    }
    
    
  
    
    private func analyzeImage(image: UIImage?){
        guard let buffer = image?.resize(size: CGSize(width: 260, height: 260))?.getCVPixelBuffer() else { return }
        
        do{
            let config = MLModelConfiguration()
            let model = try LatteriaDataModel(configuration: config)
            let input = LatteriaDataModelInput(image: buffer)
            
            let output = try model.prediction(input: input)
            let text = output.classLabel
            typeCoffeeLabel.text = text
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension AddCoffeeViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if picker.sourceType == .photoLibrary{
            coffeeImageHolder?.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        } else{
            coffeeImageHolder?.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        }
        
        
        picker.dismiss(animated: true) {
            self.analyzeImage(image: self.coffeeImageHolder.image)
        }
    }
    
    func checkPermission() {
        if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized {
            PHPhotoLibrary.requestAuthorization({ (status: PHAuthorizationStatus) -> Void in ()
            })
        }
        
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
        } else {
            PHPhotoLibrary.requestAuthorization(requestAuthorizationHandler)
        }
    }
    
    func requestAuthorizationHandler(status: PHAuthorizationStatus) {
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
            print("Access granted")
        } else {
            print("Dont hv access")
        }
    }
    
    func presentActionSheet(){
        let actionSheet = UIAlertController(title: "Order Your Coffe From", message: nil, preferredStyle: .actionSheet)
        
        let cameraRoll = UIAlertAction(title: "Camera", style: .default){ (_) in
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.allowsEditing = true
            picker.delegate = self
            self.present(picker, animated: true)
        }
        
        let gallery = UIAlertAction(title: "Gallery", style: .default){ (_) in
            self.imagePickerController.sourceType = .photoLibrary
            
            self.present(self.imagePickerController, animated: true, completion: nil)
        }
        
        let destructive = UIAlertAction(title: "Cancel", style: .destructive)
        actionSheet.addAction(cameraRoll)
        actionSheet.addAction(gallery)
        actionSheet.addAction(destructive)
        present(actionSheet, animated: true, completion: nil)
        
    }
    
        
}

