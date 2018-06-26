//
//  CarChosenViewController.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/4/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit

class CarChosenViewController: UIViewController {
    
    // Outlet

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    // Action
    @IBAction func closeButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // Method
    func updateUI() {
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: YEKAN_WEB_FONT, size: 40)!], for: .normal)
    }
    
    
}
