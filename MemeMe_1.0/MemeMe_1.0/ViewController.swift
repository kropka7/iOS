//
//  ViewController.swift
//  MemeMe_1.0
//
//  Created by marta on 21/03/2020.
//  Copyright © 2020 udacity.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imagePickerView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func pickAnImage(_ sender: Any) {
        let pickerController = UIImagePickerController ()
        present(pickerController, animated: true, completion: nil)
    }
}







