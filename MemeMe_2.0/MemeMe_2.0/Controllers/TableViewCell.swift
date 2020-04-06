//
//  TableViewCell.swift
//  MemeMe_2.0
//
//  Created by marta on 04/04/2020.
//  Copyright © 2020 udacity.com. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet var tableImageCell: UIImageView!
    @IBOutlet var tableTopText: UILabel!
    @IBOutlet var tableBottomText: UILabel!

    let imageWidth: CGFloat = 70.0
    let imageHeight: CGFloat = 70.0

    func imageSetup() {
        let imageSize = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)

        tableImageCell.frame = imageSize
        tableImageCell.contentMode = .scaleAspectFill
    }
}
