//
//  AuthenticationService.swift
//  Kapp
//
//  Created by hosein on 6/19/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AuthenticationService {
    
    static let instance = AuthenticationService()
    
    var phoneNumber = ""
    var isOldUser = false
    
    func loginGetCode(number: String, completion: @escaping COMPLETION_SUCCESS) {
        guard let url = URL.init(string: LOGIN_GET_CODE_URL) else {return}
        let parameters = ["mobile": "\(number)"]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = generateBoundary()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let dataBody = createDataBody(withParameters: parameters, boundary: boundary)
        request.httpBody = dataBody
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let _ = response {
                //
            }
            if let data = data {
                guard let jsonAny = try? JSONSerialization.jsonObject(with: data, options: []) else { completion(false); return }
                guard let json = jsonAny as? [String:Any] else { completion(false); return }
                guard let type = json["type"] as? String else { completion(false); return }
                if type == "success" {
                    self.isOldUser = true
                    self.phoneNumber = number
                    completion(true)
                } else {
                    completion(false)
                }
            } else {
                completion(false)
            }
        }
        task.resume()
    }

    func loginGetAccess(okCode: String, number: String, completion: @escaping COMPLETION_SUCCESS) {
        guard let url = URL.init(string: LOGIN_GET_ACCESS_URL) else { return }
        let parameters = ["mobile": "\(number)", "accesscode":"\(okCode)"]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = generateBoundary()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let dataBody = createDataBody(withParameters: parameters, boundary: boundary)
        request.httpBody = dataBody
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let _ = response {
                //
            }
            if let data = data {
                guard let jsonAny = try? JSONSerialization.jsonObject(with: data, options: []) else { completion(false); return }
                guard let json = jsonAny as? [String: Any] else { completion(false);return }
                guard let type = json["type"] as? String else { completion(false);return }
                if type == "success" {
                    guard let userData = json["data"] as? [String:Any] else { completion(false); return }
                    guard let uid = userData["uid"] as? Int else { completion(false); return }
                    guard let ssid = userData["ssid"] as? String else { completion(false); return }
                    UserDataService.instance.setUserData(uid: String(uid), ssid: ssid, isLogin: true, phoneNumber: number)
                    completion(true)
                } else {
                    completion(false)
                }
            } else {
                completion(false)
            }
        }
        task.resume()
    }

    func registerGetCode(number: String, refMobileNumber: String?, completion: @escaping COMPLETION_SUCCESS) {
        guard let url = URL.init(string: REGISTER_S1_URL) else { return }
        var parameters = ["mobile": "\(number)"]
        if let refMobileNumber = refMobileNumber {
            parameters.updateValue(refMobileNumber, forKey: "ref")
        }
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = generateBoundary()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type") // add header
        let dataBody = createDataBody(withParameters: parameters, boundary: boundary)
        request.httpBody = dataBody
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let _ = response {
                //
            }
            if let data = data {
                guard let jsonAny = try? JSONSerialization.jsonObject(with: data, options: []) else { completion(false); return }
                guard let json = jsonAny as? [String: Any] else { completion(false); return }
                guard let type = json["type"] as? String else { completion(false); return }
                guard let data = json["data"] as? [String:Any] else { completion(false); return }
                guard let _ = data["uid"] as? Int else { completion(false); return }
                guard let _ = data["mobile"] as? String else { completion(false); return }
                guard let _ = data["next"] as? Bool else { completion(false); return }
                if type == "success" {
                    self.phoneNumber = number
                    self.isOldUser = false
                    completion(true)
                } else {
                    completion(false)
                }
            } else {
                completion(false)
            }
        }
        task.resume()
    }
    
    func registerGetAccess(okCode: String, number: String, completion: @escaping COMPLETION_SUCCESS) {
        guard let url = URL.init(string: OKCODE_USER_URL + "\(number)") else { return }
        let parameters = ["okcode": "\(okCode)"]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = generateBoundary()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type") // add header
        let dataBody = createDataBody(withParameters: parameters, boundary: boundary)
        request.httpBody = dataBody
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let _ = response {
                //
            }
            if let data = data {
                guard let jsonAny = try? JSONSerialization.jsonObject(with: data, options: []) else { completion(false); return }
                guard let json = jsonAny as? [String: Any] else { completion(false); return }
                guard let type = json["type"] as? String else { completion(false); return }
                if type == "success" {
                    guard let userData = json["data"] as? [String:Any] else { completion(false); return }
                    guard let uid = userData["uid"] as? Int else { completion(false); return }
                    guard let ssid = userData["ssid"] as? String else { completion(false); return }
                    UserDataService.instance.setUserData(uid: String(uid), ssid: ssid, isLogin: true, phoneNumber: number)
                    completion(true)
                } else {
                    completion(false)
                }
            } else {
                completion(false)
            }
        }
        task.resume()
    }
    
    func reOkCode(number: String, completion: @escaping COMPLETION_SUCCESS) {
        guard let url = URL.init(string: RESEND_CODE_URL + "\(number)") else { return }
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: DEFAULT_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                guard let json = try? JSON.init(data: data) else { return }
                let type = json["type"].stringValue
                if type == "success" {
                    completion(true)
                } else {
                    completion(false)
                }
            } else {
                completion(false)
            }
        }
    }
    
    private func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    private func createDataBody(withParameters parameters: FORMDATA_PARAMETER?, boundary: String) -> Data {
        let lineBreak = "\r\n"
        var body = Data()
        if let parameters = parameters {
            for (key,value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value + lineBreak)")
            }
        }
        body.append("--\(boundary)--\(lineBreak)")
        return body
    }
    
    
}
