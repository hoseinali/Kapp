//
//  IndicatorPopupViewController.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/6/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class IndicatorPopupViewController: UIViewController, NVActivityIndicatorViewable {
    
    var activityIndicatorView: NVActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // Objc
    @objc func dismissViewController(_ notif: Notification) {
        endActivityIndicator()
    }

    // Method
    func updateUI() {
        self.showAnimate()
        beginActivityIndicator()
        NotificationCenter.default.addObserver(self, selector: #selector(dismissViewController(_:)), name: DISMISS_INDICATOR_VC_NOTIFI, object: nil)
    }
    
    func beginActivityIndicator() {
        let padding: CGFloat = 37.0
        
        let x = (UIScreen.main.bounds.width / 2) - (padding / 2)
        let y = (UIScreen.main.bounds.height / 2) - (padding / 2)
        let frame = CGRect(x: x, y: y, width: padding, height: padding)
        activityIndicatorView = NVActivityIndicatorView(frame: frame, type: NVActivityIndicatorType.ballPulseSync, color: .darkGray, padding: padding)
        self.view.addSubview(activityIndicatorView!)
        activityIndicatorView!.startAnimating()
    }
    
    func endActivityIndicator() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0) {
            self.activityIndicatorView?.stopAnimating()
            self.removeAnimate()
        }
    }
    

}
