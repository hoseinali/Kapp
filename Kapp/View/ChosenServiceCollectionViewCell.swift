//
//  ChosenServiceCollectionViewCell.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/7/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit

class ChosenServiceCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5.0
    }
    
    // Outlet
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var carTypeLabel: UILabel!
    
    // method
    func configureCell(carType: String, image: UIImage) {
        self.carTypeLabel.text = carType
        self.imageView.image = image
    }
    
    
}
