//
//  BagResultViewController.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/3/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit
import SideMenuController

class BagResultViewController: UIViewController, SideMenuControllerDelegate {
    
    // Outlet
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetechBagResults()
    }

    // Method
    func updateUI() {
        sideMenuController?.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func sideMenuControllerDidHide(_ sideMenuController: SideMenuController) {
        print(#function)
    }
    
    func sideMenuControllerDidReveal(_ sideMenuController: SideMenuController) {
        print(#function)
    }
    
    func fetechBagResults() {
        startIndicatorAnimate()
        BagService.instance.bagResult { (success) in
            if success {
                self.stopIndicatorAnimate()
                self.tableView.reloadData()
            } else {
                self.stopIndicatorAnimate()
            }
        }
    }



}

extension BagResultViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return BagService.instance.bagResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BAG_RESULT_CELL, for: indexPath) as! BagResultTableViewCell
        let bagResult = BagService.instance.bagResults[indexPath.row]
        cell.configureCell(id: bagResult.id, mount: bagResult.mount, flag: bagResult.flag, desc:
        bagResult.description, date: bagResult.date, time: bagResult.time, status: bagResult.status)
        
        return cell
    }
    
    
}
