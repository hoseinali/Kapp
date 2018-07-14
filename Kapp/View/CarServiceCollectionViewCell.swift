//
//  CarServiceCollectionViewCell.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/7/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit

protocol carServiceCollectionViewCellDelegate {
    func addButtonPressed(cell: CarServiceCollectionViewCell)
}

class CarServiceCollectionViewCell: UICollectionViewCell {
    
    // Outlet
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var pricelLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    var delegate: carServiceCollectionViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }
    
    // Action
    @IBAction func addButtonPressed(_ sender: RoundedButton) {
        delegate?.addButtonPressed(cell: self)
    }

    // Method
    func configureCell(productName: String, price: Int) {
        self.productNameLabel.text = productName
        self.pricelLabel.text = price.seperateByCama
    }
    
    func updateUI() {
        self.layer.cornerRadius = 5.0
    }
    
}
