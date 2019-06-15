//
//  DrawViewController.swift
//  CreativeNotes
//
//  Created by Andre Sarokhanian on 6/1/19.
//  Copyright © 2019 Andre Sarokhanian. All rights reserved.
//

import UIKit
import CoreData 

class DrawViewController: UIViewController, StoryboardBound {

    
    @IBOutlet weak var drawImageView: UIImageView!
    @IBOutlet weak var mainDrawingArea: SwiftyDrawView!
    
    weak var coordinator: MainCoordinator?
    
    weak var delegate: DrawViewControllerDelegate?
    
    var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       mainDrawingArea.backgroundColor = UIColor.white
    }
    

    
    
    @IBAction func changeBrushColor(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            return mainDrawingArea.brush.color = UIColor.red
        case 1:
            return mainDrawingArea.brush.color = UIColor.green
        case 2:
            return mainDrawingArea.brush.color = UIColor.blue
        case 3:
            return mainDrawingArea.brush.color = UIColor.black
        case 4:
            return mainDrawingArea.brush.color = UIColor.white
        default:
            return mainDrawingArea.brush.color = UIColor.black
        }
        
    }
    
    @IBAction func saveDrawingLocally(_ sender: UIButton) {
        // save image to UIImageView
        let image = renderViewToUIImage(uiview: mainDrawingArea)
        drawImageView.image = image
        
        // saving image to photolibrary
        let activity = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activity, animated: true)
    }
    
    // save the image within the app not in your photos
    @IBAction func saveDrawingInternally(_ sender: Any) {
        let image = renderViewToUIImage(uiview: mainDrawingArea)
        drawImageView.image = image
    }
    
    func renderViewToUIImage(uiview: UIView) -> UIImage  {
        
        let renderer = UIGraphicsImageRenderer(size: uiview.bounds.size)
        
        let image = renderer.image { ctx in
            uiview.drawHierarchy(in: drawImageView.bounds, afterScreenUpdates: true)
        }
        
        return image
    }
}
