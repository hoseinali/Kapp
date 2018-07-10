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
    @IBOutlet weak var StatusOrderLable: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(date: String, time: String, orderName: String, nameCopon: Int, pay_id: Int, mount: Int, payMetod: Int, sendTime: String, status: String) {
        dateLabel.text = date
        timeLabel.text = time
        orderNameLabel.text = orderName
        nameCoponLabel.text = String(nameCopon)
        mountLabel.text = mount.seperateByCama
        payIdLabel.text = String(pay_id)
        sendTimeLabel.text = sendTime
        switch payMetod {
        case 1: payMetodLabel.text = "در محل"
        case 2: payMetodLabel.text = "اعتباری"
        case 3: payMetodLabel.text = "آنلاین"
        default: payMetodLabel.text = "نامعلوم"
        }
        switch status {
        case "0": StatusOrderLable.text = "ثبت اولیه"
        case "1": StatusOrderLable.text = "تایید سفارش"
        case "2": StatusOrderLable.text = "امور مالی"
        case "3": StatusOrderLable.text = "پردازش سفارش"
        case "4": StatusOrderLable.text = "در حال تامین"
        case "5": StatusOrderLable.text = "بسته بندی شده"
        case "6": StatusOrderLable.text = "ارسال شده"
        case "7": StatusOrderLable.text = "تحویل مشتری"
        case "8": StatusOrderLable.text = "برگشت مرسوله"
        case "9": StatusOrderLable.text = "مرجوع شده"
        case "10": StatusOrderLable.text = "رد / کنسل شده"
        default: StatusOrderLable.text = "ثبت اولیه"
        }
    }

}
