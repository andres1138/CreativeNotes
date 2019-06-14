//
//  MainCoordinator.swift
//  CreativeNotes
//
//  Created by Andre Sarokhanian on 6/1/19.
//  Copyright © 2019 Andre Sarokhanian. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var subcoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    var note: Note?
   
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func startVC() {
        navigationController.delegate = self
        let viewC = ViewController.instantiate()
        viewC.coordinator = self
        navigationController.pushViewController(viewC, animated: false)
    }
    
  
    
    func drawVC() {
        navigationController.delegate = self
        let drawVC = DrawViewController.instantiate()
        drawVC.coordinator = self
        navigationController.pushViewController(drawVC, animated: true)
        
    }
    
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
            
        }
        
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        if let noteDetails = fromViewController as? NoteViewController {
            childDidFinish(noteDetails.coordinator)
        }
        

    }
    
    
    func childDidFinish(_  child: Coordinator?) {
        
        for (index, coordinator) in subcoordinators.enumerated() {
            if coordinator === child {
                subcoordinators.remove(at: index)
                break
            }
        }
    }
    
    
    func toDetailsPageWithInfo(note: Note) {
        navigationController.delegate = self
        let noteVC = NoteViewController.instantiate()
        noteVC.coordinator = self
       noteVC.note = note
        navigationController.pushViewController(noteVC, animated: true)
    }
    
   
}

