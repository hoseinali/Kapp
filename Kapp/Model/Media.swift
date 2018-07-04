//
//  Media.swift
//  Kapp
//
//  Created by hosein on 6/20/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import Foundation
import UIKit

struct Media: Codable {
    
    static public var archiveURL: URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent("media_data").appendingPathExtension("jpg")
    }
    
    let key: String
    let filename: String
    let data: Data
    let mimeType: String
    
    init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        self.mimeType = "image/jpeg"
        self.filename = "\(arc4random()).jpg"
        guard let data = UIImageJPEGRepresentation(image, 0.7) else { return nil }
        // guard let data = UIImagePNGRepresentation(image) else { return nil }
        self.data = data
    }
    
    static func encode(save picture: Media, directory dir: URL) {
        let propertyListEncoder = PropertyListEncoder()
        if let encodedProduct = try? propertyListEncoder.encode(picture) {
            try? encodedProduct.write(to: dir, options: .noFileProtection)
        }
    }
    
    static func decode(directory dir: URL) -> Media? {
        let propertyListDecoder = PropertyListDecoder()
        if let retrievedProductData = try? Data.init(contentsOf: dir), let decodedProduct = try? propertyListDecoder.decode(Media.self, from: retrievedProductData) {
            return decodedProduct
        }
        return nil
    }
    
    func image() -> UIImage? {
        
        return UIImage(data: self.data)
    }
    
}
