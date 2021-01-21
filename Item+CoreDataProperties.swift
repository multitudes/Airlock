//
//  Item+CoreDataProperties.swift
//  Airlock
//
//  Created by Laurent B on 20/01/2021.
//
//

import Foundation
import CoreData


extension Item {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var creationDate: Date?
    @NSManaged public var myText: String?
    @NSManaged public var timeMeditated: Int16

}

