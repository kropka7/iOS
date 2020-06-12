//
//  Login.swift
//  On_The_Map
//
//  Created by Marta on 05/06/2020.
//  Copyright © 2020 Marta. All rights reserved.
//

import Foundation

struct LoginResponse: Codable {
    let account: Account
    let session: Session
}

struct Account: Codable{
    let registered: Bool
    let key: String
}

struct Session: Codable{
    let id: String
    let expiration: String
}
