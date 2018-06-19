//
//  PersonalInformationService.swift
//  Kapp
//
//  Created by hosein on 6/20/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import Foundation


import Foundation
import Alamofire
import SwiftyJSON

class PersonalInfromationService {
    
    static let instance = PersonalInfromationService()
    
    var userInformation: UserInformation?
    
    // 6
    func userInformation(completion: @escaping COMPLETION_SUCCESS) {
        let uid = UserDataService.instance.uid
        let ssid = UserDataService.instance.ssid
        let url = USER_INFO_URL + "&uid=\(uid)&ssid=\(ssid)"
        print(url)
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: DEFAULT_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                guard let json = try? JSON.init(data: data) else { completion(false) ; return }
                let type = json["type"].stringValue
                if type == "sucess" {
                    let name = json["name"].stringValue
                    let picture = json["picture"].stringValue
                    let lastdate = json["lastdate"].stringValue
                    let date = json["date"].stringValue
                    let birth = json["birth"].stringValue
                    let city = json["city"].stringValue
                    let state = json["state"].stringValue
                    let melli = json["melli"].stringValue
                    let zippostal = json["zippostal"].stringValue
                    let address = json["address"].stringValue
                    let bankCard = json["bank-card"].stringValue
                    let bankName = json["bank-name"].stringValue
                    let bankId = json["bank-id"].stringValue
                    let userInformation = UserInformation.init(name: name, picture: picture, lastdate: lastdate, date: date, birth: birth, melli: melli, city: city, state: state, zippostal: zippostal, address: address, bankCard: bankCard, bankName:bankName , bankId: bankId)
                    self.userInformation = userInformation
                    completion(true)
                } else {
                completion(false)
                }
            }
        }
    }
    
    // 7
    func updateUserInformation(withParameters parameters: FORMDATA_PARAMETER?, completion: @escaping COMPLETION_SUCCESS) {
        let uid = UserDataService.instance.uid
        let ssid = UserDataService.instance.ssid
        guard let url = URL.init(string: UPDATE_USER_INFO_URL + "&uid=\(uid)&ssid=\(ssid)") else { return }
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = generateBoundary()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type") // add header
        let dataBody = createDataBody(withParameters: parameters, media: nil, boundary: boundary)
        request.httpBody = dataBody
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let _ = response {
                //
            }
            if let data = data {
                guard let jsonAny = try? JSONSerialization.jsonObject(with: data, options: []) else { return }
                guard let json = jsonAny as? [String: Any] else { completion(false) ; return }
                guard let type = json["type"] as? String else { completion(false) ; return }
                guard let message = json["massage"] as? String else { return }
                if type == "success" {
                    //
                    completion(true)
                } else if message == "USER_REG1_MOBILEIS" {
                    //
                    completion(false)
                } else {
                    completion(false)
                }
            } else {
                completion(false)
            }
        }
        task.resume()
    }
  
    private func generateBoundary() -> String {
        
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    private func createDataBody(withParameters parameters: FORMDATA_PARAMETER?, media: [Media]?, boundary: String) -> Data {
        let lineBreak = "\r\n"
        var body = Data()
        if let parameters = parameters {
            for (key,value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value + lineBreak)")
            }
        }
        if let media = media {
            for photo in media {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)")
                body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
                body.append(photo.data)
                body.append(lineBreak)
                
            }
        }
        body.append("--\(boundary)--\(lineBreak)")
        
        return body
    }
    
}
