//
//  ProfileViewController.swift
//  SimpleTaxi
//
//  Created by Poovarasan K on 19/07/23.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var nearByDriverDetails: DriverDetails?
    let datePicker = UIDatePicker()
    
    @IBOutlet weak var userName: UITextField?
    @IBOutlet weak var userPhoneNumber: UITextField?
    @IBOutlet weak var tripDateAndTime: UITextField?
    @IBOutlet weak var userDestination: UITextField?
    @IBOutlet weak var driverName: UITextField?
    @IBOutlet weak var bookingDateAndTime: UITextField?
    @IBOutlet weak var confirmButton: UIButton?
    @IBOutlet weak var cashButton: UIButton?
    @IBOutlet weak var cardButton: UIButton?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMethod()
        datePickerMethod()
        
        userName?.customTextField()
        userPhoneNumber?.customTextField()
        tripDateAndTime?.customTextField()
        userDestination?.customTextField()
        driverName?.customTextField()
        bookingDateAndTime?.customTextField()
        
    }
    
    @IBAction func confirmButtonAction(_ sender: UIButton) {
        
        guard let userName = userName?.text,
              let userMobileNumber = userPhoneNumber?.text,
              let tripDateAndTime = tripDateAndTime?.text,
              let userDestination = userDestination?.text,
              let driverName = driverName?.text
        else { return }
        
        let userInfoViewController = UserInfoViewController()
        userInfoViewController.userName = userName
        userInfoViewController.userPhoneNumber = userMobileNumber
        userInfoViewController.tripDateAndTime = tripDateAndTime
        userInfoViewController.userDestination = userDestination
        userInfoViewController.driverName = driverName
        
        self.navigationController?.pushViewController(userInfoViewController, animated: true)
    }
    
    
    @IBAction func cashButtonAction(_ sender: UIButton) {
        
        cashButton?.isSelected = true
        cardButton?.isSelected = false
    }
    
    @IBAction func cardButtonAction(_ sender: UIButton) {
        
        cashButton?.isSelected = false
        cardButton?.isSelected = true
    }
    
}

extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        validateTextField()
    }
    
    func validateTextField() {
        let fieldsAreNotEmpty = !(userName?.text?.isEmpty ?? true) &&
        !(userPhoneNumber?.text?.isEmpty ?? true) &&
        !(tripDateAndTime?.text?.isEmpty ?? true) &&
        !(userDestination?.text?.isEmpty ?? true) &&
        !(bookingDateAndTime?.text?.isEmpty ?? true)
        
        confirmButton?.isUserInteractionEnabled = fieldsAreNotEmpty
        confirmButton?.backgroundColor = fieldsAreNotEmpty ? UIColor(hexString: "#34C759") : .gray
    }
}

// MARK: Setup Methods
extension ProfileViewController {
    
    func setupMethod() {
        
        driverName?.text =  nearByDriverDetails?.driverName
        driverName?.isUserInteractionEnabled = false
        
        confirmButton?.backgroundColor = .clear
        confirmButton?.layer.cornerRadius = 15
        confirmButton?.layer.borderWidth = 3
        confirmButton?.layer.borderColor = UIColor.black.cgColor
        
        validateTextField()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        cashButton?.setImage(UIImage(systemName: "circle"), for: .normal)
        cashButton?.setImage(UIImage(systemName: "circle.fill"), for: .selected)
        cashButton?.isSelected = true
        
        cardButton?.setImage(UIImage(systemName: "circle"), for: .normal)
        cardButton?.setImage(UIImage(systemName: "circle.fill"), for: .selected)
    }
    
    static func initViewController(nearByDriverDetails: DriverDetails) -> ProfileViewController {
        
        let profileViewController = ProfileViewController()
        profileViewController.nearByDriverDetails = nearByDriverDetails
        return profileViewController
    }
    
    func datePickerMethod() {
        
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        self.tripDateAndTime?.inputView = datePicker
        self.bookingDateAndTime?.inputView = datePicker
        
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: false)
        
        self.tripDateAndTime?.inputAccessoryView = toolbar
        self.tripDateAndTime?.inputView = datePicker
        
        self.bookingDateAndTime?.inputAccessoryView = toolbar
        self.bookingDateAndTime?.inputView = datePicker
    }
    
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
    }
    
    @objc func datePickerValueChanged() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
        tripDateAndTime?.text = dateFormatter.string(from: datePicker.date)
        bookingDateAndTime?.text = dateFormatter.string(from: datePicker.date)
        
    }
    
    @objc func doneButtonTapped() {
        
        tripDateAndTime?.resignFirstResponder()
        bookingDateAndTime?.resignFirstResponder()
    }
}
