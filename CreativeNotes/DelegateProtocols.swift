//
//  NoteEntityDelegate.swift
//  CreativeNotes
//
//  Created by Andre Sarokhanian on 6/1/19.
//  Copyright © 2019 Andre Sarokhanian. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol NoteDetailsDelegate: AnyObject {
    
    func noteDetailsVC(_ newNote: Note)
}


protocol DrawViewControllerDelegate: AnyObject {
    
    func drawingSaved(for drawNote: Note)
}
