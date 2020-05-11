//
//  UdacityAPI.swift
//  On_The_Map
//
//  Created by Marta on 27/04/2020.
//  Copyright © 2020 Marta. All rights reserved.
//

import Foundation
import UIKit

class UdacityAPI {
    struct Auth {
        static var accountKey = ""
        static var sessionId = ""
    }

    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"

        case login
        case getStudentLocations
        case getPublicUserData(userId: String)
        case postStudentLocations
        case putStudentLocations(objectId: String)

        var stringValue: String {
            switch self {
            case .login:
                return Endpoints.base + "/session"
            case .getStudentLocations:
                return Endpoints.base + "/StudentLocation"
            case let .getPublicUserData(userId):
                return Endpoints.base + "/users/\(userId)"
            case .postStudentLocations:
                return Endpoints.base + "/StudentLocation"
            case let .putStudentLocations(objectID):
                return Endpoints.base + "/StudentLocation/\(objectID)"
            }
        }

        var url: URL {
            return URL(string: stringValue)!
        }
    }

    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, rangeNeeded: Bool, completion: @escaping (ResponseType?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }

            let decoder = JSONDecoder()
            do {
                if !rangeNeeded {
                    let responseObject = try decoder.decode(ResponseType.self, from: data)
                    DispatchQueue.main.async {
                        completion(responseObject, nil)
                    }
                } else {
                    let range = 5 ..< data.count
                    let newData = data.subdata(in: range)

                    let decoder = JSONDecoder()
                    let responseObject = try! decoder.decode(ResponseType.self, from: newData)
                    DispatchQueue.main.async {
                        completion(responseObject, nil)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }

        task.resume()
    }

    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, rangeNeeded: Bool, completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(body)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                if !rangeNeeded {
                    let responseObject = try decoder.decode(ResponseType.self, from: data)
                    DispatchQueue.main.async {
                        completion(responseObject, nil)
                    }
                } else {
                    let range = 5 ..< data.count
                    let dataWithoutSecurityCheck = data.subdata(in: range)
                    let responseObject = try decoder.decode(ResponseType.self, from: dataWithoutSecurityCheck)
                    DispatchQueue.main.async {
                        completion(responseObject, nil)
                    }
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(ErrorResponse.self, from: data) as Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }

        task.resume()
    }

    class func taskForPUTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = try! JSONEncoder().encode(body)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(ErrorResponse.self, from: data) as Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }

        task.resume()
    }

   class func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
            let body = LoginRequest(udacity: UdacityUser (username: username, password: password))
            taskForPOSTRequest(url: Endpoints.login.url, responseType: LoginResponse.self, body: body, rangeNeeded: true) { response, error in
                if let response = response {
                    Auth.accountKey = response.account.key
                    Auth.sessionId  = response.session.id
                    completion(true, nil)
                } else {
                    completion(false, error)
                }
            }
        }

    class func logout(completion: @escaping (Bool, Error?) -> Void) {
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie?
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }

        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }

        let task = URLSession.shared.dataTask(with: request) { _, _, error in
            guard error == nil else {
                completion(false, error)
                return
            }

            Auth.accountKey = ""
            Auth.sessionId = ""
            completion(true, nil)
        }

        task.resume()
    }

    class func signup(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        let body = LoginRequest(udacity: UdacityUser(username: username, password: password))
        taskForPOSTRequest(url: Endpoints.login.url, responseType: LoginResponse.self, body: body, rangeNeeded: true) { response, error in
            if let response = response {
                Auth.accountKey = response.account.key
                Auth.sessionId = response.session.id
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }

    class func getStudentLocations(limit: Int? = nil, skip: Int? = nil, order: String? = "", uniqueKey: String? = "", completion: @escaping ([StudentLocation]?, Error?) -> Void) {
        let url = Endpoints.getStudentLocations.url
        taskForGETRequest(url: url, responseType: StudentLocationResult.self, rangeNeeded: false) { response, error in
          if response != nil {
            completion(response?.results, nil)
                return
            } else {
                completion([], error)
            }
        }
    }



    class func getPublicUserData(userId: String, completion: @escaping (StudentLocation?, Error?) -> Void) {
        let url = Endpoints.getPublicUserData(userId: userId).url

        taskForGETRequest(url: url, responseType: StudentLocation.self, rangeNeeded: true) { response, error in
            if response != nil {
                completion(response, nil)
                return
            } else {
                completion(nil, error)
            }
        }
    }

    class func postStudentLocation(student: StudentLocation, completion: @escaping (Bool, Error?) -> Void) {
        taskForPOSTRequest(url: Endpoints.postStudentLocations.url, responseType: StudentLocation.self, body: student, rangeNeeded: false) { response, error in
            if response != nil {
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }

    class func putStudentLocation(student: StudentLocation, completion: @escaping (Bool, Error?) -> Void) {
        let url = Endpoints.putStudentLocations(objectId: student.objectId).url

        taskForPUTRequest(url: url, responseType: StudentLocation.self, body: student) { response, error in
            if response != nil {
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
}
