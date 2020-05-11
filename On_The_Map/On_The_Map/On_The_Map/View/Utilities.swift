//
//  Utilities.swift
//  On_the_Map
//
//  Created by marta on 11/04/2020.
//  Copyright © 2020 marta. All rights reserved.
//

import Foundation
import UIKit
import MapKit


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

// https://stackoverflow.com/a/55255521

//extension URL {
//    init?(withCheck string: String?) {
//        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
//        guard
//            let urlString = string,
//            let url = URL(string: urlString),
//            NSPredicate(format: "SELF MATCHES %@", argumentArray: [regEx]).evaluate(with: urlString),
//            UIApplication.shared.canOpenURL(url)
//        else {
//            return nil
//        }
//
//        self = url
//    }
//}
//
//extension String {
//    var isValidURL: Bool {
//        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
//        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
//            // it is a link, if the match covers the whole string
//            return match.range.length == utf16.count
//        } else {
//            return false
//        }
//    }
//}
