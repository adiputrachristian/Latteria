//
//  ListCoffeeViewController.swift
//  Latteria
//
//  Created by Christian Adiputra on 30/04/21.
//

import UIKit
import CoreData
import Foundation

class ListCoffeeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let CardCollectionViewCellId = "CardCollectionViewCell"
    var models = [CoffeeData]()
    
    @IBOutlet weak var detailView: DetailViewController!
    
    @IBOutlet weak var searchCoffeeBar: UISearchBar!
    
    
    //weak var delegate:AddCoffeeViewController?
    var indexSelected = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let nibCell = UINib(nibName: CardCollectionViewCellId, bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: CardCollectionViewCellId)
        collectionView.dataSource = self
        collectionView.delegate = self
        searchCoffeeBar.delegate = self
        
        //
        
        models = CoreDataHandler.shared.retrive()
        collectionView.reloadData()
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
//        view.addGestureRecognizer(tap)
        
        print(models)
        
    }
    
  
    override func viewDidAppear(_ animated: Bool) {
        models = CoreDataHandler.shared.retrive()
        collectionView.reloadData()
    }
    
    @IBAction func didAddButtonTap(_ sender: UIButton) {
        guard let addController = storyboard?.instantiateViewController(identifier: "addView") as? AddCoffeeViewController else {
            print("failed")
            return
        }
        addController.ListCoffee = self
        searchCoffeeBar.endEditing(true)
        present(addController, animated: true)
        
    }
    
    
}

extension ListCoffeeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCellId, for: indexPath) as! CardCollectionViewCell
        
        print(indexPath.row)
        let coffee = models[indexPath.row]
        cell.nameCoffee.text = coffee.name
        cell.imgCoffee.image = UIImage(data: coffee.imgcoffee ?? Data())
        cell.priceCoffee.text = coffee.price
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let manager = CoreDataHandler()
        if searchText != "" {
            models = manager.fetchSearchData(searchText: searchText)
            collectionView.reloadData()
        } else {
            models = manager.retrive()
            collectionView.reloadData()
            self.view.endEditing(true)
            searchCoffeeBar.endEditing(true)
            self.collectionView.keyboardDismissMode = .none
        }
                
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return models.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indexSelected = indexPath.row
        let coffeedetail = DetailViewController()
        coffeedetail.datacoffee = models[indexSelected]
        coffeedetail.index = indexSelected
        coffeedetail.delegate = self
        searchCoffeeBar.endEditing(true)
        present(coffeedetail, animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset: CGFloat = 10
        return UIEdgeInsets(top: inset, left: 30, bottom: inset, right: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 152, height: 217)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchCoffeeBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }
        searchCoffeeBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            searchBar.searchTextField.resignFirstResponder()
        }
        self.view.endEditing(true)
        searchCoffeeBar.endEditing(true)
        self.collectionView.keyboardDismissMode = .none
    }
    
    func initializeHideKeyboard(){
        //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        //Add this tap gesture recognizer to the parent view
        view.addGestureRecognizer(tap)
    }
    
    

    @IBAction func swipeHandler(_ gestureRecognizer : UISwipeGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            view.endEditing(true)
        }
    }
    @objc func dismissMyKeyboard(){
        //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
        //In short- Dismiss the active keyboard.
        view.endEditing(true)
    }
    
    
}

extension ListCoffeeViewController: DetailViewControllerDelegate {
    func updateData() {
        
        self.models = CoreDataHandler.shared.retrive()
        self.collectionView.reloadData()
        
    }
    
}

