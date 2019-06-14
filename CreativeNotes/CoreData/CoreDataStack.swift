//
//  CoreDataStack.swift
//  CreativeNotes
//
//  Created by Andre Sarokhanian on 6/1/19.
//  Copyright © 2019 Andre Sarokhanian. All rights reserved.
//

import Foundation
import UIKit
import CoreData



class CoreDataStack {
    
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let container = self.persistentContainer
        return container.viewContext
    }()
    
    
    
    
    private(set) lazy var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "Database")
        print("NSPersistentContainer name is \(container.name)")
        
        container.loadPersistentStores { storeDescriptor, error in
            if let error = error as NSError? {
                fatalError()
            }
        }
        
        return container
    }()
    
}


extension NSManagedObjectContext {
    
    func saveContext() {
        
        if self.hasChanges {
            do {
                try save()
            } catch {
                fatalError()
            }
        }
    }
}
