//
//  MaterialView.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 30/03/2016.
//  Copyright © 2016 Mel Schatynski. All rights reserved.
//

import UIKit

class MaterialView: UIView {
    
    
    override func awakeFromNib() {
        
        layer.cornerRadius = 5.0
        layer.shadowColor = UIColor(red: SHADOW_COLOUR, green: SHADOW_COLOUR, blue: SHADOW_COLOUR, alpha: 0.5).CGColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSizeMake(0.0, 2.0)
        
    }

}
