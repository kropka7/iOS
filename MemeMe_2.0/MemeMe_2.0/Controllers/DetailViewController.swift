//
//  DetailViewController.swift
//  MemeMe_2.0
//
//  Created by marta on 07/04/2020.
//  Copyright © 2020 udacity.com. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!

    var memes: Meme!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tabBarController?.tabBar.isHidden = true

        imageView!.image = memes.memedImage
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
}
