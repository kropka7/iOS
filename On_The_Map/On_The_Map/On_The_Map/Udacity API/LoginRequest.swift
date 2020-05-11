//
//  Login.swift
//  On_The_Map
//
//  Created by Marta on 27/04/2020.
//  Copyright © 2020 Marta. All rights reserved.
//

import Foundation

struct LoginRequest: Codable {
    let udacity: UdacityUser
}

struct UdacityUser: Codable {
    let username: String
    let password: String
}

struct ErrorResponse: Codable {
    let status: Int
    let error: String
}

extension ErrorResponse: LocalizedError {
    var errorDescription: String? {
        return error
    }
}



