//
//  CoffeeData+CoreDataProperties.swift
//  
//
//  Created by Christian Adiputra on 05/05/21.
//
//

import Foundation
import CoreData


extension CoffeeData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoffeeData> {
        return NSFetchRequest<CoffeeData>(entityName: "CoffeeData")
    }

    @NSManaged public var date: Date?
    @NSManaged public var imgcoffee: Data?
    @NSManaged public var name: String?
    @NSManaged public var price: String?
    @NSManaged public var typecoffee: String?

}
