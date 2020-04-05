//
//  MemesCollectionViewCell.swift
//  MemeMe_2.0
//
//  Created by marta on 03/04/2020.
//  Copyright © 2020 udacity.com. All rights reserved.
//

import UIKit


class MemesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func imageSetup() {
        imageView.contentMode = .scaleAspectFit
    }
}
