//
//  CollectionViewCell.swift
//  MemeMe_2.0
//
//  Created by marta on 04/04/2020.
//  Copyright © 2020 udacity.com. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var collectionImageCell: UIImageView!

    func imageSetup() {
        collectionImageCell.contentMode = .scaleAspectFit
    }
}
