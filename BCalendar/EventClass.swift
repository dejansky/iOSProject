//
//  EventClass.swift
//  BCalendar
//
//  Created by Vida Rashidi on 2019-11-27.
//  Copyright © 2019 Project. All rights reserved.
//

import Foundation

class Event {
    //NS datatypes to save as userDefaults
    
    var eventDate = 0
    var eventTime = 0
    var eventDescription: String
    
    init(_ eventDate: Int, _ eventTime: Int, _ eventDescription: String ){
        self.eventDate = eventDate
        self.eventDescription = eventDescription
        self.eventTime = eventTime
    }
    
    func getEventDate () -> Int{
        return self.eventDate
    }
    
    func getEventTime () -> Int{
        return self.eventTime
    }
    
    func getEventDescription() -> String{
        return self.eventDescription
    }
    
    //funktioner för att konvertera till NS?
    
    
    
}
