//
//  EndMapViewController.swift
//  On_The_Map
//
//  Created by Marta on 11/05/2020.
//  Copyright © 2020 Marta. All rights reserved.
//

import UIKit
import Foundation
import MapKit

class EndMapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!

    var annotation: MKPointAnnotation!
        var mapLocationString: String!
        var url: String!
        var locations: [StudentLocation]!


    override func viewDidLoad() {
           super.viewDidLoad()
           setElements()
        mapView.delegate = self
       }

    func setElements() {
        Utilities.styleButton(submitButton)
    }
}

