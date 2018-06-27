//
//  CarServiceViewController.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/7/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit

class CarServiceViewController: UIViewController {
    
    var parrentDropButton = dropDownBtn()


    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //
    }
    
    // Objc
    
    // Method
    func updateUI() {
        self.navigationItem.title = "انتخاب سرویس"
        configureParrentButton()
    }
    
    func configureParrentButton() {
        //Configure the button
        parrentDropButton = dropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        parrentDropButton.setTitle("سرویس خود را انتخاب کنید", for: .normal)
        parrentDropButton.titleLabel?.font = UIFont(name: YEKAN_WEB_FONT, size: 19)
        parrentDropButton.translatesAutoresizingMaskIntoConstraints = false
        //Add Button to the View Controller
        self.view.addSubview(parrentDropButton)
        //button Constraints
        let top = NSLayoutConstraint(item: parrentDropButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 120)
        let centerX = NSLayoutConstraint(item: parrentDropButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0)
        view.addConstraints([top,centerX])
        let height = NSLayoutConstraint(item: parrentDropButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40)
        let width = NSLayoutConstraint(item: parrentDropButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 250)
        NSLayoutConstraint.activate([width,height])
        // Set the drop down menu's options
        parrentDropButton.dropView.dropDownOptions = ["روشویی", "روتوشویی", "موتورشویی", "واکس"]
    }
    
    
}
