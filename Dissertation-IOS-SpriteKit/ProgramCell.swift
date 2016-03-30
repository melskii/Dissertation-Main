//
//  ProgramCell.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 30/03/2016.
//  Copyright © 2016 Mel Schatynski. All rights reserved.
//

import UIKit

class ProgramCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    
    
    var block: Block!
    
    func configureCell(block: Block) {
        
        self.block = block
        
        thumbImg.image = UIImage(named: "\(self.block.program)")
    }

}
