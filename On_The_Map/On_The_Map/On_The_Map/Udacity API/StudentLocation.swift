//
//  StudentLocation.swift
//  On_The_Map
//
//  Created by Marta on 28/04/2020.
//  Copyright © 2020 Marta. All rights reserved.
//

import Foundation
import MapKit

class StudentLocationResult: Codable {
    var results: [StudentLocation]?
}

struct StudentLocation: Codable {
    let createdAt: String
    let firstName: String
    let lastName: String
    let latitude: Double
    let longitude: Double
    let mapString: String
    let mediaURL: String
    let objectId: String
    let uniqueKey: String
    let updatedAt: String
}
