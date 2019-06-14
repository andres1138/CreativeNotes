//
//  NoteCell.swift
//  CreativeNotes
//
//  Created by Andre Sarokhanian on 6/1/19.
//  Copyright © 2019 Andre Sarokhanian. All rights reserved.
//

import UIKit
import CoreData


class NoteCell: UITableViewCell {
    
    static let reuseIdentifier = "noteCell"
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var  cellTitle: UILabel!
    @IBOutlet weak var  cellContent: UILabel!
    @IBOutlet weak var  cellDateLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
