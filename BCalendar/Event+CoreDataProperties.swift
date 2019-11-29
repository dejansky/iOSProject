//
//  Event+CoreDataProperties.swift
//  BCalendar
//
//  Created by Vida Rashidi on 2019-11-29.
//  Copyright © 2019 Project. All rights reserved.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var eventday: String?
    @NSManaged public var eventdescripion: String?
    @NSManaged public var eventmonth: String?
    @NSManaged public var eventyear: String?

}
