//
//  BagResultTableViewCell.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/5/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit

class BagResultTableViewCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var flagLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var mountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(id:Int, mount:Int, flag:String, desc:String, date:String ,time:String ,status:Int) {
        dateLabel.text = date
        idLabel.text = String(id)
        mountLabel.text = String(mount)
        flagLabel.text = flag
        descLabel.text = desc
        timeLabel.text = time
        switch flag {
        case "neg": self.flagLabel.text = "مصرفی"
        case "pos": self.flagLabel.text = "دریافتی"
        default: self.flagLabel.text = flag
        }
        switch status {
        case 1:self.statusLabel.text = "موفق"
        default: self.statusLabel.text = "ناموفق"
        }
        }

}
