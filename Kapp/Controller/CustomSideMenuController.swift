//
//  ViewController.swift
//  Kapp
//
//  Created by hosein on 6/18/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import UIKit
import SideMenuController

class CustomSideMenuController: SideMenuController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //
    }
    
    // Method
    func updateUI() {
        performSegue(withIdentifier: MAIN_SEGUE, sender: nil)
        performSegue(withIdentifier: SIDE_SEGUE, sender: nil)
    }

    
}

