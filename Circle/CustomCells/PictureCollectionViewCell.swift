//
//  PictureCollectionViewCell.swift
//  Circle
//
//  Created by Kumar Rounak on 17/07/18.
//  Copyright © 2018 Kumar Rounak. All rights reserved.
//

import UIKit

class PictureCollectionViewCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    func generateCell(image: UIImage) {
        self.imageView.image = image
    }
    
    
}
