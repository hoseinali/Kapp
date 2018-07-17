//
//  ProfileViewController.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/2/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit
import SideMenuController
import CDAlertView

class ProfileTableViewController: UITableViewController, SideMenuControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Outlet
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var profileImage: CircleImage!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var postalCodeTextField: UITextField!
    
    var birthday: Date? {
        get {
            return UserDefaults.standard.value(forKey: BIRTHDAY_KEY) as? Date
        }
        set {
            UserDefaults.standard.set(newValue, forKey: BIRTHDAY_KEY)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // Objc
    @objc func closeTouch() {
        view.endEditing(true)
    }
    
    // Action
    @IBAction func changeImageButtonPressed(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker,animated: true,completion: nil)
    }
    
    @IBAction func agreeButtonPressed(_ sender: RoundedButton) {
        guard let name = nameTextField.text, let address = addressTextField.text, let postalCode = postalCodeTextField.text else { return }
        let birthDayDate = datePicker.date.PersianDate()
        let parameters = ["name":name, "address":address, "birth":birthDayDate, "zippostal":postalCode]
        startIndicatorAnimate()
        PersonalInfromationService.instance.updateUserInformation(withParameters: parameters) { (success) in
            if success {
                self.stopIndicatorAnimate()
                DispatchQueue.main.async {
                    self.birthday = self.datePicker.date
                    self.presentAlert()
                    self.view.endEditing(true)
                }
            } else {
                self.stopIndicatorAnimate()
                DispatchQueue.main.async {
                    let message = "خطا در به روز رسانی اطلاعات لطفا مجددا تلاش کنید !"
                    self.presentWarningAlert(message: message)
                    self.view.endEditing(true)
                }
            }
        }
    }
    
    // Method
    func updateUI() {
        sideMenuController?.delegate = self
        navigationController?.delegate = self
        datePicker.locale = Locale.init(identifier: "fa_IR")
        datePicker.calendar = Calendar.init(identifier: .persian)
        if let media = Media.decode(directory: Media.archiveURL) {
            profileImage.image = UIImage(data: media.data)
        }
        fetchPersonalInformation()
        let touch = UITapGestureRecognizer(target: self, action: #selector(closeTouch))
        self.view.addGestureRecognizer(touch)
    }
    
    func fetchPersonalInformation() {
        startIndicatorAnimate()
        PersonalInfromationService.instance.userInformation { (success) in
            if success {
                print("success fetch profile information")
                self.stopIndicatorAnimate()
                DispatchQueue.main.async {
                    let userInformation = PersonalInfromationService.instance.userInformation
                    self.nameTextField.text = userInformation?.name
                    self.addressTextField.text = userInformation?.address
                    self.postalCodeTextField.text = userInformation?.zippostal
                    if let date = self.birthday {
                        self.datePicker.date = date
                    }
                }
            } else {
                self.stopIndicatorAnimate()
                print("failed fetch profile information")
            }
        }
    }
    
    func presentAlert() {
        let message = "اطلاعات مورد نظر به روز شد !"
        let alert = CDAlertView(title: "توجه", message: message, type: CDAlertViewType.notification)
        alert.titleFont = UIFont(name: YEKAN_WEB_FONT, size: 14)!
        alert.messageFont = UIFont(name: YEKAN_WEB_FONT, size: 13)!
        let done = CDAlertViewAction(title: "باشه", font: UIFont(name: YEKAN_WEB_FONT, size: 12)!, textColor: UIColor.darkGray, backgroundColor: .white) { (action) -> Bool in
            self.fetchPersonalInformation()
            return true
        }
        alert.add(action: done)
        alert.show()
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
            if let media = Media(withImage: selectedImage, forKey: "") {
                Media.encode(save: media, directory: Media.archiveURL) // save^
            }
            dismiss(animated: true, completion: nil)
        }
    }

    

}
