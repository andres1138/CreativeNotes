//
//  ViewController.swift
//  CreativeNotes
//
//  Created by Andre Sarokhanian on 6/1/19.
//  Copyright © 2019 Andre Sarokhanian. All rights reserved.
//

import UIKit
import CoreData
import MobileCoreServices


class ViewController: UITableViewController, StoryboardBound {

    weak var coordinator: MainCoordinator?
    weak var delegate: NoteDetailsDelegate?
    
    var noteEntity: Note?
    
    var managedObjectContext = CoreDataStack().managedObjectContext
    
    lazy var dataSource: DataSource = {
        return DataSource(tableView: self.tableView, context: self.managedObjectContext)
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupMasterVC()
        
        let addNoteBtn = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(addNewNote))
        self.navigationItem.rightBarButtonItem = addNoteBtn
       
    }


    @objc func addNewNote() {
        
        let alert = UIAlertController(title: "Enter Note Title", message: nil, preferredStyle: .alert)
        alert.addTextField()
        
        let action = UIAlertAction(title: "Create New Note", style: .default) { [unowned alert] _ in
            let text = alert.textFields![0]
            let context = self.managedObjectContext
            let newNoteEntity = Note(context: context)
          
           
            newNoteEntity.title = text.text ?? "Untitled Note"
            newNoteEntity.content = "Unwritten Note Content"
            newNoteEntity.date = Date()
          
            
            self.managedObjectContext.saveContext()
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
    
    
    func setupMasterVC() {
        self.tableView.dataSource = dataSource
        self.tableView.rowHeight = 150
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
     
        
        // setting the search bar
        dataSource.setSearchController()
        navigationItem.searchController = dataSource.searchController
        definesPresentationContext = true
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let note = dataSource.fetchedResultsController.object(at: indexPath)
      
        coordinator?.toDetailsPageWithInfo(note: note)
        
    }
    
}
