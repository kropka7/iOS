//
//  EndMapViewController.swift
//  On_The_Map
//
//  Created by Marta on 05/06/2020.
//  Copyright © 2020 Marta. All rights reserved.
//

import UIKit
import MapKit


class EndMapViewController: UIViewController  {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var submitButton: UIButton!

    var locationText: String?
    var mediaURL: String!
    var mapString: String!
    var location: CLLocationCoordinate2D!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleUserLocation()
        mapView.delegate = self
        setElements()
    }

    func setElements() {
        Utilities.styleButton(submitButton)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let annotation = MKPointAnnotation()

        annotation.title = "\(String(describing: UdacityAPI.firstName)) \(String(describing: UdacityAPI.lastName))"
        annotation.subtitle = mediaURL
        mapView.addAnnotation(annotation)
      //  let span = MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100)
      //  _ = MKCoordinateRegion(center: annotation.coordinate, span: span)
        mapView.delegate = self

    }

    

    @IBAction func submitButton(_ sender: Any) {
        UdacityAPI.getUsername { (success, error) in
            if success {
                UdacityAPI.postLocation(mapString: self.mapString, mediaURL: self.mediaURL, longitude:self.location.longitude,latitude:self.location.latitude) { (student, error) in

                    if let student = student {
                        StudentModel.student.append(student)
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                }
            } else {

                self.showMessage(message: error?.localizedDescription ?? "Check internet conneciton", title: "Check internet conneciton and try again")

            }
        }
    }


    func handleUserLocation() {
        let annotation = MKPointAnnotation()
        guard let location = location else {
            showMessage(message: "try difrent location", title:  "try difrent location")
            return
        }
        annotation.coordinate = location
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: StudentModel.regionMeter, longitudinalMeters: StudentModel.regionMeter)
        mapView.addAnnotation(annotation)
        mapView.setRegion(region, animated: true)
    }

}

extension EndMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }

        return pinView
    }
}

func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    if control == view.rightCalloutAccessoryView {
        let app = UIApplication.shared
        if let toOpen = view.annotation?.subtitle! {
            app.open(URL(string: toOpen)!, options: [:], completionHandler: nil)
        }
    }
}


