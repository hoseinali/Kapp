//
//  CarServiceViewController.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/7/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit

class CarServiceViewController: UIViewController, dropDownProtocol, carServiceCollectionViewCellDelegate, CarServiceTableViewCellDelegate {

    // Outlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var parrentDropButton = dropDownBtn()
    var products = [Product]()
    var basketProducts = [Product]()
    var totalPrice: Int = 0
    var categorySelected = [Bool](repeating: false, count: ProductService.instance.categorys.count)

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //
    }
    
    // Actions
    @IBAction func agreeButtonPressed(_ sender: RoundedButton) {
        guard totalPrice > 0 || basketProducts.count > 0 else {
            let message = "سفارش شما خالی میباشد ! لطفا سفارش خود را انتخاب کنید."
            UserOrderService.instance.totalPrice = nil
            UserOrderService.instance.products = nil
            presentWarningAlert(message: message)
            return
        }
        UserOrderService.instance.totalPrice = totalPrice
        UserOrderService.instance.products = basketProducts
        performSegue(withIdentifier: TIME_SEGUE, sender: sender)
    }
    
    // Method
    func updateUI() {
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: YEKAN_WEB_FONT, size: 40)!], for: .normal)
        let backButton = UIBarButtonItem(title: "بازگشت", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        backButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: YEKAN_WEB_FONT, size: 16)!], for: .normal)
        navigationItem.backBarButtonItem = backButton
        // Apply blurring effect
        backgroundImageView.image = UIImage(named: "tshirt")
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
        totalPriceLabel.text = String(totalPrice)
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
        parrentDropButton.dropView.dropDownOptions = ProductService.instance.categorys.map { $0.title }
        parrentDropButton.dropView.delegate = self
    }
    
    func dropDownPressed(string: String) {
        parrentDropButton.dismissDropDown()
        parrentDropButton.setTitle(string, for: .normal)
        self.products.removeAll()
        let cat_id = ProductService.instance.findCatId(name: string)
        let products = ProductService.instance.productForCategory(cat: cat_id)
        self.products = products
        self.collectionView.reloadData()
    }
    
    func addButtonPressed(cell: CarServiceCollectionViewCell) {
        if let indexPath = collectionView.indexPath(for: cell) {
            let product = products[indexPath.row]
            totalPrice += product.price
            totalPriceLabel.text = String(totalPrice)
            basketProducts.append(product)
            let index = findCatIndex(categoryName: parrentDropButton.title(for: .normal)!)
            categorySelected[index] = true
            collectionView.reloadData()
            tableView.reloadData()
        }
    }
    
    func deleteButtonpressed(cell: CarServiceTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            basketProducts.remove(at: indexPath.row)
            let removePrice = basketProducts[indexPath.row].price
            totalPrice -= removePrice
            totalPriceLabel.text = String(totalPrice)
            let index = findCatIndex(categoryName: parrentDropButton.title(for: .normal)!)
            categorySelected[index] = false
            collectionView.reloadData()
            tableView.reloadData()
        }
    }
    
    func findCatIndex(categoryName: String) -> Int {
        let names = parrentDropButton.dropView.dropDownOptions
        for (index,name) in names.enumerated() {
            if name == categoryName {
                return index
            }
        }
        
        return 0
    }
    
    func updateButton(button: UIButton) {
        guard products.count > 0 else { return }
        let productCat = products[0].cat
        let categorys = ProductService.instance.categorys
        for category in categorys {
            if category.id == productCat {
                let index = findCatIndex(categoryName: parrentDropButton.title(for: .normal)!)
                if categorySelected[index] {
                    button.isEnabled = false
                } else {
                    button.isEnabled = true
                }
            }
        }
    }
    
    
}


extension CarServiceViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CAR_SERVICE_COLLECTION_CELL, for: indexPath) as! CarServiceCollectionViewCell
        cell.delegate = self
        let product = products[indexPath.row]
        updateButton(button: cell.addButton)
        cell.configureCell(productName: product.title, price: product.price)
        // fetch image
        if let picture = product.picture {
            let imageURL = IMAGE_URL + picture
            if let imageView = cell.imageView {
                imageView.loadImageUsingCache(withUrl: imageURL)
            }
        }
        
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
        
        return basketProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CAR_SERVICE_TABLE_CELL, for: indexPath) as! CarServiceTableViewCell
        cell.delegate = self
        let product = basketProducts[indexPath.row]
        cell.configureCell(title: product.title, price: product.price)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}






