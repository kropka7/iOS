//
//  Student.swift
//  On_The_Map
//
//  Created by Marta on 08/06/2020.
//  Copyright © 2020 Marta. All rights reserved.
//
import Foundation
//struct Result: Codable{
//    let results: [Student]
//}

struct StudentData: Codable {

    let objectId: String?
    let uniqueKey: String?
    let firstName: String?
    let lastName: String?
    let mapString: String?
    let mediaURL: String?
    let latitude: Double?
    let longitude: Double?
    let createdAt: String
    let updatedAt: String
}
