//
//  ProfileViewController.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/2/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit
import SideMenuController

class ProfileTableViewController: UITableViewController, SideMenuControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Outlet
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var profileImage: CircleImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // Action
    @IBAction func changeImageButtonPressed(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker,animated: true,completion: nil)
    }


    // Method
    func updateUI() {
        sideMenuController?.delegate = self
        navigationController?.delegate = self
        datePicker.locale = Locale.init(identifier: "fa_IR")
        datePicker.calendar = Calendar.init(identifier: .persian)
        
    }
    
    func sideMenuControllerDidHide(_ sideMenuController: SideMenuController) {
        print(#function)
    }
    
    func sideMenuControllerDidReveal(_ sideMenuController: SideMenuController) {
        print(#function)
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImage.image = selectedImage
            dismiss(animated: true, completion: nil)
        }
    }


}
