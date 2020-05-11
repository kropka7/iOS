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
    @IBOutlet var errorLabel: UILabel!

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
       // errorLabel.alpha = 0

        // style elements

        Utilities.styleTextField(emialTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleButton(loginButton)
        Utilities.styleButton(signupButton)
        Utilities.styleLabel(errorLabel)
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
        if let url = URL(string: "https://auth.udacity.com/sign-up") {
            UIApplication.shared.open(url, options: [:])
        }
    }

    @IBAction func loginTapped(_ sender: Any) {
        setLoggingIn(true)
        UdacityAPI.login(username: emialTextField.text ?? "", password: passwordTextField.text ?? "", completion: handleLoginResponse(success:error:))
    }

    func handleLoginResponse(success: Bool, error: Error?) {
        setLoggingIn(false)
        if success {
            performSegue(withIdentifier: "On_The_Map", sender: nil)
        } else {
            showMessage(message: error!.localizedDescription, title: "Login Failed")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "On The Map" {
            emialTextField.text = ""
            emialTextField.resignFirstResponder()

            passwordTextField.text = ""
            passwordTextField.resignFirstResponder()
        }
    }

    func setLoggingIn(_ loggingIn: Bool) {
        loginButton.isEnabled = !loggingIn
        emialTextField.isEnabled = !loggingIn
        passwordTextField.isEnabled = !loggingIn
    }
}

extension UIViewController {
    func showMessage(message: String, title: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}


