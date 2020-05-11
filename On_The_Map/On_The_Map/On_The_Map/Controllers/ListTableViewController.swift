//
//  ListTableViewController.swift
//  On_The_Map
//
//  Created by Marta on 10/05/2020.
//  Copyright © 2020 Marta. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class ListTableViewController: UITableViewController {
    @IBOutlet var logoutButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        let limit = 100
        let order = "-updatedAt"

        UdacityAPI.getStudentLocations(limit: limit, order: order) { response, error in
            if let error = error {
                self.showMessage(message: error.localizedDescription, title: "Connection Error")
                return
            }

            StudentLocationModel.locationsRecent = response ?? [StudentLocation]()

            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PinList")
        let location = StudentLocationModel.locationsPast[indexPath.row]
        cell?.textLabel?.text = location.firstName
        cell?.detailTextLabel?.text = location.mediaURL
        return cell!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = StudentLocationModel.locationsPast[indexPath.row]

        let url = location.mediaURL
        if url.isValidURL {
            var validUrl = url

            if !(validUrl.hasPrefix("http://") || validUrl.hasPrefix("https://")) {
                validUrl = "https://" + validUrl
            }

            let app = UIApplication.shared
            app.open(URL(string: validUrl)!, options: [:], completionHandler: nil)

        } else {
            return
        }
    }

    func reloadData() {
        tableView?.reloadData()
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

//https://stackoverflow.com/a/55255521

extension URL {
    init?(withCheck string: String?) {
        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        guard
            let urlString = string,
            let url = URL(string: urlString),
            NSPredicate(format: "SELF MATCHES %@", argumentArray: [regEx]).evaluate(with: urlString),
            UIApplication.shared.canOpenURL(url)
        else {
            return nil
        }

        self = url
    }
}


extension String {
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
}


