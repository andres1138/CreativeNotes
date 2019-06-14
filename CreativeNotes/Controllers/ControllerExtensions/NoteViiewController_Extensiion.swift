//
//  ViewController+ExtensionDelegate.swift
//  CreativeNotes
//
//  Created by Andre Sarokhanian on 6/2/19.
//  Copyright © 2019 Andre Sarokhanian. All rights reserved.
//

import Foundation
import UIKit
import CoreData


//MARK: NoteViewController Extension
extension NoteViewController: NoteDetailsDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    func noteDetailsVC(_ newNote: Note) {
        note = newNote
    }
    
    func setupNoteViewController() {
        
        if let note = note {
            setupNoteDetailsPage(note: note)
        }
        
        titleTextField.delegate = self
        contentTextView.delegate = self
      
     
        
      
    }
    
    func assignManagedAttributes(note: Note, title: String, content: String, image: UIImage?,  date: Date? = nil) {
        note.title = title
        note.content = content
        
        if date != nil {
            note.date = date!
        }
        
        if image != nil , let data = image!.pngData() {
            note.imageData = data
        }
    }
    
    
    // actual setup
    func setupNoteDetailsPage(note: Note?) {
        titleTextField.text = note?.title
        contentTextView.text = note?.content
        
        if let date = note?.date {
            dateLabel.text = date.formatDateToString(date: date)
        }
        
        
        if let imageData = note?.imageData, let image = UIImage(data: imageData) {
            noteImageView.image = image
        }
    }
    
    
    func updateUserInterface() {
        loadViewIfNeeded()
        setupNoteDetailsPage(note: note)
    }
    
    
    // MARK: Note Save & Delete methods
    func saveNewEntry()  {
        
        guard let title = titleTextField.text, !title.isEmpty, let content = contentTextView.text, !content.isEmpty else {
            displayAlert(title: "Huh", message: "You realize that there is no title or actual content yet you are trying to save!")
            print("Tried to save without a title and summary")
            return
        }
        
        if (managedObjectContext != nil)  {
            let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: managedObjectContext!) as! Note
            assignManagedAttributes(note: note, title: title, content: content, image: noteImageView.image, date: Date())
            managedObjectContext?.saveContext()
        } else {
            print("Managed Object Context is nil")
        }
    }
    
    func saveEditedEntry() {
        if let note = note {
            assignManagedAttributes(note: note, title: titleTextField.text!, content: contentTextView.text, image: noteImageView.image)
        }
    }
    
    
    func initSetDate() {
        let date = Date()
        let todaysDate = date.formatDateToString(date: date)
        dateLabel.text = todaysDate
    }
    
}

extension NoteViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func displayImagePicker() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        if let pickedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
            noteImageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}

