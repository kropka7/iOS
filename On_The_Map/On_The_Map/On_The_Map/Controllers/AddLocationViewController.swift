//
//  AddLocationViewController.swift
//  On_The_Map
//
//  Created by Marta on 05/06/2020.
//  Copyright © 2020 Marta. All rights reserved.
//


import UIKit
import MapKit



class AddLocationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var linkTextField: UITextField!
    @IBOutlet var findButton: UIButton!
    @IBOutlet var cencelButton: UIBarButtonItem!
    
    @IBOutlet weak var activIndecator: UIActivityIndicatorView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        setElements()
        activIndecator.hidesWhenStopped = true
    }
    
    func setBackground() {
        view.backgroundColor = UIColor(red: 205 / 255, green: 239 / 255, blue: 255 / 255, alpha: 1.00)
    }
    
    func setElements() {
        // style elements
        Utilities.styleTextField(locationTextField)
        Utilities.styleTextField(linkTextField)
        Utilities.styleButton(findButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureTextField()
        contifureTapGesture()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    private func contifureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func configureTextField() {
        locationTextField.delegate = self
        linkTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func fundLocationTapped(_ sender: Any) {
        performSegue(withIdentifier: "AddLocationViewController", sender: self)
    }
    
    func getLocation(completion: @escaping (CLLocationCoordinate2D?)->() ) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(locationTextField.text ?? "") { (placemark, error) in
            guard let placemark = placemark, let location = placemark.first?.location else {
                completion(nil)
                return
            }
            completion(location.coordinate)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddLocationViewController", let controller = segue.destination as? EndMapViewController {
            self.getLocation { (location) in
                if let location = location {
                    controller.location = location
                }
            }
            
            controller.mediaURL = linkTextField.text ?? ""
            controller.mapString = locationTextField.text ?? ""
        }
    }
    
    
    @IBAction func cenelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func setGecoding(_ geoCoding: Bool) {
        
        geoCoding ? activIndecator.startAnimating() : activIndecator.stopAnimating()
        
        locationTextField.isEnabled = !geoCoding
        linkTextField.isEnabled = !geoCoding
        findButton.isEnabled = !geoCoding
    }
}



