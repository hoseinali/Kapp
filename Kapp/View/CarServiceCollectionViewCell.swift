//
//  CarServiceCollectionViewCell.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/7/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit

class CarServiceCollectionViewCell: UICollectionViewCell {
    
    // Outlet
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var pricelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }
    
    // Method
    func configureCell(image: UIImage, productName: String, price: String) {
        self.imageView.image = image
        self.productNameLabel.text = productName
        self.pricelLabel.text = price
    }
    
    func updateUI() {
        self.layer.cornerRadius = 5.0
    }
    
}
