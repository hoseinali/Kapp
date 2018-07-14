//
//  ProductService.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/23/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ProductService {
    
    static let instance = ProductService()
    
    var categorys = [Category]()
    var products = [Product]()
    
    func fetchCategory(type: Int, completion: @escaping COMPLETION_SUCCESS) {
        let uid = UserDataService.instance.uid
        let ssid = UserDataService.instance.ssid
        let url = PRODUCT_URL + "&uid=\(uid)&ssid=\(ssid)"
        self.categorys.removeAll()
        self.products.removeAll()
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: DEFAULT_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let i = response.data else { completion(false) ; return }
                guard let json = try? JSON.init(data: i) else { completion(false) ; return }
                guard let data = json["data"].dictionary else { completion(false) ; return }
                guard let categorys = data["cat"]!.array else { completion(false) ; return }
                for cat in categorys {
                    let id = cat["id"].intValue
                    let title = cat["title"].stringValue
                    let status = cat["status"].intValue
                    let category = Category(title: title, id: id, status: status)
                    self.categorys.append(category)
                }
                guard let products = data["products"]!.array else { completion(false) ; return }
                //
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func findCatId(name: String) -> Int {
        for cat in categorys {
            if name == cat.title {
                return cat.id
            }
        }
        return 0
    }
    
    func productForCategory(cat: Int) -> [Product] {
        var values = [Product]()
        for product in products {
            let product_cat = product.cat
            if product_cat == cat {
                values.append(product)
            }
        }
        
        return values
    }
    
    
}
