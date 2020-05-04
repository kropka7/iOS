//
//  Utilities.swift
//  On_the_Map
//
//  Created by marta on 11/04/2020.
//  Copyright © 2020 marta. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    // style Textfield

    static func styleTextField(_ textfield: UITextField) {
        textfield.layer.masksToBounds = true
        textfield.tintColor = .white
        textfield.textColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.00)
        textfield.font = UIFont(name: "AppleSDGothicNeo", size: 18)
        textfield.layer.cornerRadius = 20.0
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor(white: 1.0, alpha: 2).cgColor
        textfield.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
    }

    // style Button

    static func styleButton(_ button: UIButton) {
        button.layer.cornerRadius = 20.0
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        button.setTitleColor(UIColor.systemBlue, for: .normal)

        // button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.00
        ).cgColor
    }

    // style Label

    static func styleLabel(_ label: UILabel) {
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
        label.textColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.00)
    }
}
