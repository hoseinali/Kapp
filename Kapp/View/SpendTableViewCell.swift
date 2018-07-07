//
//  SpendTableViewCell.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/5/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit

class SpendTableViewCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var factorIdLabel: UILabel!
    @IBOutlet weak var bankNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var mountLabel: UILabel!
    @IBOutlet weak var resultBankLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(date:String, time:String, id:Int, bankName:String, status:String ,mount:String ,bankResponse:String) {
        dateLabel.text = date
        timeLabel.text = time
        factorIdLabel.text = String(id)
        bankNameLabel.text = bankName
        mountLabel.text = mount
        resultBankLabel.text = bankResponse
        switch status {
        case "0":self.statusLabel.text = "پرداخت نشده"
        case "1":self.statusLabel.text = "پرداخت موفق"
        case "2":self.statusLabel.text = "پرداخت ناموفق"
        case "3":self.statusLabel.text = "لغو شده"
        case "4":self.statusLabel.text = "رد شده"
        default:self.statusLabel.text = "پرداخت نشده"
        }
        }

    
}
