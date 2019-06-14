//
//  DataSource.swift
//  CreativeNotes
//
//  Created by Andre Sarokhanian on 6/1/19.
//  Copyright © 2019 Andre Sarokhanian. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Photos
import MobileCoreServices



class DataSource: NSObject, UITableViewDataSource  {
   
    
    private let tableView: UITableView
    private let context: NSManagedObjectContext
    
    var note: Note?
    
    lazy var fetchedResultsController: DatabaseFetchedResultsController = {
        return DatabaseFetchedResultsController(tableView: self.tableView, managedObjectContext: self.context)
    }()
    
    
    var searchableNotes = [Note]()
    
    // search bar
    let searchController = UISearchController(searchResultsController: nil)
    
    
    
    init(tableView: UITableView, context: NSManagedObjectContext) {
        self.tableView = tableView
        self.context = context
    }
}

extension DataSource {
    
    func object(at indexPath: IndexPath) -> Note {
        return fetchedResultsController.object(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if isSearching() {
            return searchableNotes.count
        } else {
            
            guard let section = fetchedResultsController.sections?[section] else {
                return 0
            }
            
            return section.numberOfObjects
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
       let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.reuseIdentifier, for: indexPath) as! NoteCell
        
        let noteEntity = fetchedResultsController.object(at: indexPath)
       let noteDate = noteEntity.date
        let presentND = noteDate?.formatDateToString(date: noteDate!)
        
        cell.cellTitle.text = noteEntity.title
        cell.cellContent.text = noteEntity.content
        cell.cellDateLabel.text = presentND
        
      
        if let data = noteEntity.imageData as Data? {
            cell.cellImage?.image = UIImage(data: data)
        }
        
        return configureCell(cell, at: indexPath)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let noteEntity = fetchedResultsController.object(at: indexPath)
        context.delete(noteEntity)
        context.saveContext()
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // this will turn on `masksToBounds` just before showing the cell
        cell.contentView.layer.masksToBounds = true
        cell.contentView.clipsToBounds = true
    }
    
    
    func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath) -> UITableViewCell {
        

        let cell = self.tableView.dequeueReusableCell(withIdentifier: NoteCell.reuseIdentifier, for: indexPath) as! NoteCell
       

        
        
        if isSearching() {
            let noteEntity = searchableNotes[indexPath.row]
              let noteDate = noteEntity.date?.formatDateToString(date: noteEntity.date!)
           
            cell.cellTitle.text = noteEntity.title
            cell.cellContent.text = noteEntity.content
            cell.cellDateLabel.text = noteDate
            
            
            if let data = noteEntity.imageData as Data? {
                cell.cellImage?.image = UIImage(data: data)
            }
            
            
        } else {
            let noteEntity = fetchedResultsController.object(at: indexPath)
             let noteDate = noteEntity.date?.formatDateToString(date: noteEntity.date!)
            
            cell.cellTitle.text = noteEntity.title
            cell.cellContent.text = noteEntity.content
            cell.cellDateLabel.text = noteDate
            
            
            if let data = noteEntity.imageData as Data? {
                cell.cellImage?.image = UIImage(data: data)
            }
        }
        return cell
    }
    
    
    
   
    
    
    
}



extension DataSource: UISearchResultsUpdating {
 
    
    // MARK: Search bar methods
    func setSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by Title and Content"
    }
    
    func isSearchBarEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filtereringContentWithSearchbar(_ searchingText: String, scope: String = "All") {
        guard let objects = fetchedResultsController.fetchedObjects else {
            return
        }
        
        searchableNotes = objects.filter({( note: Note) -> Bool in
            let content = note.content.lowercased().contains(searchingText.lowercased())
            let title = note.title.lowercased().contains(searchingText.lowercased())
            
            // user will be able to search for title & content
            if content || title {
                return true
            } else {
                return false
            }
        })
        tableView.reloadData()
    }
    
    func isSearching() -> Bool {
        return searchController.isActive && !isSearchBarEmpty()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filtereringContentWithSearchbar(searchController.searchBar.text!)
    }
    
    
}
