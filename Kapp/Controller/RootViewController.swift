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
        }
        beginActivityIndicator()
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
            self.endActivityIndicator()
        } else {
            self.presentInternetConnection()
        }
    }
    
    func endActivityIndicator() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4) {
            self.activityIndicatorView?.stopAnimating()
            self.performSegue(withIdentifier: CUSTOM_SEGUE, sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let toViewController = segue.destination
            toViewController.transitioningDelegate = popTransitionAnimator
    }
    

}
