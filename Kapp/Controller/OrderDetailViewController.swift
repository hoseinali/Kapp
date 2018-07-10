//
//  OrderDetailViewController.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/6/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit
import SideMenuController

class OrderDetailViewController: UIViewController, SideMenuControllerDelegate {

    // Outlet
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetechOrderList()
    }
    
    // Method
    func updateUI() {
        sideMenuController?.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 230
    }
    
    func sideMenuControllerDidHide(_ sideMenuController: SideMenuController) {
        print(#function)
    }
    
    func sideMenuControllerDidReveal(_ sideMenuController: SideMenuController) {
        print(#function)
    }
    
    func fetechOrderList() {
        startIndicatorAnimate()
        OrderService.instance.Orderlist { (success) in
            if success {
                self.stopIndicatorAnimate()
                self.tableView.reloadData()
            } else {
                self.stopIndicatorAnimate()
            }
        }
    }
    
    
}

extension OrderDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return OrderService.instance.Orderlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ORDER_DETAIL_CELL, for: indexPath) as! OrderDetailTableViewCell
        let order = OrderService.instance.Orderlists[indexPath.row]
        cell.configureCell(date: order.date, time: order.time, orderName: order.orderName, nameCopon: order.copon, pay_id: order.pay_id, mount: order.price, payMetod: order.pay_method, sendTime: order.send_time, status: order.status)
        
        return cell
    }
    
    
}
