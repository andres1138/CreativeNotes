//
//  Coordinator.swift
//  CreativeNotes
//
//  Created by Andre Sarokhanian on 6/1/19.
//  Copyright © 2019 Andre Sarokhanian. All rights reserved.
//

import Foundation
import UIKit


protocol Coordinator: AnyObject {
    
    var subcoordinators: [Coordinator] { get set }
    
    var navigationController: UINavigationController { get set }
    
    func startVC()
}
