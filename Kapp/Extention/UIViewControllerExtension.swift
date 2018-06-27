//
//  UIViewControllerExtension.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/6/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit
import SBCardPopup
import CDAlertView

extension UIViewController {
    
    func presentInternetConnection() {
        let popupContent = InternetConnectionViewController.create()
        let sbPopup = SBCardPopupViewController(contentViewController: popupContent)
        sbPopup.show(onViewController: self)
    }

    func presentWarningAlert(message: String) {
        let alert = CDAlertView(title: "توجه", message: message, type: CDAlertViewType.notification)
        alert.titleFont = UIFont(name: YEKAN_WEB_FONT, size: 14)!
        alert.messageFont = UIFont(name: YEKAN_WEB_FONT, size: 13)!
        let cancel = CDAlertViewAction(title: "باشه", font: UIFont(name: YEKAN_WEB_FONT, size: 13)!, textColor: UIColor.darkGray, backgroundColor: .white, handler: nil)
        alert.add(action: cancel)
        alert.show()
    }
    
    func startIndicatorAnimate() {
        let indicatorVC = IndicatorPopupViewController()
        self.addChildViewController(indicatorVC)
        indicatorVC.view.frame = self.view.frame
        self.view.addSubview(indicatorVC.view)
        indicatorVC.didMove(toParentViewController: self)
    }

    func stopIndicatorAnimate() {
        NotificationCenter.default.post(name: DISMISS_INDICATOR_VC_NOTIFI, object: nil)
    }
    
    func showAnimate() {
        self.view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        }
    }
    
    func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }) { (finished) in
            if finished {
                self.view.removeFromSuperview()
            }
        }
    }
    
    
    
}
