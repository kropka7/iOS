//
//  loginRequest.swift
//  MemeMe_2.0
//
//  Created by Marta on 27/04/2020.
//  Copyright © 2020 udacity.com. All rights reserved.
//

import Foundation

struct User: Codable {
    let username: String
    let password: String
}

struct loginRequest {
    let udacityUser = User.self
}
