//
//  MyPlaceAddPlaceTVC.swift
//  dashboardKB
//
//  Created by Mohd Zulhilmi Mohd Zain on 20/04/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import GoogleMaps
import DKImagePickerController

class MyPlaceAddPlaceVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var townTextField: UITextField!
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var postcodeTextField: UITextField!
    @IBOutlet weak var aboutTextview: UITextView!
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBOutlet weak var addMarkerButton: UIButton!
    @IBOutlet weak var addPhotoButton: UIButton!
    
    @IBOutlet weak var photoHolderCollectionView: PhotosHolderVC!
    
    var locationManager = CLLocationManager()
    
    var setZoom: Float = 16.0
    
    var images = [UIImage]()
    
    var menuTableViewController = UITableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureNavBar()
        self.configureLocationManager()
        self.configureMapView()
        self.addDoneButtonOnKeyboard()
        self.configureIBOutlet()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let homeImage = UIImage(named: "ic_home_white")
        let homeButton = UIBarButtonItem(image: homeImage, style: .done, target: self, action: #selector(dismissMyPlace))
        
        self.navigationItem.rightBarButtonItem = homeButton
    }
    
    func dismissMyPlace() {
        
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    func configureNavBar() {
        
        self.navigationController?.navigationBar.barTintColor = DBColorSet.myPlacePrimaryColor
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationItem.title = "Add Place"
    }
    
    //MARK: - Configuration for the IBOutlet
    
    func configureIBOutlet() {
        
        aboutTextview.textColor = .lightGray
        aboutTextview.text = "About"
        aboutTextview.delegate = self
        
        addPhotoButton.addTarget(self, action: #selector(addPhotoButtonTapped(_:)), for: .touchUpInside)
        
        stateLabel.text = "Sila Pilih >"
        stateLabel.isUserInteractionEnabled = true
        stateLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(stateTapped(_:))))
        
        categoryLabel.text = "Sila Pilih >"
        categoryLabel.isUserInteractionEnabled = true
        categoryLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(categoryTapped(_:))))
    }
    
    //MARK: - Setup for the mapView
    
    func configureMapView() {
        
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: 0, longitude: 0, zoom: setZoom)
        mapView.camera = camera
        mapView.delegate = self
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
    }
    
    func configureLocationManager() {
        
        if CLLocationManager.locationServicesEnabled() {
            
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func gotoCoordinate(_ latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: setZoom)
        
        print("latitude \(locationManager.location?.coordinate.latitude) longitude \(locationManager.location?.coordinate.longitude)")
        
        mapView.animate(to: camera)
    }
    
    func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D) {
        
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { (response, error) in
            
            guard error == nil else { return }
            
            if let address = response?.firstResult() {
                
                self.townTextField.text = address.locality
                self.streetTextField.text = address.thoroughfare
                self.postcodeTextField.text = address.postalCode
                
                UIView.animate(withDuration: 0.25, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    //MARK: - Add the done button on the top of keyboard.
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.blackTranslucent
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.nameTextField.inputAccessoryView = doneToolbar
        self.townTextField.inputAccessoryView = doneToolbar
        self.streetTextField.inputAccessoryView = doneToolbar
        self.postcodeTextField.inputAccessoryView = doneToolbar
        self.aboutTextview.inputAccessoryView = doneToolbar
        
    }
    
    func doneButtonAction() {
        
        self.townTextField.resignFirstResponder()
        self.nameTextField.resignFirstResponder()
        self.streetTextField.resignFirstResponder()
        self.postcodeTextField.resignFirstResponder()
        self.aboutTextview.resignFirstResponder()
    }
    
    //MARK: - Function to move up the field when keyboard appeared.
    
    func keyboardWillShow(_ notification: NSNotification) {
        
        print("Keyboard showed!")
        
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height - 30 //Set this value (30) according to your code as i have navigation tool bar for next and prev.
        self.scrollView.contentInset = contentInset
    }
    
    func keyboardWillHide(_ notification: NSNotification) {
        
        let contentInset: UIEdgeInsets = .zero
        self.scrollView.contentInset = contentInset
    }
    
    //MARK: - Function for button to take action
    
    func addPhotoButtonTapped(_ sender: UIButton) {
        
        let picker = DKImagePickerController()
        picker.showsCancelButton = true
        
        picker.didSelectAssets = { assets in
            print("Done select..!")
            print(assets)
            
            self.images.removeAll()
            
            for asset in assets {
                
                asset.fetchImageWithSize(CGSize(width: 300, height: 300), completeBlock: { (image, info) in
                    
                    self.images.append(image!)
                })
            }
            
            if !assets.isEmpty {
                
                self.photoHolderCollectionView.images = self.images
                self.photoHolderCollectionView.reloadData()
            }

        }
        
        picker.didCancel = {
            print("Cancel..!")
        }
        
        self.present(picker, animated: true, completion: nil)
    }
    
    //MARK: - Popover view to show menu for state.
    
    func stateTapped(_ sender: Any) {
        
        let vc = StatesMenuTVC()
        vc.modalPresentationStyle = .popover
        vc.delegates = self
        let popover = vc.popoverPresentationController!
        popover.delegate = self
        
        present(vc, animated: true, completion: nil)
    }
    
    func categoryTapped(_ sender: Any) {
        
        let vc = CategoryMenuTVC()
        
        vc.modalPresentationStyle = .popover
        vc.delegates = self
        
        let popover = vc.popoverPresentationController!
        popover.delegate = self
        
        present(vc, animated: true, completion: nil)

    }
}

extension MyPlaceAddPlaceVC: CLLocationManagerDelegate {
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            
            locationManager.startUpdatingLocation()
            
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("Location initiated")
        
        if let location = locations.last {
            
            let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: setZoom)
            mapView.camera = camera
            
            reverseGeocodeCoordinate(coordinate: location.coordinate)
            
            self.locationManager.stopUpdatingLocation()
            
            print("Location \(location)")
        }
    }
}


extension MyPlaceAddPlaceVC: GMSMapViewDelegate {
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        
        if let locationCoordinate = locationManager.location?.coordinate {
            
            mapView.animate(to: GMSCameraPosition.camera(withTarget: locationCoordinate, zoom: setZoom))
            reverseGeocodeCoordinate(coordinate: locationCoordinate)
            return true
        }
        
        return false
    }
}

extension MyPlaceAddPlaceVC: UIPopoverPresentationControllerDelegate, StatesMenuDelegates, CategoryMenuDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        
        return .fullScreen
    }
    
    func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        
        let navigationController = UINavigationController(rootViewController: controller.presentedViewController)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        navigationController.topViewController?.navigationItem.rightBarButtonItem = doneButton
        navigationController.navigationBar.barTintColor = DBColorSet.myPlacePrimaryColor
        navigationController.navigationBar.tintColor = UIColor.white
        
        return navigationController
    }
    
    func doneTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getStateName(_ state: String) {
        
        if state != "" {
            
            self.stateLabel.text = "\(state) >"
        } else {
            
            self.stateLabel.text = "Sila Pilih >"
        }
    }
    
    func getCategory(_ category: String) {
        
        if category != "" {
           
            self.categoryLabel.text = "\(category) >"
        } else {
            
            self.categoryLabel.text = "Sila Pilih >"
        }
    }
}


//MARK: - Textview Delegates

extension MyPlaceAddPlaceVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.text == "About" || (textView.textColor?.isEqual(UIColor.lightGray))! {
            
            textView.text.removeAll()
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        
        if textView.text.isEmpty {
            
            textView.text = "About"
            textView.textColor = .lightGray
        }
    }
}

























