//
//  RootViewController.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/2/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class RootViewController: UIViewController, NVActivityIndicatorViewable {
    
    var activityIndicatorView: NVActivityIndicatorView?
    let popTransitionAnimator = PopTransitionAnimator()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !UserDefaults.standard.bool(forKey: REGISTER_KEY) {
            presentRegisterViewController()
        } else {
            beginActivityIndicator()
            fetchUserCash()
            fetchPersonalInformation()
        }
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            dismiss(animated: true, completion: {
                if self.presentedViewController != nil {
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
    
    // Objc
    @objc func dismissActivityIndicator() {
        endActivityIndicator()
    }
    
    // Method
    func updateUI() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.dismissActivityIndicator), name: DISMISS_ROOT_INDICATOR_NOTIFI, object: nil)
    }
    
    func presentRegisterViewController() {
        if let registerViewController = storyboard?.instantiateViewController(withIdentifier: REGISTER_VC_ID) as? RegisterViewController {
            self.present(registerViewController, animated: true, completion: nil)
        }
    }
    
    func beginActivityIndicator() {
        let padding: CGFloat = 60.0
        let x = (self.view.frame.width / 2) - (padding / 2)
        let y = (self.view.frame.height / 2) - (padding / 2)
        let frame = CGRect(x: x, y: y, width: padding, height: padding)
        activityIndicatorView = NVActivityIndicatorView(frame: frame, type: NVActivityIndicatorType.circleStrokeSpin, color: .darkGray, padding: padding)
        self.view.addSubview(activityIndicatorView!)
        activityIndicatorView!.startAnimating()
        if WebService.instance.isConnectedToNetwork() {
            self.fetchSettingData()
        } else {
            self.presentInternetConnection()
        }
    }
    
    func endActivityIndicator() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.activityIndicatorView?.stopAnimating()
            self.performSegue(withIdentifier: CUSTOM_SEGUE, sender: nil)
        }
    }
    
    func fetchSettingData() {
        SettingService.instance.fetechStteings { (success) in
            if success {
                if SettingService.instance.systemStatus {
                    print("success fetch setting for user uid: \(UserDataService.instance.uid) & ssid: \(UserDataService.instance.ssid)")
                    self.endActivityIndicator()
                } else {
                    DispatchQueue.main.async {
                        let message = SettingService.instance.systemStatusPM
                        self.presentWarningAlert(message: message)
                    }
                }
            } else {
                print("failed fetch setting for user, can't login to this user !")
                DispatchQueue.main.async {
                    let message = "خطا در دریافت اطلاعات کاربری لطفا با پشتیبان سایت تماس بگیرید !"
                    self.presentWarningAlert(message: message)
                }
            }
        }
    }
    
    func fetchUserCash() {
        BagService.instance.bagCash { (success) in
            if success {
                print("success fetch user cash in \(UserDataService.instance.cash) rials")
            }
        }
    }
    
    func fetchPersonalInformation() {
        PersonalInfromationService.instance.userInformation { (success) in
            if success {
                print("success fetch user information data !")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let toViewController = segue.destination
            toViewController.transitioningDelegate = popTransitionAnimator
    }
    

}
