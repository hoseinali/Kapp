//
//  CarServiceTableViewCell.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/7/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit

protocol CarServiceTableViewCellDelegate {
    func deleteButtonpressed(cell: CarServiceTableViewCell)
}

class CarServiceTableViewCell: UITableViewCell {
    
    // Outlet
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var pricelLabel: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    
    var delegate: CarServiceTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // Action
    @IBAction func deleteButtonPressed(_ sender: RoundedButton) {
        delegate?.deleteButtonpressed(cell: self)
        
    }
    
    // Method
    func configureCell(title: String, price: Int) {
        productNameLabel.text = title
        pricelLabel.text = String(price)
    }
    

}
