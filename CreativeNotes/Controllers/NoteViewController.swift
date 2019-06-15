//
//  NoteViewController.swift
//  CreativeNotes
//
//  Created by Andre Sarokhanian on 6/1/19.
//  Copyright © 2019 Andre Sarokhanian. All rights reserved.
//


import UIKit
import CoreData
import MobileCoreServices
import Photos
import UserNotificationsUI

class NoteViewController: UIViewController, StoryboardBound {
    
   
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var noteImageView: UIImageView!
    
    @IBOutlet var buttons: [UIButton]!
    
    weak var coordinator: MainCoordinator?
    
    var managedObjectContext: NSManagedObjectContext?
    
    let imagePicker = UIImagePickerController()
    
    var allItems = [UIView]()
    
    var note: Note? {
        didSet {
            updateUserInterface()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNoteViewController()
        initSetDate()
    }
    
    @IBAction func saveNote(_ sender: Any) {
        
        if note != nil {
            saveEditedEntry()
            
            navigationController?.popViewController(animated: true)
        } else {
            saveNewEntry()
            
            
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func addPhoto(_ sender: UIButton) {
        
        let photoAuthorization = PHPhotoLibrary.authorizationStatus()
        
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.delegate = self
        
        if photoAuthorization == .notDetermined {
            
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized {
                    self.present(picker, animated: true)
                }
            })
            
        } else if photoAuthorization == .authorized {
            present(picker, animated: true)
            
        } else if photoAuthorization == .denied {
            
            displayAlert(title: "Camera & Photos access denied", message: "Please grant access!")
        }
    }
    
    
    @IBAction func deleteNote(_ sender: UIButton) {
        
        if let note = note {
            managedObjectContext?.delete(note)
            managedObjectContext?.saveContext()
            
            navigationController?.popViewController(animated: true)
        }
    }
    
    
    @IBAction func draw(_ sender: Any) {
        coordinator?.drawVC()
    }
 
    
    
    
    @IBAction func backToDetailVCFromDrawVC(segue: UIStoryboardSegue) {
        
        if segue.source is DrawViewController {
            if let segueVC = segue.source as? DrawViewController {
                let image = segueVC.renderViewToUIImage(uiview: segueVC.mainDrawingArea)
                
                self.noteImageView.image = image
                segueVC.delegate?.drawingSaved(for: note!)
            }
        }
    }
  
    
}

