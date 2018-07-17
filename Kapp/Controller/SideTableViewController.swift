//
//  SideTableViewController.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/2/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit
import CDAlertView

class SideTableViewController: UITableViewController {
    
    // Outlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    
    let segues = [NO_SEGUE,MAIN_SEGUE,PROFILE_SEGUE,ORDER_DETAIL_LIST_SEGUE,SPEND_SEGUE,BAG_RESULT_SEGUE,CREDIT_SEGUE,CALL_US_SEGUE]
    private var previousIndex: NSIndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        if let index = previousIndex {
            tableView.deselectRow(at: index as IndexPath, animated: true)
        }
        let selected = indexPath.row
        if selected == 8 {
            exitProfile()
        } else {
            guard selected != 0 else { return }
            sideMenuController?.performSegue(withIdentifier: segues[selected], sender: nil)
            previousIndex = indexPath as NSIndexPath?
        }
    }
    
    // Objc
    @objc func updateMount() {
        BagService.instance.bagCash { (success) in
            if success {
                DispatchQueue.main.async {
                    self.moneyLabel.text = UserDataService.instance.cash.seperateByCama
                }
            }
        }
    }
    
    // Method
    func updateUI() {
        moneyLabel.text = UserDataService.instance.cash.seperateByCama
        nameLabel.text = PersonalInfromationService.instance.userInformation?.name
        NotificationCenter.default.addObserver(self, selector: #selector(updateMount), name: UPDATE_MOUNT_NOTIFI, object: nil)
    }
    
    private func exitProfile() {
        let alert = CDAlertView(title: "توجه !", message: "آیا میخواهید از پروفایل کاربری خود خارج شوید ؟", type: CDAlertViewType.notification)
        alert.titleFont = UIFont(name: YEKAN_WEB_FONT, size: 14)!
        alert.messageFont = UIFont(name: YEKAN_WEB_FONT, size: 13)!
        let done = CDAlertViewAction(title: "بله", font: UIFont(name: YEKAN_WEB_FONT, size: 12)!, textColor: UIColor.darkGray, backgroundColor: .white) { (action) -> Bool in
            UserDataService.instance.logoutProfile()
            self.presentRegisterViewController()
            return true
        }
        let cancel = CDAlertViewAction(title: "خیر", font: UIFont(name: YEKAN_WEB_FONT, size: 12)!, textColor: UIColor.darkGray, backgroundColor: .white, handler: nil)
        alert.add(action: done)
        alert.add(action: cancel)
        alert.show()
    }
    
    private func presentRegisterViewController() {
        if let registerViewController = storyboard?.instantiateViewController(withIdentifier: REGISTER_VC_ID) as? RegisterViewController {
            self.present(registerViewController, animated: true, completion: nil)
        }
    }
    

}
