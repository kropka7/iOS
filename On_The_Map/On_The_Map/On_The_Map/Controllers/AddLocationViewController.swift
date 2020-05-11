//
//  AddLocationViewController.swift
//  On_The_Map
//
//  Created by Marta on 27/04/2020.
//  Copyright © 2020 Marta. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class AddLocationViewController: UIViewController {
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var linkTextField: UITextField!
    @IBOutlet var findButton: UIButton!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var cencelButton: UIBarButtonItem!

    var coordinateToDisplay: CLLocationCoordinate2D!
    var linkToAdd: String!
    var locationInString: String!

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

    @IBAction func findLocation(_ sender: Any) {
        guard let location = locationTextField.text, let link = linkTextField.text, !location.isEmpty, !link.isEmpty else {
            showMessage(message: "Please enter a location and a link", title: "Find Location Failed")
            return
        }

        linkToAdd = link
        locationInString = location

        getCoordinateFromString(locationStringFromUser: locationInString, completion: handleGetCoordinate(success:error:))
    }

    func getCoordinateFromString(locationStringFromUser: String, completion: @escaping (Bool, Error?) -> Void) {
        setGettingLocation(true)
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(locationStringFromUser) { placemarks, error in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let coordinate = placemark.location!.coordinate

                    self.coordinateToDisplay = coordinate
                    completion(true, nil)
                    return
                }
            } else {
                completion(false, error)
            }
        }
    }

    func handleGetCoordinate(success: Bool, error: Error?) {
        setGettingLocation(false)
        if success {
            let controller = storyboard!.instantiateViewController(withIdentifier: "EndMapViewController") as! EndMapViewController

            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinateToDisplay
            annotation.title = locationInString

//            controller.annotation = annotation
//            controller.url = linkToAdd

          //  controller.mapLocationString = locationInString

            navigationController?.pushViewController(controller, animated: true)
        } else {
            showMessage(message: error!.localizedDescription, title: "Find Location Failed")
        }
    }

    func setGettingLocation(_ gettingLocation: Bool) {

        locationTextField.isEnabled = !gettingLocation
        linkTextField.isEnabled = !gettingLocation
    }

    @IBAction func cencelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
