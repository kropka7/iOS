//
//  UdacityAPI.swift
//  On_The_Map
//
//  Created by Marta on 05/06/2020.
//  Copyright © 2020 Marta. All rights reserved.
//

import Foundation

class UdacityAPI {


    static var objectId: String?
    static var firstName: String?
    static var lastName: String?


    struct Auth{
  static var firstName = ""
        static var lastName = ""
        static var key = ""
        static var sessionId = ""
        static var createdAtDate = ""
        static var objectId = ""
    }


    enum Endpoints {
        static let udacity = "https://onthemap-api.udacity.com/v1"

        case login
        case getStudentInformation
        case postLocation
        case putLocation
        case getUsername(String)
        var stringValue: String {
            switch self {
            case .login:
                return Endpoints.udacity + "/session"

            case .getStudentInformation:
                return Endpoints.udacity + "/StudentLocation" + "?limit=100&order=-updatedAt"

            case .postLocation:
                return Endpoints.udacity + "/StudentLocation"

            case .putLocation:
                return Endpoints.udacity + "/StudentLocation" + "/\(String(describing: UdacityAPI.objectId!))"

                case .getUsername(_):
                return Endpoints.udacity + "/users" + "/\(Auth.key)"
            }
        }

        var url: URL {
            return URL(string: stringValue)!
        }
    }


    class func taskForPostAndPutRequest<ResponseType: Decodable>(body: String, method: String, url: URLRequest, responseType: ResponseType.Type,completion: @escaping (ResponseType?, Error?, Bool) -> Void){
        var request = url
        request.httpMethod = method
        if responseType == LoginResponse.self{
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody =  body.data(using: .utf8)

        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                DispatchQueue.main.async {
                    completion(nil, error, true)
                }
                return
            }

            let decoder = JSONDecoder()
            var newData = data
            if responseType == LoginResponse.self{
                let range = (5..<data!.count)
                newData = data?.subdata(in: range) /* subset response data! */
            }
            do {

                let responseObject = try decoder.decode(ResponseType.self, from: newData!)
                DispatchQueue.main.async {
                    completion(responseObject, nil, false)
                }

            }catch{
                DispatchQueue.main.async {
                    completion(nil, error, false)
                }
            }
        }
        task.resume()
    }

    class func taskForGetRequest<ResponseType: Decodable>(url: URLRequest, responseType: ResponseType.Type,completion: @escaping (ResponseType?, Error?) -> Void){
        let request = url
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                DispatchQueue.main.async {
                    completion(nil,error)
                }
            }

            let decoder = JSONDecoder()
            var newData = data
            if responseType == User.self{
                let range = (5..<data!.count)
                newData = data?.subdata(in: range) /* subset response data! */
            }
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: newData!)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }

            }catch{
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()

    }

    //MARK: Requests
    class func login(username: String, password: String, completion: @escaping(Bool, Error?, Bool)->Void){
        let requestURL = URLRequest(url: Endpoints.login.url)
        let body = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}"

        taskForPostAndPutRequest(body: body, method: "POST", url: requestURL, responseType: LoginResponse.self) { (response, error, isNetworkError) in
            if let response = response {
                Auth.key = response.account.key
                Auth.sessionId = response.session.id
                completion(true,nil, isNetworkError)
            }else{
                completion(false, error, isNetworkError)
            }
        }

    }

    class func postLocation(mapString: String, mediaURL:String, longitude: Double, latitude: Double,completion: @escaping (StudentData?, Error?) -> () ) {
      var request = URLRequest(url: Endpoints.postLocation.url)
         request.httpMethod = "POST"
       let body = StudentData(objectId: Auth.sessionId, uniqueKey: Auth.key, firstName: Auth.firstName, lastName: Auth.lastName, mapString: mapString, mediaURL: mediaURL, latitude: latitude, longitude: longitude, createdAt: Auth.createdAtDate, updatedAt: getCurrentDate())
        request.httpBody = try! JSONEncoder().encode(body)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                    return
                }
                do {
                    let responseObj = try JSONDecoder().decode(PostLocationResponse.self, from: data)
                    Auth.objectId = responseObj.objectId
                    print(Auth.objectId)
                    DispatchQueue.main.async {
                        print(Auth.objectId)
                        completion(body,nil)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                    print("Faild to post student", error.localizedDescription)
                }

            }
            task.resume()

    }

    class func putLocation(mapString: String, mediaURL:String, longitude: Double, latitude: Double,completion: @escaping (StudentInformation?, Error?) -> () ) {
        var request = URLRequest(url: Endpoints.putLocation.url)

        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = StudentInformation(objectId: Auth.sessionId, uniqueKey: Auth.key, firstName: Auth.firstName, lastName: Auth.lastName, mapString: mapString, mediaURL: mediaURL, latitude: latitude, longitude: longitude, createdAt: Auth.createdAtDate, updatedAt: getCurrentDate())

        request.httpBody = try! JSONEncoder().encode(body)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            do {
                let responseObj = try JSONDecoder().decode(PostLocationResponse.self, from: data)
                Auth.objectId = responseObj.objectId
                print(Auth.objectId)
                DispatchQueue.main.async {
                    print(Auth.objectId)
                    completion(body, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                print("Faild to post student", error.localizedDescription)
            }

        }
        task.resume()

    }

    class func getStudentLocation(completion: @escaping([StudentInformation], Error?)->Void ){
        let requestURL = URLRequest(url: Endpoints.getStudentInformation.url)
        taskForGetRequest(url: requestURL, responseType: Result.self) { (response, error) in
            if let response = response {
                completion(response.results, nil)
            } else {
                completion([],error)
            }
        }

    }
    
    class func getUsername(completion: @escaping (Bool, Error?) -> () ) {

        let task = URLSession.shared.dataTask(with: Endpoints.getUsername(Auth.key).url) { data, response, error in
            guard let data = data else {
                completion(false, error)
                return
            }
            let newData = data.subdata(in: 5..<data.count) /* subset response data! */
            do {
                let responseObj = try JSONDecoder().decode(UserInfo.self, from: newData)
                Auth.firstName = responseObj.firstName
                Auth.lastName = responseObj.lastName
                DispatchQueue.main.async {
                    completion(true, nil)
                }
            } catch {
                print("cannot get student name", error.localizedDescription)
                DispatchQueue.main.async {
                    completion(false, nil)
                }
            }

        }
        task.resume()
    }

    class func logout(completion: @escaping(Error?)->Void){
        var request = URLRequest(url: Endpoints.login.url)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil

        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" {
                xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }

        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(error)
            }else {
                Auth.key = ""
                Auth.sessionId = ""
                UdacityAPI.objectId = ""
                completion(nil)
            }

        }
        task.resume()
    }

    class func getCurrentDate()-> String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateStyle = .full
           dateFormatter.timeStyle = .full
           return dateFormatter.string(from: Date())
       }
}
