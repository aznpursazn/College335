//
//  CityEntity+CoreDataProperties.swift
//  Lab5
//
//  Created by Kathy Nguyen on 10/20/18.
//  Copyright © 2018 Kathy Nguyen. All rights reserved.
//
//

import Foundation
import CoreData


extension CityEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityEntity> {
        return NSFetchRequest<CityEntity>(entityName: "CityEntity")
    }

    @NSManaged public var info: String?
    @NSManaged public var name: String?
    @NSManaged public var image: NSData?

}
