//
//  UserInfoViewController.swift
//  SimpleTaxi
//
//  Created by Poovarasan K on 23/07/23.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    var userName: String?
    var userPhoneNumber: String?
    var tripDateAndTime: String?
    var userDestination: String?
    var driverName: String?
    
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var phoneNumberLabel: UILabel?
    @IBOutlet weak var tripDateTimeLabel: UILabel?
    @IBOutlet weak var destinationLabel: UILabel?
    @IBOutlet weak var driverNameLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        propertiesToOutlets()
                
    }
    
    func propertiesToOutlets() {
        
        nameLabel?.text = userName
        phoneNumberLabel?.text = userPhoneNumber
        tripDateTimeLabel?.text = tripDateAndTime
        destinationLabel?.text = userDestination
        driverNameLabel?.text = driverName
    }
}
