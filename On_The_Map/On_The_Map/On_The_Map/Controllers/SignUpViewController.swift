//
//  SignUpViewController.swift
//  On_The_Map
//
//  Created by Marta on 27/04/2020.
//  Copyright © 2020 Marta. All rights reserved.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emialTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordConfTextField: UITextField!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var signupButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        setElements()
        configureTextField()
        contifureTapGesture()
    }

    func setBackground() {
        view.backgroundColor = UIColor(red: 205 / 255, green: 239 / 255, blue: 255 / 255, alpha: 1.00)
    }

    func setElements() {
        // Hide the error label
        errorLabel.alpha = 0

        // style elements

        Utilities.styleTextField(nameTextField)
        Utilities.styleTextField(emialTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleTextField(passwordConfTextField)
        Utilities.styleButton(signupButton)
        Utilities.styleLabel(errorLabel)
    }

    @objc func handleTap() {
        print("handle tap was called")
        view.endEditing(true)
    }

    private func contifureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }

    private func configureTextField() {
        nameTextField.delegate = self
        emialTextField.delegate = self
        passwordTextField.delegate = self
        passwordConfTextField.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func signupTapped(_ sender: Any) {
    }
}
