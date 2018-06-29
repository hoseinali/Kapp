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
        updateUI()
    }
    
    // Outlet
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var carTypeLabel: UILabel!
    
    // method
    func configureCell(carType: String, image: UIImage) {
        self.carTypeLabel.text = carType
        self.imageView.image = image
    }
    
    func updateUI() {
        self.layer.cornerRadius = 5.0
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 5.0
        self.layer.shadowColor = UIColor.black.cgColor
    }

    
}
