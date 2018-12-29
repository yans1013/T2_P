//
//  NoteManagedObject+CoreDataProperties.swift
//  T2_P_TestNotes
//
//  Created by 寺先生 on 2018/12/26.
//  Copyright © 2018 wu yuansi. All rights reserved.
//
//

import Foundation
import CoreData


extension NoteManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteManagedObject> {
        return NSFetchRequest<NoteManagedObject>(entityName: "Note")
    }

    @NSManaged public var content: String?
    @NSManaged public var date: NSDate?

}
