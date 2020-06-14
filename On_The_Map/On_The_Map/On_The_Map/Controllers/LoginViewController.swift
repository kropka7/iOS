//
//  LoginViewController.swift
//  On_The_Map
//
//  Created by Marta on 27/04/2020.
//  Copyright © 2020 Marta. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var emialTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var signupButton: UIButton!

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
        Utilities.styleTextField(emialTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleButton(loginButton)
        Utilities.styleButton(signupButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureTextField()
        contifureTapGesture()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // show keyboard
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    private func contifureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func configureTextField() {
        emialTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func sigupTapped(_ sender: Any) {
        if let url =  URL(string: "https://auth.udacity.com/sign-up") {
            UIApplication.shared.open(url)
        }
    }


    
    @IBAction func loginTapped(_ sender: Any) {
        setLoggingIn(true)
        UdacityAPI.login(username: self.emialTextField.text ?? "", password: self.passwordTextField.text ?? "", completion: handleLoginResponse(success:error:isNetworkError:))
    }
    
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "On_The_Map" {
            
            emialTextField.text = ""
            emialTextField.resignFirstResponder()
            
            passwordTextField.text = ""
            passwordTextField.resignFirstResponder()
        }
    }

    func handleLoginResponse(success: Bool, error: Error?, isNetworkError: Bool) {
             setLoggingIn(false)
             if success {
                 self.performSegue(withIdentifier: "On_The_Map", sender: nil)
             }else{
                 if !isNetworkError{
                     self.showMessage(message: "Invalid username or password.", title: "Login error")
                 }else {
                     self.showMessage(message: error?.localizedDescription ?? "", title:"Login Failed")
                 }

             }
         }
    
    func setLoggingIn(_ loggingIn: Bool) {
        loggingIn ? activIndecator.startAnimating() : activIndecator.stopAnimating()
        loginButton.isEnabled = !loggingIn
        emialTextField.isEnabled = !loggingIn
        passwordTextField.isEnabled = !loggingIn
    }
    
}

extension UIViewController {
    func showMessage(message: String, title: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
