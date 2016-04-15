//
//  ProgramCell.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 30/03/2016.
//  Copyright © 2016 Mel Schatynski. All rights reserved.
//

import UIKit

class ProgramCell: UICollectionViewCell {
    
    @IBOutlet weak var imgThumbnail: UIImageView!
    
    
    var block: Block!
    
    func configureCell(block: Block) {
        
        self.block = block
        
        imgThumbnail.image = UIImage(named: "\(self.block.program)")
    }

}
