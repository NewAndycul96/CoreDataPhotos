//
//  Friend+CoreDataProperties.swift
//  Photos_Core_data
//
//  Created by Anand Kulkarni on 10/19/18.
//  Copyright © 2018 Anand Kulkarni. All rights reserved.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var contactInfo: String?
    @NSManaged public var rawImage: NSData?

}
