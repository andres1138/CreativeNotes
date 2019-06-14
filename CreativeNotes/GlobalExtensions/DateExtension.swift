//
//  DateExtension.swift
//  CreativeNotes
//
//  Created by Andre Sarokhanian on 6/2/19.
//  Copyright © 2019 Andre Sarokhanian. All rights reserved.
//

import Foundation
import UIKit


extension Date {
    
    func formatDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMM dd, yyy"
        
        let presentDate = dateFormatter.string(from: date)
        
        return presentDate
    }
    
}
