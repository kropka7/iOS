//
//  AddLocationViewController.swift
//  On_The_Map
//
//  Created by Marta on 27/04/2020.
//  Copyright © 2020 Marta. All rights reserved.
//

import UIKit
import Foundation

class AddLocationViewController: UIViewController {

    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var findButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var cencelButton: UIBarButtonItem!

    override func viewDidLoad() {
            super.viewDidLoad()
            setBackground()
            setElements()
        }

        func setBackground() {
            view.backgroundColor = UIColor(red: 205 / 255, green: 239 / 255, blue: 255 / 255, alpha: 1.00)
        }

        func setElements() {
            // Hide the error label
            errorLabel.alpha = 0

            // style elements

            Utilities.styleTextField(locationTextField)
            Utilities.styleTextField(linkTextField)
            Utilities.styleButton(findButton)
            Utilities.styleLabel(errorLabel)

        }

    @IBAction func cencelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
