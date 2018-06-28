//
//  BagService.swift
//  Kapp
//
//  Created by hosein on 6/27/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//
import UIKit
import Alamofire
import SwiftyJSON

class BagService {
    
    static let instance = BagService()
    
    var bagResults = [PayList]()
    var bagSpends = [BagSpend]()
    
    func bagResult(completion: @escaping COMPLETION_SUCCESS) {
        let uid = UserDataService.instance.uid
        let ssid = UserDataService.instance.ssid
        let url = CASH_LOG_URL + "&uid=\(uid)&ssid=\(ssid)"
        bagResults.removeAll()
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: DEFAULT_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let dataJson = response.data else { completion(false) ; return }
                guard let json = try? JSON.init(data: dataJson) else { completion(false) ; return }
                let type = json["type"].stringValue
                let massage = json["massage"].stringValue
                guard let data = json["data"].dictionary else { completion(false) ;return }
                let total = data["total"]!.intValue
                let pagecount = data["pagecount"]!.intValue
                guard let items = json["result"].array else { completion(false) ;return }
                
                    for item in items {
                    let id = item["id"].intValue
                    let mount = item["mount"].intValue
                    let flag = item["flag"].stringValue
                    let description = item["desc"].stringValue
                    let uid = item["uid"].intValue
                    let date = item["date"].stringValue
                    let time = item["time"].stringValue
                    let status = item["status"].intValue
                        
                        let bagResult = PayList(id: id, mount: mount, flag: flag, massage: massage, description: description, uid: uid,  date: date, time: time, status: status, total: total, pagecount: pagecount)
                    self.bagResults.append(bagResult)
                }
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
    
    func payList(completion: @escaping COMPLETION_SUCCESS) {
        let uid = UserDataService.instance.uid
        let ssid = UserDataService.instance.ssid
        let url = PAY_LIST_URL + "&uid=\(uid)&ssid=\(ssid)"
        bagSpends.removeAll()
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: DEFAULT_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { completion(false) ; return }
                guard let json = try? JSON.init(data: data) else { completion(false) ; return }
                let type = json["type"].stringValue
                print("dfff")
                guard let items = json["data"].array else { completion(false) ; return }
                print("dfff")

                for item in items {
                    let id = item["id"].intValue
                    let uid = item["id"].intValue
                    let mount = item["mount"].stringValue
                    let bank_name = item["bank-name"].stringValue
                    let bank_response = item["bank-response"].stringValue
                    let description = item["desc"].stringValue
                    let date = item["date"].stringValue
                    print(date)
                    let time = item["time"].stringValue
                    let status = item["status"].stringValue
                    let bagSpend = BagSpend(id: id, uid: uid, mount: mount, bank_name: bank_name, bank_response: bank_response, description: description, date: date, time: time, status: status)
                    self.bagSpends.append(bagSpend)
                }
                if type == "success" {
                    completion(true)
                } else {
                    completion(false)
                }
            }
            completion(false)
        }
    }
    
    func bagCash(completion: @escaping (_ success: Bool) -> Void) {
        let uid = UserDataService.instance.uid
        let ssid = UserDataService.instance.ssid
        let url = CASH_GET_URL + "&uid=\(uid)&ssid=\(ssid)"
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: DEFAULT_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { completion(false) ; return }
                guard let json = try? JSON.init(data: data) else {completion(false) ; return }
                let type = json["type"].stringValue
                guard type == "success" else { completion(false) ; return }
                guard let money = json["data"].int else { completion(false) ; return }
                UserDataService.instance.cash = money
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func bagPay(completion: @escaping COMPLETION_SUCCESS) {
        let uid = UserDataService.instance.uid
        let ssid = UserDataService.instance.ssid
       let mount = UserDataService.instance.mount
        
        guard let url = URL.init(string: BANK_CASH_URL + "&uid=\(uid)&ssid=\(ssid)&mount=\(mount)") else { completion(false) ; return }
        DispatchQueue.main.async {
            print(url.path)
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
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

