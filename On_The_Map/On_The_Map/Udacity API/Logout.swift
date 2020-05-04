//
//  Logout.swift
//  On_The_Map
//
//  Created by Marta on 03/05/2020.
//  Copyright © 2020 Marta. All rights reserved.
//

import Foundation

struct Logout {
    let sessionId: String

    enum CodingKeys: String, CodingKey {
        case session  = "session_id"
    }
}
