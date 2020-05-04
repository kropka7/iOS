//
//  LoginResponse.swift
//  On_The_Map
//
//  Created by Marta on 30/04/2020.
//  Copyright © 2020 Marta. All rights reserved.
//

import Foundation


struct LoginResponse: Codable {
    let account: UdacityUserAccount
    let session: UdacityUserSession
}

struct UdacityUserAccount: Codable {
    let registered: Bool
    let key: String
}

struct UdacityUserSession: Codable {
    let id: String
    let expiration: String
}

