//
//  TableViewController.swift
//  On_The_Map
//
//  Created by Marta on 03/05/2020.
//  Copyright © 2020 Marta. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

        @IBAction func logoutTapped(_ sender: UIBarButtonItem) {
               UdacityAPI.logout { (success, error) in
                   if success {
                       DispatchQueue.main.async {
                           self.dismiss(animated: true, completion: nil)
                       }
                   }
               }
           }

    }



