//
//  MapViewController.swift
//  On_the_Map
//
//  Created by marta on 18/04/2020.
//  Copyright © 2020 marta. All rights reserved.
//
import Foundation
import MapKit
import UIKit
/**
 * This view controller demonstrates the objects involved in displaying pins on a map.
 *
 * The map is a MKMapView.
 * The pins are represented by MKPointAnnotation instances.
 *
 * The view controller conforms to the MKMapViewDelegate so that it can receive a method
 * invocation when a pin annotation is tapped. It accomplishes this using two delegate
 * methods: one to put a small "info" button on the right side of each pin, and one to
 * respond when the "info" button is tapped.
 */

class MapViewController: UIViewController, MKMapViewDelegate {
    // The map. See the setup in the Storyboard file. Note particularly that the view controller
    // is set up as the map view's delegate.

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var logoutButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        let limit = 100
        let order = "updatedAt"
        UdacityAPI.getStudentLocations(limit: limit, order: order) { response, error in
            if let error = error {
                self.showMessage(message: error.localizedDescription, title: "Connection Error")
                return
            }

            StudentLocationModel.locationsPast = response ?? [StudentLocation]()

            self.reloadData()
            self.mapView.delegate = self
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapView.reloadInputViews()
        reloadData()
    }

    func reloadData() {
        mapView.removeAnnotations(mapView.annotations)

        for location in StudentLocationModel.locationsPast {
            let latitude = CLLocationDegrees(location.latitude)
            let longitude = CLLocationDegrees(location.longitude)
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

            let annotation = MKPointAnnotation()
            annotation.title = "\(location.firstName)"
            annotation.subtitle = location.mediaURL
            annotation.coordinate = coordinate

            mapView.addAnnotation(annotation)
        }
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView

        if let pinView = pinView {
            pinView.annotation = annotation
        } else {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            pinView?.pinTintColor = MKPinAnnotationView.redPinColor()
            pinView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }

        return pinView
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let url = view.annotation?.subtitle else { return }

        if url!.isValidURL {
            var validUrl = url!

            if !(validUrl.hasPrefix("http://") || validUrl.hasPrefix("https://")) {
                validUrl = "https://" + validUrl
            }

            if control == view.rightCalloutAccessoryView {
                let app = UIApplication.shared
                app.open(URL(string: validUrl)!, options: [:], completionHandler: nil)
            }

        } else {
            return
        }
    }

    @IBAction func logoutButton(_ sender: Any) {
        UdacityAPI.logout { _, _ in
            DispatchQueue.main.async {
                StudentLocationModel.clearAll()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
