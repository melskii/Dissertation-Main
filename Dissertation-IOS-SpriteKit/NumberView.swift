//
//  NumberView.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 10/04/2016.
//  Copyright © 2016 Mel Schatynski. All rights reserved.
//

import UIKit

class NumberView: UIView {
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn9: UIButton!
    @IBOutlet weak var btn0: UIButton!
    @IBOutlet weak var btnDel: UIButton!
    @IBOutlet weak var btnDone: UIButton!
    
    var delegate: KeyboardDelegate?
    
    
    override func awakeFromNib() {
        
        layer.cornerRadius = 5.0
        layer.shadowColor = UIColor(red: SHADOW_COLOUR, green: SHADOW_COLOUR, blue: SHADOW_COLOUR, alpha: 0.5).CGColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSizeMake(0.0, 2.0)

        
        btn1.layer.cornerRadius = 10
        btn2.layer.cornerRadius = 10
        btn3.layer.cornerRadius = 10
        btn4.layer.cornerRadius = 10
        btn5.layer.cornerRadius = 10
        btn6.layer.cornerRadius = 10
        btn7.layer.cornerRadius = 10
        btn8.layer.cornerRadius = 10
        btn9.layer.cornerRadius = 10
        btn0.layer.cornerRadius = 10
        btnDel.layer.cornerRadius = 10
        btnDone.layer.cornerRadius = 10
    }

    @IBAction func buttonTouchDown(sender: UIButton) {
        
        delegate?.numberKeyboard(sender)
        
    }
    
    
    
    
    
}
