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

class MainViewController: UIViewController, SideMenuControllerDelegate, CLLocationManagerDelegate {
    
    // Outlet
    @IBOutlet weak var addressView: RoundedView!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet fileprivate weak var mapView: GMSMapView!
    @IBOutlet weak var keyboardHeightLayoutConstraint: NSLayoutConstraint!

    let slideDownTransition = SlideDownTransitionAnimator()
    var locationManager = CLLocationManager()
    var userCurrentLocation = CLLocationCoordinate2D()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let geoLong = userCurrentLocation.longitude
        let geoLat = userCurrentLocation.latitude
        print("location in did appear is: \(geoLat),\(geoLong)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("\(#function) -- \(self)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("\(#function) -- \(self)")
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
        guard let text = addressTextField.text, text != "" else {
            let message = "لطفا آدرس خود را وارد کنید !"
            self.presentWarningAlert(message: message)
            return
        }
        presentAlert()
    }
    
    @IBAction func unwindToMainViewController(_ segue: UIStoryboardSegue) {
        //
    }
    
    // Method
    func sideMenuControllerDidHide(_ sideMenuController: SideMenuController) {
        print(#function)
    }
    
    func sideMenuControllerDidReveal(_ sideMenuController: SideMenuController) {
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
            self.startIndicatorAnimate() // *
            self.stopIndicatorAnimate() // *
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.1, execute: { // *
                self.performSegue(withIdentifier: CAR_CHOSEN_SEGUE, sender: nil) // *
            }) // *
            
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
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        let geoLong = userCurrentLocation.longitude
        let geoLat = userCurrentLocation.latitude
        print("location in view load is \(geoLat),\(geoLong)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        mapView.clear()
        let userLocation: CLLocation = locations[0]
        let geoLong = userLocation.coordinate.longitude
        let geoLat = userLocation.coordinate.latitude
        let camera = GMSCameraPosition.camera(withLatitude: geoLat, longitude: geoLong, zoom: 15)
        mapView.camera = camera
        showMarker(position: camera.target)
        locationManager.stopUpdatingLocation()
        print("First response position is \(geoLat),\(geoLong)")
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        mapView.clear()
        showMarker(position: userCurrentLocation)
        let geoLong = userCurrentLocation.longitude
        let geoLat = userCurrentLocation.latitude
        print("Tap position is \(geoLat),\(geoLong)")
        
        return false
    }
    
    func showMarker(position: CLLocationCoordinate2D) {
        let marker = GMSMarker()
        userCurrentLocation = position
        marker.position = position
        marker.isDraggable = true
        marker.map = mapView
        marker.icon = UIImage(named: "marker")?.resizeImage(newWidth: 60.0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == CAR_CHOSEN_SEGUE {
            let destination = segue.destination
            destination.transitioningDelegate = slideDownTransition
        }
    }
    
    
}

extension MainViewController: GMSMapViewDelegate {
    
    // MARK - GMSMarker Dragging
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        // print("position Changed.")
    }
    
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        // print("didBeginDragging")
    }
    
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        // print("didDrag")
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

