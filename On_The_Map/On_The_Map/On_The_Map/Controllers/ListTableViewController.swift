//
//  ListTableViewController.swift
//  On_The_Map
//
//  Created by Marta on 05/06/2020.
//  Copyright © 2020 Marta. All rights reserved.
//

import Foundation
import UIKit

class ListTableViewController: UITableViewController {

    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var refreshButton: UIBarButtonItem!

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return InformationList.studentInformationList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        let cell = tableView.dequeueReusableCell(withIdentifier: "PinList")!
        let location = InformationList.studentInformationList[(indexPath as NSIndexPath).row]

        // Set the image and the label
        cell.textLabel!.text = location.firstName + " " + location.lastName
        cell.detailTextLabel!.text = location.mediaURL
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let app = UIApplication.shared
        if let toOpen = tableView.cellForRow(at: indexPath)?.detailTextLabel?.text {
            app.open(URL(string: toOpen)!, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        UdacityAPI.logout() {_ in 
            DispatchQueue.main.async {
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
}
















