//
//  MainViewController.swift
//  Kapp
//
//  Created by Sinakhanjani on 4/2/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit
import SideMenuController
import GoogleMaps
import CDAlertView
import GooglePlaces

class MainViewController: UIViewController, SideMenuControllerDelegate, CLLocationManagerDelegate, GMSAutocompleteViewControllerDelegate {
    
    // Outlet
    @IBOutlet weak var addressView: RoundedView!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet fileprivate weak var mapView: GMSMapView!
    @IBOutlet weak var keyboardHeightLayoutConstraint: NSLayoutConstraint!

    let slideDownTransition = SlideDownTransitionAnimator()
    var locationManager = CLLocationManager()
    var centerMapCoordinate = CLLocationCoordinate2D()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let userInformation = PersonalInfromationService.instance.userInformation {
            if userInformation.address != "" {
                addressTextField.text = userInformation.address
            }
        }
    }
    
    var randomColor: UIColor {
        let colors = [UIColor(hue:0.65, saturation:0.33, brightness:0.82, alpha:1.00),
                      UIColor(hue:0.57, saturation:0.04, brightness:0.89, alpha:1.00),
                      UIColor(hue:0.55, saturation:0.35, brightness:1.00, alpha:1.00),
                      UIColor(hue:0.38, saturation:0.09, brightness:0.84, alpha:1.00)]
        let index = Int(arc4random_uniform(UInt32(colors.count)))
        
        return colors[index]
    }
    
    // Action
    @IBAction func agreeButtonPressed(_ sender: RoundedButton) {
        addressTextField.resignFirstResponder()
        guard let address = addressTextField.text, address != "" else {
            let message = "لطفا آدرس خود را وارد کنید !"
            self.presentWarningAlert(message: message)
            return
        }
        presentAlert()
    }
    
    @IBAction func serachGoogleMap(_ sender: Any) {
        let autoComplete = GMSAutocompleteViewController()
        let searchBarTextAttributes: [String : AnyObject] = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.darkGray, NSAttributedStringKey.font.rawValue: UIFont(name: YEKAN_WEB_FONT, size: 18)!]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = searchBarTextAttributes
        let customrAttribute: [NSAttributedStringKey: Any] = [NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.darkGray, NSAttributedStringKey.font: UIFont(name: YEKAN_WEB_FONT, size: 15)!]
        let attributePlaceHolder = NSAttributedString(string: "مکان خود را جستجو کنید...", attributes: customrAttribute)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = attributePlaceHolder
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).setTitleTextAttributes(customrAttribute, for: .normal)
        autoComplete.delegate = self
        self.present(autoComplete, animated: true, completion: nil)
    }
    
    
    @IBAction func unwindToMainViewController(_ segue: UIStoryboardSegue) {
        //
    }
    
    // Method
    func sideMenuControllerDidHide(_ sideMenuController: SideMenuController) {
        print(#function)
    }
    
    func sideMenuControllerDidReveal(_ sideMenuController: SideMenuController) {
        NotificationCenter.default.post(name: UPDATE_MOUNT_NOTIFI, object: nil)
        print(#function)
    }
    
    func mapView(_ mapView: GMSMapView, didTapMyLocation location: CLLocationCoordinate2D) {
        //
    }
    
    func presentAlert() {
        let alert = CDAlertView(title: "توجه", message: "آیا آدرس خود را به روی نقشه به درستی انتخاب کرده اید ؟", type: CDAlertViewType.notification)
        alert.titleFont = UIFont(name: YEKAN_WEB_FONT, size: 14)!
        alert.messageFont = UIFont(name: YEKAN_WEB_FONT, size: 13)!
        let done = CDAlertViewAction(title: "بله", font: UIFont(name: YEKAN_WEB_FONT, size: 12)!, textColor: UIColor.darkGray, backgroundColor: .white) { (action) -> Bool in
            self.startIndicatorAnimate()
            let parameters = ["address": self.addressTextField.text!]
            PersonalInfromationService.instance.updateUserInformation(withParameters: parameters, completion: { (success) in
                if success {
                    self.stopIndicatorAnimate()
                    let userLocation: (lat: String, long: String) = (lat: "\(self.centerMapCoordinate.latitude)",long: "\(self.centerMapCoordinate.longitude)")
                    UserOrderService.instance.userLocation = userLocation
                    DispatchQueue.main.async {
                        let address = self.addressTextField.text!
                        UserOrderService.instance.address = address
                        self.performSegue(withIdentifier: CAR_CHOSEN_SEGUE, sender: nil)
                    }
                } else {
                    self.stopIndicatorAnimate()
                    let message = "خطا در دریافت اطلاعات کاربری !"
                    DispatchQueue.main.async {
                        self.presentWarningAlert(message: message)
                    }
                }
            })

            return true
        }
        let cancel = CDAlertViewAction(title: "خیر", font: UIFont(name: YEKAN_WEB_FONT, size: 13)!, textColor: UIColor.darkGray, backgroundColor: .white, handler: nil)
        alert.add(action: done)
        alert.add(action: cancel)
        alert.show()
    }
    
    func updateUI() {
        view.bindToKeyboard()
        sideMenuController?.delegate = self
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        centerMapCoordinate.longitude = mapView.camera.target.longitude
        centerMapCoordinate.latitude = mapView.camera.target.latitude
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        mapView.clear()
        let userLocation: CLLocation = locations[0]
        let geoLong = userLocation.coordinate.longitude
        let geoLat = userLocation.coordinate.latitude
        let camera = GMSCameraPosition.camera(withLatitude: geoLat, longitude: geoLong, zoom: 15)
        mapView.camera = camera
        locationManager.stopUpdatingLocation()
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        mapView.clear()
        let geoLong = centerMapCoordinate.longitude
        let geoLat = centerMapCoordinate.latitude
        print("Tap position is \(geoLat),\(geoLong)")
        
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == CAR_CHOSEN_SEGUE {
            let destination = segue.destination
            destination.transitioningDelegate = slideDownTransition
        }
    }
    
    //GMSAutocomplete
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 15)
        self.mapView.camera = camera
        self.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        //
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension MainViewController: GMSMapViewDelegate {
    
    // MARK - GMSMarker Dragging
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        let latitude = mapView.camera.target.latitude
        let longitude = mapView.camera.target.longitude
        centerMapCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        print("didBeginDragging")
    }
    
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        print("didDrag")
    }
    
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        let geoLong = marker.position.longitude
        let geoLat = marker.position.latitude
        print("Marker position is \(geoLong), \(geoLat)")
    }
    
     func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        addressTextField.resignFirstResponder()
    }
    
  
    
}

