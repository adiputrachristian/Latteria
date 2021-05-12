//
//  CoreDataHandler.swift
//  Latteria
//
//  Created by Christian Adiputra on 01/05/21.
//

import Foundation
import CoreData
import UIKit
class CoreDataHandler {
    
    static let shared = CoreDataHandler()

    
    // fungsi tambah data
    func create(name: String, price: String, imgdata: Data, typecoffee: String, putdate: Date ){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // refensi entity yang telah dibuat sebelumnya
        guard let userEntity = NSEntityDescription.entity(forEntityName: "CoffeeData", in: context) else {return}
        
        // entity body
        let coffee = CoffeeData(entity: userEntity, insertInto: context)
        
        //coffee.id = Int64(id)
        coffee.name = name
        coffee.price = price
        coffee.imgcoffee = imgdata
        coffee.typecoffee = typecoffee
        coffee.date = putdate
        
        do{
            // save data ke entity user core data
            try context.save()
        }catch let err{
            print(err)
        }
        
    }
    
    func retrive()->[CoffeeData]{
        var coffee = [CoffeeData]()
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            coffee = try context.fetch(CoffeeData.fetchRequest())
        } catch  {
            print("")
        }
        //print(coffee)
        return coffee
    }
    
    func update(_ firstName:String, _ lastName:String, _ email:String){
        
        // referensi ke AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // fetch data to delete
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "email = %@", email)
        
        do{
            let fetch = try managedContext.fetch(fetchRequest)
            let dataToUpdate = fetch[0] as! NSManagedObject
            dataToUpdate.setValue(firstName, forKey: "first_name")
            dataToUpdate.setValue(lastName, forKey: "last_name")
            dataToUpdate.setValue(email, forKey: "email")
            
            try managedContext.save()
        }catch let err{
            print(err)
        }
        
    }
    
    // fungsi menghapus by email user
    func delete(coffeeDataToDelete: CoffeeData){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // refensi entity yang telah dibuat sebelumnya
        guard let userEntity = NSEntityDescription.entity(forEntityName: "CoffeeData", in: context) else {return}
    
        
       //let coffeDataToDelete =  CoffeeData[indexPath]
        context.delete(coffeeDataToDelete)
        do{
            
            try context.save()
        }catch let err{
            print(err)
        }
        
    }
    
    func fetchSearchData(searchText: String) -> [CoffeeData]{
        var coffee = [CoffeeData]()
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchText)
        let request:NSFetchRequest = CoffeeData.fetchRequest()
        request.predicate = predicate
        do {
            coffee = try (context.fetch(request))
        } catch  {
            print("Error Boy")
        }
        return coffee
    }

}
