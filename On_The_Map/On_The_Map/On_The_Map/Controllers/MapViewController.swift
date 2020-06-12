//
//  MapViewController.swift
//  On_The_Map
//
//  Created by Marta on 05/06/2020.
//  Copyright © 2020 Marta. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var refreshButton: UIBarButtonItem!

    var locationManager: CLLocationManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UdacityAPI.getStudentLocation { (studentInformation, error) in
            if let error = error {
                self.showMessage(message: error.localizedDescription, title:"Download failed")
                return
            }
            
            InformationList.studentInformationList = studentInformation
            var annotations = [MKPointAnnotation]()
            
            for dictionary in InformationList.studentInformationList {
                let latitude = CLLocationDegrees(dictionary.latitude )
                let longitude = CLLocationDegrees(dictionary.longitude)
                let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                let firstName = dictionary.firstName
                let lastName = dictionary.lastName
                let mediaURL = dictionary.mediaURL
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = "\(String(describing: firstName)) \(String(describing: lastName))"
                annotation.subtitle = mediaURL
                annotations.append(annotation)
            }
            self.mapView.addAnnotations(annotations)
        }
        mapView.reloadInputViews()
    }
    
    
    @IBAction func logoutTapped(_ sender: Any) {
        UdacityAPI.logout() {
            _ in DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func refreshTapped(_ sender: UIBarButtonItem) {
        UdacityAPI.getStudentLocation { (studentLocation, error) in
            if let error = error {
                self.showMessage(message: error.localizedDescription, title:"Download failed")
                return
            }
            InformationList.studentInformationList = studentLocation
        }
    }
    
    
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
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.open(URL(string: toOpen)!, options: [:], completionHandler: nil)
            }
        }
    }
}

