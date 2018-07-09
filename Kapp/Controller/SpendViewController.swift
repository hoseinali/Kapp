//
//  BagViewController.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/2/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit
import SideMenuController

class SpendViewController: UIViewController, SideMenuControllerDelegate {
    
    // Outlet
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetechBagResults()
    }

    // Method
    func sideMenuControllerDidHide(_ sideMenuController: SideMenuController) {
        print(#function)
    }
    
    func sideMenuControllerDidReveal(_ sideMenuController: SideMenuController) {
        print(#function)
    }

    func updateUI() {
        sideMenuController?.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
    }
    func fetechBagResults() {
        startIndicatorAnimate()
        BagService.instance.payList { (success) in
            if success {
                self.stopIndicatorAnimate()
                self.tableView.reloadData()
            } else {
                self.stopIndicatorAnimate()
            }
        }
    }
    
    
}

extension SpendViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return BagService.instance.bagSpends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SPEND_CELL, for: indexPath) as! SpendTableViewCell
        let spendResult = BagService.instance.bagSpends[indexPath.row]
        cell.configureCell(date: spendResult.date, time: spendResult.time, id: spendResult.id, bankName: spendResult.bank_name, status: spendResult.status, mount: spendResult.mount, bankResponse: spendResult.bank_response)
        
        return cell
    }
    
    
}
