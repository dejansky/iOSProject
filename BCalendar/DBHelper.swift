//
//  DBHelper.swift
//  BCalendar
//
//  Created by Vida Rashidi on 2019-11-28.
//  Copyright © 2019 Project. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DBHelper{
    static var shareInstance = DBHelper()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func saveData(object:[String:String]){
        let thisEvent =
            NSEntityDescription.insertNewObject(forEntityName: "Event", into: context!) as! Event
        
        thisEvent.eventday = object["eventday"]
        thisEvent.eventyear = object["eventyear"]
        thisEvent.eventmonth = object["eventmonth"]
        thisEvent.eventdescripion = object["eventdescription"]
        
        do{
            try context?.save()
        }catch{
            print("No data to save")
        }
    }
    
    
    func getData(){
        
    }
    

    
}
