//
//  CityModel.swift
//  Lab5
//
//  Created by Kathy Nguyen on 10/19/18.
//  Copyright © 2018 Kathy Nguyen. All rights reserved.
//

import UIKit
import CoreData
import Foundation

public class CityModel {
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var fetchResults = [CityEntity]()
    
    func fetchRecord() -> Int {
        // Create a new fetch request using the FruitEntity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CityEntity")
        var x = 0
        // Execute the fetch request, and cast the results to an array of FruitEnity objects
        fetchResults = ((try? managedObjectContext.fetch(fetchRequest)) as? [CityEntity])!
        
        x = fetchResults.count
        
        // return howmany entities in the coreData
        return x
        
        
    }
    
    func addCity(n:String, d:String)
    {
        // create a new entity object
        let ent = NSEntityDescription.entity(forEntityName: "CityEntity", in: self.managedObjectContext)
        //add to the manege object context
        let newItem = CityEntity(entity: ent!, insertInto: self.managedObjectContext)
        newItem.name = n
        newItem.info = d
        newItem.image = nil
        
        updateObject()
        
        print(newItem)
    }
    
    func updateObject() {
        // save the updated context
        do {
            try self.managedObjectContext.save()
        } catch _ {
        }
    }
    
    
    func removeCity(row:Int)
    {
        managedObjectContext.delete(fetchResults[row])
        // remove it from the fetch results array
        fetchResults.remove(at:row)
        
        updateObject()
        
    }
    
    func getCityObject(row:Int) -> CityEntity
    {
        return fetchResults[row]
    }
}
