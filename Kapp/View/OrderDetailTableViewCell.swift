//
//  OrderDetailTableViewCell.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/6/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit

class OrderDetailTableViewCell: UITableViewCell {

    //Outlet
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var orderNameLabel: UILabel!
    @IBOutlet weak var nameCoponLabel: UILabel!
    @IBOutlet weak var payIdLabel: UILabel!
    @IBOutlet weak var mountLabel: UILabel!
    @IBOutlet weak var payMetodLabel: UILabel!
    @IBOutlet weak var sendTimeLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(date:String, time:String, orderName:String, nameCopon:Int, pay_id:Int, mount:Int, payMetod:String, sendTimeLabel:String) {
        dateLabel.text = date
        timeLabel.text = time
        orderNameLabel.text = orderName
        nameCoponLabel.text = String(nameCopon)
        mountLabel.text = String(mount)
        payIdLabel.text = String(pay_id)
        
        
        
    }

}
