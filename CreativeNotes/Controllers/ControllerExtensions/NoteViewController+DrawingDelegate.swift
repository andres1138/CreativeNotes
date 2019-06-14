//
//  DrawViewController+Extension.swift
//  CreativeNotes
//
//  Created by Andre Sarokhanian on 6/14/19.
//  Copyright © 2019 Andre Sarokhanian. All rights reserved.
//

import Foundation
import CoreData
import UIKit


extension NoteViewController: DrawViewControllerDelegate {
    
    func drawingSaved(for drawNote: Note) {
        note = drawNote
    }
    
    
}

