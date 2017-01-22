//
//  BackgroundImageLoader.swift
//  Eloquence
//
//  Created by Sergio Puleri on 1/22/17.
//  Copyright © 2017 Joseph Pena. All rights reserved.
//

import Foundation
import UIKit


class BackgroundImageLoader {
    static func loadBackground(imageName: String, vc: UIViewController) {
        // Begin context on view controller
        UIGraphicsBeginImageContext(vc.view.frame.size)
        
        // Draw iamge
        UIImage(named: imageName)?.draw(in: vc.view.bounds)
        
        // Get image from current context
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        // End context
        UIGraphicsEndImageContext()
        
        // Set background
        vc.view.backgroundColor = UIColor(patternImage: image)
    }
}
