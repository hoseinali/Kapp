//
//  CarServiceViewController.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/7/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit

class CarServiceViewController: UIViewController {
    
    // Outlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var parrentDropButton = dropDownBtn()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //
    }
    
    // Objc
    
    // Actions
    @IBAction func agreeButtonPressed(_ sender: RoundedButton) {
        performSegue(withIdentifier: TIME_SEGUE, sender: sender)
    }
    
    // Method
    func updateUI() {
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: YEKAN_WEB_FONT, size: 40)!], for: .normal)
        let backButton = UIBarButtonItem(title: "بازگشت", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        backButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: YEKAN_WEB_FONT, size: 16)!], for: .normal)
        navigationItem.backBarButtonItem = backButton
        // Apply blurring effect
        backgroundImageView.image = UIImage(named: "blureImage")
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = backgroundImageView.bounds
        backgroundImageView.addSubview(blurEffectView)
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.dataSource = self
        tableView.delegate = self
        self.navigationItem.title = "انتخاب سرویس"
        configureParrentButton()
    }
    
    func configureParrentButton() {
        //Configure the button
        parrentDropButton = dropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        parrentDropButton.setTitle("برای انتخاب سرویس اینجا را فشار دهید", for: .normal)
        parrentDropButton.titleLabel?.font = UIFont(name: YEKAN_WEB_FONT, size: 19)
        parrentDropButton.translatesAutoresizingMaskIntoConstraints = false
        //Add Button to the View Controller
        self.scrollView.addSubview(parrentDropButton)
        //self.scrollView.bringSubview(toFront: parrentDropButton)
        //button Constraints
        let top = NSLayoutConstraint(item: parrentDropButton, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1.0, constant: 0)
        let centerX = NSLayoutConstraint(item: parrentDropButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0)
        view.addConstraints([centerX])
        self.scrollView.addConstraint(top)
        let height = NSLayoutConstraint(item: parrentDropButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50)
        let width = NSLayoutConstraint(item: parrentDropButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: UIScreen.main.bounds.width)
        NSLayoutConstraint.activate([width,height])
        // Set the drop down menu's options
        parrentDropButton.dropView.dropDownOptions = ["روشویی", "روتوشویی", "موتورشویی", "واکس"]
    }
    
    
}


extension CarServiceViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CAR_SERVICE_COLLECTION_CELL, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0.0
        UIView.animate(withDuration: 2.0, delay: 0.0, options: .allowUserInteraction, animations: {
            cell.alpha = 1.0
        }, completion: nil)
    }
    
    
}

extension CarServiceViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CAR_SERVICE_TABLE_CELL, for: indexPath) as! CarServiceTableViewCell
        
        return  cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}






