//
//  MaterialTextField.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 30/03/2016.
//  Copyright © 2016 Mel Schatynski. All rights reserved.
//

import UIKit

class MaterialTextField: UITextField {
    
    override func awakeFromNib() {
        layer.cornerRadius = 2.0
        layer.borderColor = UIColor(red: SHADOW_COLOUR, green: SHADOW_COLOUR, blue: SHADOW_COLOUR, alpha: 0.5).CGColor
        layer.borderWidth = 2.0
        
        
        var frameRect: CGRect = layer.frame
        frameRect.size.height = 200
        layer.frame = frameRect
        
    }

}
