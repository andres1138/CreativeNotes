//
//  Note+CoreDataProperties.swift
//  CreativeNotes
//
//  Created by Andre Sarokhanian on 6/1/19.
//  Copyright © 2019 Andre Sarokhanian. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        let request = NSFetchRequest<Note>(entityName: "Note")
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        return request
    }

    @NSManaged public var date: Date?
    @NSManaged public var title: String
    @NSManaged public var content: String
    @NSManaged public var imageData: Data?

}
