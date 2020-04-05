//
//  SentMemesCollectionViewController.swift
//  MemeMe_2.0
//
//  Created by marta on 04/04/2020.
//  Copyright © 2020 udacity.com. All rights reserved.
//

import UIKit

private let reuseIdentifier = "collectionCell"

class SentMemesCollectionViewController: UICollectionView {
    
    var memes: [Meme]!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

}
