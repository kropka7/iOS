//
//  StudentLocationModel.swift
//  On_The_Map
//
//  Created by Marta on 10/05/2020.
//  Copyright © 2020 Marta. All rights reserved.
//


import Foundation

class StudentLocationModel {
    static var locationsPast         = [StudentLocation]()
    static var locationsRecent   = [StudentLocation]()

    class func clearAll() {
       locationsPast         = [StudentLocation]()
       locationsRecent   = [StudentLocation]()
    }
}
