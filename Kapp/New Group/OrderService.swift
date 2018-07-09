//
//  OrderService.swift
//  Kapp
//
//  Created by hosein on 7/6/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class OrderService {
    
    static let instance = OrderService()
    var Orderlists = [Order]()
    
    func Orderlist (completion: @escaping COMPLETION_SUCCESS) {
        let uid = UserDataService.instance.uid
        let ssid = UserDataService.instance.ssid
        let url = ORDER_LIST_URL + "&uid=\(uid)&ssid=\(ssid)"
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: DEFAULT_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard  let data = response.data else { completion(false); return}
                guard let json = try? JSON.init(data: data) else { completion(false); return}
                let _ = json["type"].stringValue
                guard let items = json["data"].array else { completion(false); return }
                let disPathGroup = DispatchGroup()
                for item in items {
                    let cart = item["cart"].stringValue
                    let send_time = item["send-time"].stringValue
                    let send_day = item["send-day"].intValue
                    let copon = item["copon"].intValue
                    let price = item["price"].intValue
                    let pay_method = item["pay-method"].intValue
                    let pay_id = item["pay-id"].intValue
                    let uid = item["uid"].intValue
                    let address = item["address"].stringValue
                    let formatted_address = item["formatted_address"].stringValue
                    let lat = item["lat"].stringValue
                    let lng = item["lng"].stringValue
                    let comment = item["comment"].stringValue
                    let upm = item["upm"].stringValue
                    let date = item["date"].stringValue
                    let time = item["time"].stringValue
                    let status = item["status"].stringValue
                    disPathGroup.enter()
                    self.orderListName(cart: cart, completion: { (success, orderName) in
                        if success {
                            let order = Order(orderName: orderName!, cart: cart, send_time: send_time, send_day: send_day, copon: copon, price: price, pay_method: pay_method, pay_id: pay_id, uid: uid, address: address, formatted_address: formatted_address, lat: lat, lng: lng, comment: comment, upm: upm, date: date, time: time, status: status)
                            self.Orderlists.append(order)
                            disPathGroup.leave()
                        } else {
                            disPathGroup.leave()
                        }
                    })
                }
                disPathGroup.notify(queue: .main, execute: {
                    completion(true)
                })
            } else {
                completion(false)
            }
        }
    }
    
    func orderListName(cart: String, completion: @escaping (_ success: Bool, _ orderName: String?) -> Void) {
        let uid = UserDataService.instance.uid
        let ssid = UserDataService.instance.ssid
        guard let url = URL.init(string: ORDER_LIST_URL + "&uid=\(uid)&ssid\(ssid)") else {return}
        let parameters:FORMDATA_PARAMETER = ["cart":"\(cart)"]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = generateBoundary()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let dataBody = createDataBody(withParameters: parameters, media: nil, boundary: boundary)
        request.httpBody = dataBody
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let _ = response {
                //
            }
            if let data = data {
                guard let jsonAny = try? JSONSerialization.jsonObject(with: data, options: []) else { completion(false,nil) ; return }
                guard let json = jsonAny as? [String: Any] else { completion(false,nil) ; return }
                guard let type = json["type"] as? String else { completion(false,nil) ; return }
                guard let items = json["data"] as? [String] else { completion(false,nil) ; return }
                var massage = ""
                for item in items {
                    massage += ", \(item)"
                }
                completion(true,massage)
                if type == "sucess" {
                    completion(true,massage)
                } else {
                    completion(false,nil)
                }
            }
            else {
                completion(false,nil)
            }
        }
        task.resume()
    }

    func CoponCheck(copon:String, completion: @escaping COMPLETION_SUCCESS) {
        let uid = UserDataService.instance.uid
        let ssid = UserDataService.instance.ssid
        guard let url = URL.init(string: COPON_CHECK_URL + "&uid=\(uid)&ssid=\(ssid)") else { return }
        let parameters: FORMDATA_PARAMETER = ["copon":"\(copon)"]
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        let boundary = generateBoundary()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let dataBody = createDataBody(withParameters: parameters, media: nil, boundary: boundary)
        request.httpBody = dataBody
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let _ = response {
                //
            }
            if let data = data {
                guard let jsonAny = try? JSONSerialization.jsonObject(with: data, options: []) else { completion(false) ; return }
                guard let json = jsonAny as? [String:Any] else { completion(false) ; return }
                guard let data = json["data"] as? [String:Any] else { completion(false) ; return }
                let title = data["title"] as? String
                let price = data["price"] as? String
                let copon_id = data["copon-id"] as? Int
                completion(true)
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
