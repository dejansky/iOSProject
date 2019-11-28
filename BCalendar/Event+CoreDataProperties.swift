//
//  Event+CoreDataProperties.swift
//  BCalendar
//
//  Created by Vida Rashidi on 2019-11-28.
//  Copyright © 2019 Project. All rights reserved.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var eventdate: Int32
    @NSManaged public var eventtime: Int32
    @NSManaged public var eventdescription: String?

}
